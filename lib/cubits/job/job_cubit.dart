import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:jobsit_mobile/utils/convert_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';

import '../../services/base_services.dart';
import '../../services/job_services.dart';
import 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  JobCubit() : super(JobState.loading());

  final _limit = 5;

  List<String> _provinces = [];
  List<String> provinces() => _provinces;

  getProvinces() async {
    emit(JobState.loading());
    final response = await http.get(Uri.parse(BaseServices.provincesApi));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      _provinces = data.map((e) => e[JobServices.nameKey].toString()).toList();
    } else {
      emit(JobState.error(TextConstants.loadProvincesFailedError));
    }
  }

  Future<void> getJobs(
      {String name = '',
      String provinceName = '',
      String schedule = '',
      String position = '',
      String major = '',
      required int no}) async {

    emit(JobState.loading());

    try {
      final response = await JobServices.getJobs(
          name: name,
          provinceName: provinceName,
          schedule: schedule,
          position: position,
          major: major,
          no: no,
          limit: _limit);

      final contents = response[JobServices.contentsKey];
      final isLastPage = response[JobServices.lastKey] == true;

      final jobs = ConvertConstants.convertToListJobs(contents);

      if (jobs.isEmpty) {
        emit(JobState.empty());
      } else {
        emit(JobState.loaded(
          jobs: jobs,
          page: no,
          name: name,
          isLastPage: isLastPage,
          location: provinceName,
          schedule: schedule,
          position: position,
          major: major,
        ));
      }
    } catch (e) {
      emit(JobState.error(e.toString()));
    }
  }
}
