import 'package:jobsit_mobile/cubits/job/error_state.dart';
import 'package:jobsit_mobile/cubits/job/empty_state.dart';
import 'package:jobsit_mobile/cubits/job/loaded_state.dart';
import 'package:jobsit_mobile/cubits/job/loading_state.dart';

import '../../models/job.dart';

class JobState {
  const JobState();

  factory JobState.empty() => EmptyState();

  factory JobState.loading() => LoadingState();

  factory JobState.loaded(List<Job> jobs, int page) => LoadedState(jobs, page);

  factory JobState.error(String errorMessage) => ErrorState(errorMessage);
}
