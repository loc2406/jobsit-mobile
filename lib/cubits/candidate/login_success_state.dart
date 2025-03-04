import 'package:jobsit_mobile/models/candidate.dart';

import 'candidate_state.dart';

class LoginSuccessState extends CandidateState{

  final String token;
  final Candidate candidate;

  const LoginSuccessState(this.token, this.candidate);
}