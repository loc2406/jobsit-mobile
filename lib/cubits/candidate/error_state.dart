import 'package:jobsit_mobile/models/candidate.dart';

import 'candidate_state.dart';

class ErrorState extends CandidateState{

  final String errMessage;

  const ErrorState(this.errMessage);
}