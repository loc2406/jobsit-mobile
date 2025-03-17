import 'package:jobsit_mobile/cubits/applied_jobs/applied_job_state.dart';
import 'package:jobsit_mobile/models/job.dart';

class LoadedState extends AppliedJobState {
  final List<Job> appliedJobs;
  final bool  isLastPage;
  final int page;

  LoadedState({required this.appliedJobs, required this.isLastPage, required this.page});
}
