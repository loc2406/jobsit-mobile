import 'package:jobsit_mobile/cubits/job/job_state.dart';

import '../../models/job.dart';

class ViewDetailState extends JobState{
  final Job job;
  final List<Job> otherJobs;
  final int page;
  final bool isLastPage;

  ViewDetailState(this.job, this.otherJobs, this.page, this.isLastPage);
}