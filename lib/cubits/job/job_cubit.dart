import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:http/http.dart' as http;
import 'package:jobsit_mobile/services/province_services.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';

import '../../models/candidate.dart';
import '../../models/province.dart';
import '../../services/base_services.dart';
import '../../services/candidate_services.dart';
import '../../services/job_services.dart';
import 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  JobCubit() : super(JobState.loading());

  final limit = 5;
  List<String> _provinces = [];
  List<String> provinces() => _provinces;
  Future<void> getJobs(
      {required int page}) async {
    try {
      final jobs = await JobServices.getJob(page: page, limit: limit);
      if (jobs.isEmpty){
        emit(JobState.empty());
      }else{
        emit(JobState.loaded(jobs, page));
      }
    } catch (e) {
      emit(JobState.error(e.toString()));
    }
  }
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
}
