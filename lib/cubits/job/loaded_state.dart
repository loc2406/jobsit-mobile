import 'package:jobsit_mobile/cubits/job/job_state.dart';
import 'package:jobsit_mobile/models/job.dart';

class LoadedState extends JobState {
  final List<Job> jobs;
  final int page;
  final String name;
  final String location;
  final bool isLastPage;
  final Map<String, dynamic> schedule;
  final Map<String, dynamic> position;
  final Map<String, dynamic> major;

  LoadedState(
      {required this.jobs,
      required this.page,
      required this.name,
      required this.isLastPage,
      required this.location,
      required this.schedule,
      required this.position,
      required this.major});
}
