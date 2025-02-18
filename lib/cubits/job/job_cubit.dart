import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:http/http.dart' as http;
import 'package:jobsit_mobile/utils/text_constants.dart';

import '../../models/candidate.dart';
import '../../services/base_services.dart';
import '../../services/candidate_services.dart';
import '../../services/job_services.dart';
import 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  JobCubit() : super(JobState.loading());

  final limit = 5;

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
}
