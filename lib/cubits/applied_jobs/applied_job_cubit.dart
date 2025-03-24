import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/job.dart';
import '../../services/job_services.dart';
import '../../utils/convert_constants.dart';
import '../../utils/exceptions/AppliedJobBeforeException.dart';
import '../../utils/text_constants.dart';
import 'applied_job_state.dart';

class AppliedJobCubit extends Cubit<AppliedJobState> {
  AppliedJobCubit() : super(AppliedJobState.loading());

  final int _limit = 5;
  List<Job> _appliedJobs = [];

  List<Job> allAppliedJobs() => _appliedJobs;

  void clearAllAppliedJobs(){
    _appliedJobs = [];
    emit(AppliedJobState.empty());
  }

  Future<void> applyJob({required String token, required File cvFile, required String letter, required int idJob}) async {
    try{
      await JobServices.applyJob(token: token, cvFile: cvFile, letter: letter, idJob: idJob);
      emit(AppliedJobState.applySuccess());
      getAppliedJobs(token: token, no: 0);
    }catch (e) {
      if (e is AppliedJobBeforeException){
        emit(AppliedJobState.error(TextConstants.youAreAppliedThisJobMessage));
      }
      debugPrint(e.toString());
    }
  }

  getAppliedJobs({required String token, required int no}) async {
    emit(AppliedJobState.loading());
    try {
      final response =
          await JobServices.getAppliedJobs(token: token, no: no, limit: _limit);

      final contents = response[JobServices.contentsKey];
      final isLastPage = response[JobServices.lastKey] == true;

      final appliedJobs = ConvertConstants.convertToListAppliedJobs(contents);

      if (appliedJobs.isEmpty) {
        emit(AppliedJobState.empty());
      } else {
        if (no == 0){
          _appliedJobs = [];
        }

        _appliedJobs.addAll(appliedJobs);
        emit(AppliedJobState.loaded(appliedJobs: appliedJobs, page: no, isLastPage: isLastPage));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(AppliedJobState.error(TextConstants.getAppliedJobError));
    }
  }
}
