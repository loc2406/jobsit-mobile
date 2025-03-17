import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:jobsit_mobile/cubits/candidate/login_success_state.dart';
import 'package:jobsit_mobile/cubits/candidate/no_logged_in_state.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/save_job_success_state.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/saved_job_state.dart';

import '../cubits/saved_jobs/delete_job_success.dart';
import '../cubits/saved_jobs/empty_state.dart';
import '../cubits/saved_jobs/error_state.dart';
import '../cubits/saved_jobs/loaded_state.dart';
import '../cubits/saved_jobs/saved_job_cubit.dart';
import '../models/job.dart';
import '../utils/text_constants.dart';
import '../utils/value_constants.dart';
import '../utils/widget_constants.dart';
import '../widgets/job_item.dart';

class SavedJobScreen extends StatefulWidget {
  const SavedJobScreen({super.key});

  @override
  State<SavedJobScreen> createState() => _SavedJobScreenState();
}

class _SavedJobScreenState extends State<SavedJobScreen> {
  late final CandidateCubit _candidateCubit;
  late final SavedJobCubit _savedJobCubit;
  final PagingController<int, Job> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _candidateCubit = context.read<CandidateCubit>();
    _savedJobCubit = context.read<SavedJobCubit>();

    _pagingController.addPageRequestListener((pageKey) async {
      final state = _candidateCubit.state;
      if (state is LoginSuccessState) {
        await _getSavedJobs(token: state.token, no: pageKey);
      }
    });

    if (_candidateCubit.state is LoginSuccessState) {
      _pagingController.refresh();
    }
  }

  Future<void> _getSavedJobs({required String token, required int no}) async {
    await _savedJobCubit.getSavedJobs(token: token, no: no);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text(
            TextConstants.savedJob,
            style: WidgetConstants.mainBold16Style,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CandidateCubit, CandidateState>(
            builder: (context, state) {
          if (state is NoLoggedInState) {
            return const Center(
              child: Text(TextConstants.noData,
                  style: WidgetConstants.black16Style),
            );
          }

          return _buildSavedJob();
        }));
  }

  Widget _buildSavedJob() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ValueConstants.deviceWidthValue(uiValue: 25),
          vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: MultiBlocListener(listeners: [
              BlocListener<CandidateCubit, CandidateState>(
                  listener: (context, state) {
                if (state is NoLoggedInState) {
                  _pagingController.itemList = [];
                } else if (state is LoginSuccessState) {
                  _pagingController.refresh();
                }
              }),
              BlocListener<SavedJobCubit, SavedJobsState>(
                listener: (context, state) {
                  if (state is LoadedState) {
                    if (state.isLastPage) {
                      _pagingController.appendLastPage(state.savedJobs);
                    } else {
                      _pagingController.appendPage(
                          state.savedJobs, state.page + 1);
                    }
                  } else if (state is ErrorState) {
                    _pagingController.error = state.errMessage;
                  } else if (state is EmptyState) {
                    _pagingController.itemList = [];
                  } else if (state is SaveJobSuccessState ||
                      state is DeleteJobSuccessState) {
                    _pagingController.itemList = [];
                  }
                },
              ),
            ], child: _buildJobList()),
          ),
        ],
      ),
    );
  }

  Widget _buildJobList() {
    return PagedListView<int, Job>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Job>(
          itemBuilder: (context, job, index) => JobItem(
                job: job,
                onIconBookmarkClicked: () async {
                  await _savedJobCubit.deleteJob(job.jobId,
                      (_candidateCubit.state as LoginSuccessState).token);
                },
              ),
          newPageProgressIndicatorBuilder: (_) => const Center(
                child: WidgetConstants.circularProgress,
              ),
          noItemsFoundIndicatorBuilder: (context) => const Center(
                child: Text(TextConstants.noData,
                    style: WidgetConstants.black16Style),
              )),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
