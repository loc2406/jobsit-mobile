import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:http/http.dart' as http;
import 'package:jobsit_mobile/cubits/job/apply_success_state.dart';
import 'package:jobsit_mobile/utils/convert_constants.dart';
import 'package:jobsit_mobile/utils/exceptions/AppliedJobBeforeException.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';

import '../../models/candidate.dart';
import '../../models/job.dart';
import '../../models/province.dart';
import '../../services/base_services.dart';
import '../../services/candidate_services.dart';
import '../../services/job_services.dart';
import '../../services/province_services.dart';
import 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  JobCubit() : super(JobState.loading());

  final _limit = 5;

  Future<List<Province>> getProvinces() async {
    try {
      final provinces = await ProvinceServices.getProvinces();
      return provinces;
    } catch (e) {
      debugPrint(e.toString());
      return [];
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

  Future<void> applyJob({required String token, required File cvFile, required String letter, required int idJob}) async {
    try{
      await JobServices.applyJob(token: token, cvFile: cvFile, letter: letter, idJob: idJob);
      emit(JobState.applySuccess());
    }catch (e) {
      if (e is AppliedJobBeforeException){
        emit(JobState.error(TextConstants.youAreAppliedThisJobMessage));
      }
      debugPrint(e.toString());
    }
  }

  Future<void> getOtherJobs(int no, Job job) async {
    try{
      final data = await JobServices.getOtherJobs(no: no, companyId: job.companyId, limit: _limit);

      final contents = data[JobServices.contentsKey];
      final isLastPage = data[JobServices.lastKey] == true;

      final otherJobs = ConvertConstants.convertToListJobs(contents);

      // emit(JobState.viewDetail(job, otherJobs, no, isLastPage));
    }catch (e) {
      debugPrint(e.toString());
    }
  }
}
