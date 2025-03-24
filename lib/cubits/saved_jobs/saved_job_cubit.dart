import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/loading_state.dart';

import '../../models/job.dart';
import '../../services/job_services.dart';
import '../../utils/convert_constants.dart';
import 'saved_job_state.dart';

class SavedJobCubit extends Cubit<SavedJobsState> {
  SavedJobCubit() : super(SavedJobsState.loading());

  final int _limit = 5;
  List<Job> _savedJobs = [];

  List<Job> allSavedJobs() => _savedJobs;

  void clearAllSavedJobs(){
    _savedJobs = [];
    emit(SavedJobsState.empty());
  }

  getSavedJobs({required String token, required int no}) async {
    emit(SavedJobsState.loading());
    try {
      final response =
      await JobServices.getSavedJobs(token: token, no: no, limit: _limit);

      final contents = response[JobServices.contentsKey];
      final isLastPage = response[JobServices.lastKey] == true;

      final savedJobs = ConvertConstants.convertToListSavedJobs(contents);

      //debugPrint("GỌI API LẤY CÔNG VIỆC ĐÃ LƯU TRANG: $no, SỐ LƯỢNG: ${savedJobs.length}");

      if (no == 0) {
        _savedJobs.clear();
      }

      if (savedJobs.isEmpty) {
        emit(SavedJobsState.empty());
      } else {
        _savedJobs.addAll(savedJobs);
        emit(SavedJobsState.loaded(savedJobs: List.from(_savedJobs), page: no, isLastPage: isLastPage));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  saveJob(int jobId, String token) async {
    emit(SavedJobsState.loading());
    try {
      await JobServices.saveJob(jobId: jobId, token: token);
      _savedJobs.clear();
      await getSavedJobs(token: token, no: 0);
      emit(SavedJobsState.saveSuccess());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  deleteJob(int jobId, String token) async {
    emit(SavedJobsState.loading());
    try {
      await JobServices.deleteJob(jobId: jobId, token: token);
      _savedJobs.clear();
      await getSavedJobs(token: token, no: 0);
      emit(SavedJobsState.deleteSuccess());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
