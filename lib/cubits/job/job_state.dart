import 'package:jobsit_mobile/cubits/job/error_state.dart';
import 'package:jobsit_mobile/cubits/job/empty_state.dart';
import 'package:jobsit_mobile/cubits/job/loaded_state.dart';
import 'package:jobsit_mobile/cubits/job/loading_state.dart';
import 'package:jobsit_mobile/cubits/job/view_detail_state.dart';

import '../../models/job.dart';

class JobState {
  const JobState();

  factory JobState.empty() => EmptyState();

  factory JobState.loading() => LoadingState();

  factory JobState.loaded(
          {required List<Job> jobs,
          required int page,
          required String name,
          required bool isLastPage,
          required String location,
          required String schedule,
          required String position,
          required String major}) =>
      LoadedState(
          jobs: jobs,
          page: page,
          name: name,
          isLastPage: isLastPage,
          location: location,
          schedule: schedule,
          position: position,
          major: major);

  factory JobState.error(String errorMessage) => ErrorState(errorMessage);

  factory JobState.viewDetail(
          Job job, List<Job> otherJobs, int page, bool isLastPage) =>
      ViewDetailState(job, otherJobs, page, isLastPage);
}
