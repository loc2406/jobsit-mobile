import 'package:jobsit_mobile/cubits/job/job_state.dart';
import 'package:jobsit_mobile/models/job.dart';

class LoadedState extends JobState{

  final List<Job> jobs;
  final int page;

  LoadedState(this.jobs, this.page);
}