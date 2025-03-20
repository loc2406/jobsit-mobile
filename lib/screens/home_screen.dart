import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobsit_mobile/cubits/candidate/login_success_state.dart';
import 'package:jobsit_mobile/cubits/candidate/no_logged_in_state.dart';
import 'package:jobsit_mobile/cubits/job/empty_state.dart';
import 'package:jobsit_mobile/cubits/job/job_cubit.dart';
import 'package:jobsit_mobile/cubits/job/job_state.dart';
import 'package:jobsit_mobile/cubits/job/loaded_state.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/delete_job_success.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/save_job_success_state.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/saved_job_state.dart';
import 'package:jobsit_mobile/screens/login_screen.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';
import 'package:jobsit_mobile/utils/widget_constants.dart';
import 'package:jobsit_mobile/widgets/filter_bottom_sheet.dart';
import 'package:jobsit_mobile/widgets/job_item.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../cubits/candidate/candidate_cubit.dart';
import '../cubits/job/error_state.dart';
import '../cubits/saved_jobs/saved_job_cubit.dart';
import '../models/job.dart';
import '../models/province.dart';
import '../utils/asset_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final JobCubit _jobCubit;
  late final CandidateCubit _candidateCubit;
  late final SavedJobCubit _savedJobCubit;
  List<Province> _provinces = [];
  final _searchController = TextEditingController();
  final PagingController<int, Job> _pagingController =
      PagingController(firstPageKey: 0);
  String _selectedLocation = '';
  String _selectedSchedule = '';
  String _selectedPosition = '';
  String _selectedMajor = '';

  @override
  void initState() {
    super.initState();
    _jobCubit = context.read<JobCubit>();
    _candidateCubit = context.read<CandidateCubit>();
    _savedJobCubit = context.read<SavedJobCubit>();
    _getProvinces();
    _pagingController.addPageRequestListener((pageKey) async {
      await _getJobs(pageKey);
    });
  }

  Future<void> _getProvinces() async {
    final provinces = await _jobCubit.getProvinces();
    setState(() {
      _provinces = provinces;
    });
  }

  Future<void> _getJobs(int no) async {
    await _jobCubit.getJobs(
        name: _searchController.text,
        provinceName: _selectedLocation,
        schedule: _selectedSchedule,
        position: _selectedPosition,
        major: _selectedMajor,
        no: no);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: Container(
            margin: EdgeInsets.only(
                left: ValueConstants.deviceWidthValue(uiValue: 25)),
            child: Image.asset(
              AssetConstants.logoHome,
            ),
          ),
          leadingWidth: ValueConstants.deviceWidthValue(uiValue: 143),
          actions: [
            GestureDetector(
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                        BorderSide(color: ColorConstants.main, width: 2)),),
                child: ClipOval(child: Image.asset(AssetConstants.iconVN, fit: BoxFit.cover,),),
              ),
            ),
            SizedBox(
              width: ValueConstants.deviceWidthValue(uiValue: 25),
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(
            left: ValueConstants.deviceWidthValue(uiValue: 25),
            top: ValueConstants.deviceHeightValue(uiValue: 25),
            right: ValueConstants.deviceWidthValue(uiValue: 25),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _searchController,
                    onChanged: (keyword) => handleFilterJobs(),
                    decoration: const InputDecoration(
                        hintText: TextConstants.searchJob,
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: Icon(
                          Icons.search,
                          color: ColorConstants.main,
                        ),
                        focusedBorder: WidgetConstants.searchBorder,
                        enabledBorder: WidgetConstants.searchBorder),
                  )),
                  SizedBox(width: ValueConstants.deviceWidthValue(uiValue: 8)),
                  GestureDetector(
                    onTap: showFilter,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          border: Border.fromBorderSide(BorderSide(
                            color: ColorConstants.main,
                          ))),
                      child: SvgPicture.asset(AssetConstants.iconFilter),
                    ),
                  )
                ],
              ),
              Expanded(
                child: MultiBlocListener(listeners: [
                  BlocListener<JobCubit, JobState>(
                    listener: (context, state) {
                      if (state is LoadedState) {
                        _selectedLocation = state.location;
                        _selectedSchedule = state.schedule;
                        _selectedPosition = state.position;
                        _selectedMajor = state.major;

                        if (state.isLastPage) {
                          _pagingController.appendLastPage(state.jobs);
                        } else {
                          _pagingController.appendPage(
                              state.jobs, state.page + 1);
                        }
                      } else if (state is ErrorState) {
                        _pagingController.error = state.errMessage;
                      } else if (state is EmptyState) {
                        _pagingController.itemList = [];
                      }
                    },
                    child: const SizedBox(),
                  ),
                  BlocListener<SavedJobCubit, SavedJobsState>(listener: (context, state){
                    if (state is SaveJobSuccessState){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(TextConstants.saveJobSuccessful)));
                    }else if (state is DeleteJobSuccessState){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(TextConstants.deleteJobSuccessful)));
                    }
                  })
                ], child: _buildJobList()),
              ),
            ],
          ),
        ));
  }

  Widget _buildJobList() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ValueConstants.deviceWidthValue(uiValue: 15)),
      child: PagedListView<int, Job>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Job>(
            itemBuilder: (context, job, index){
              return JobItem(job: job, onIconBookmarkClicked: () async => await handleIcBookmarkClicked(job),);
            },
            newPageProgressIndicatorBuilder: (_) => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: WidgetConstants.circularProgress,
                  ),
                ),
            noItemsFoundIndicatorBuilder: (context) {
              if (_searchController.text.isEmpty || _selectedLocation.isEmpty) {
                return const Center(
                  child: Text(
                    TextConstants.notFindJobMess,
                    style: WidgetConstants.mainBold16Style,
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    TextConstants.noMatchingJobAtThisTimeMess,
                    style: WidgetConstants.mainBold16Style,
                  ),
                );
              }
            }),
      ),
    );
  }

  void showFilter() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(
              children: [
                FilterBottomSheet(
                  provinces: _provinces,
                  selectedLocation: _selectedLocation,
                  selectedSchedule: _selectedSchedule,
                  selectedPosition: _selectedPosition,
                  selectedMajor: _selectedMajor,
                  onApply: (location, schedule, position, major) async {
                    _selectedLocation = location;
                    _selectedSchedule = schedule;
                    _selectedPosition = position;
                    _selectedMajor = major;

                    await handleFilterJobs();
                  },
                )
              ],
            ));
  }

  Future<void> handleFilterJobs() async {
    _pagingController.itemList = [];
    _getJobs(0);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> handleIcBookmarkClicked(Job job) async {
    if (_candidateCubit.state is NoLoggedInState){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      return;
    }

    if (_candidateCubit.state is LoginSuccessState){
      final candidateToken = (_candidateCubit.state as LoginSuccessState).token;
      final isSaved = _savedJobCubit.allSavedJobs().any((j)=> j.jobId == job.jobId);

      if (!isSaved){
        await _savedJobCubit.saveJob(job.jobId, candidateToken);
      }else{
        await _savedJobCubit.deleteJob(job.jobId, candidateToken);
      }
    }
  }
}
