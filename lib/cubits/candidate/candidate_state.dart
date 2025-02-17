import 'package:jobsit_mobile/cubits/candidate/active_state.dart';
import 'package:jobsit_mobile/cubits/candidate/register_success_state.dart';
import 'package:jobsit_mobile/cubits/candidate/send_otp_success_state.dart';
import 'package:jobsit_mobile/cubits/candidate/login_success_state.dart';
import 'package:jobsit_mobile/models/candidate.dart';

import 'active_success_state.dart';
import 'error_state.dart';
import 'init_state.dart';
import 'loading_state.dart';
import 'no_logged_in_state.dart';

class CandidateState {
  const CandidateState();

  factory CandidateState.init() => InitState();

  factory CandidateState.loading() => LoadingState();

  factory CandidateState.registerSuccess() => RegisterSuccessState();

  factory CandidateState.sendOtpSuccess() => SendOtpSuccessState();

  factory CandidateState.activeSuccess() => ActiveSuccessState();

  factory CandidateState.active() => ActiveState();

  factory CandidateState.loginSuccess(String token, int candidateId) => LoginSuccessState(token, candidateId);

  factory CandidateState.error(String errorMessage) => ErrorState(errorMessage);

  factory CandidateState.noLoggedIn() => NoLoggedInState();
}