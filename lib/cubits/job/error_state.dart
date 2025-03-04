
import 'job_state.dart';

class ErrorState extends JobState{

  final String errMessage;

  const ErrorState(this.errMessage);
}