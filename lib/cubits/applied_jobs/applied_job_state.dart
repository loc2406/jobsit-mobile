import 'package:jobsit_mobile/cubits/applied_jobs/applied_job_success_state.dart';
import 'package:jobsit_mobile/cubits/applied_jobs/empty_state.dart';
import 'package:jobsit_mobile/cubits/applied_jobs/error_state.dart';
import 'package:jobsit_mobile/cubits/applied_jobs/loaded_state.dart';
import 'package:jobsit_mobile/cubits/applied_jobs/loading_state.dart';

import '../../models/job.dart';

class AppliedJobState {
  const AppliedJobState();

  factory AppliedJobState.empty() => EmptyState();

  factory AppliedJobState.loading() => LoadingState();

  factory AppliedJobState.loaded({required List<Job> appliedJobs, required bool isLastPage, required int page}) =>
      LoadedState(appliedJobs: appliedJobs, isLastPage: isLastPage, page: page);

  factory AppliedJobState.applySuccess() => AppliedJobSuccessState();

  factory AppliedJobState.error(String errorMessage) => ErrorState(errorMessage);
}
