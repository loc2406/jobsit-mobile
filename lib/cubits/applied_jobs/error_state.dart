import 'package:jobsit_mobile/cubits/applied_jobs/applied_job_state.dart';

class ErrorState extends AppliedJobState {
  final String errMessage;

  const ErrorState(this.errMessage);
}
