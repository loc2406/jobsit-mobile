
import 'saved_job_state.dart';

class ErrorState extends SavedJobsState{

  final String errMessage;

  const ErrorState(this.errMessage);
}