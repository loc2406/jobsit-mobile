import 'package:jobsit_mobile/cubits/saved_jobs/delete_job_success.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/empty_state.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/error_state.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/loaded_state.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/loading_state.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/save_job_success_state.dart';

import '../../models/job.dart';

class SavedJobsState {
  const SavedJobsState();

  factory SavedJobsState.empty() => EmptyState();

  factory SavedJobsState.loading() => LoadingState();

  factory SavedJobsState.loaded({required List<Job> savedJobs, required bool isLastPage, required int page}) =>
      LoadedState(savedJobs: savedJobs, isLastPage: isLastPage, page: page);

  factory SavedJobsState.saveSuccess() => SaveJobSuccessState();

  factory SavedJobsState.deleteSuccess() => DeleteJobSuccessState();

  factory SavedJobsState.error(String errorMessage) => ErrorState(errorMessage);
}
