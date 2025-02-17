import 'package:jobsit_mobile/cubits/candidate/active_state.dart';
import 'package:jobsit_mobile/cubits/candidate/success_state.dart';
import 'package:jobsit_mobile/models/candidate.dart';

import 'error_state.dart';
import 'init_state.dart';
import 'loading_state.dart';
import 'no_logged_in_state.dart';

class CandidateState {
  const CandidateState();

  factory CandidateState.init() => InitState();

  factory CandidateState.loading() => LoadingState();

  factory CandidateState.active() => ActiveState();

  factory CandidateState.success(Candidate candidate) => SuccessState(candidate);

  factory CandidateState.error(String errorMessage) => ErrorState(errorMessage);

  factory CandidateState.noLoggedIn() => NoLoggedInState();
}