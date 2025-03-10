import 'package:jobsit_mobile/cubits/job/job_state.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/saved_job_state.dart';
import 'package:jobsit_mobile/models/job.dart';

class LoadedState extends SavedJobsState {
  final List<Job> savedJobs;
  final bool  isLastPage;
  final int page;

  LoadedState({required this.savedJobs, required this.isLastPage, required this.page});
}
