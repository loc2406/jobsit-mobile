import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:jobsit_mobile/cubits/applied_jobs/applied_job_state.dart';
import 'package:jobsit_mobile/cubits/applied_jobs/applied_job_success_state.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/cubits/candidate/login_success_state.dart';
import 'package:jobsit_mobile/cubits/candidate/no_logged_in_state.dart';
import 'package:jobsit_mobile/cubits/saved_jobs/saved_job_cubit.dart';
import 'package:jobsit_mobile/screens/login_screen.dart';
import 'package:jobsit_mobile/services/job_services.dart';
import 'package:jobsit_mobile/utils/asset_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';
import 'package:jobsit_mobile/utils/widget_constants.dart';
import 'package:jobsit_mobile/widgets/apply_bottom_sheet.dart';

import '../cubits/applied_jobs/applied_job_cubit.dart';
import '../cubits/applied_jobs/error_state.dart';
import '../cubits/job/job_cubit.dart';
import '../cubits/job/job_state.dart';
import '../cubits/saved_jobs/saved_job_state.dart';
import '../models/job.dart';
import '../utils/color_constants.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({super.key});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  late Job _job;
  bool _isGetData = false;
  String _selectedTab = TextConstants.description;
  late SavedJobCubit _savedJobCubit;
  late CandidateCubit _candidateCubit;
  late JobCubit _jobCubit;
  bool _isSaved = false;
  PagingController _otherJobsController =PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _savedJobCubit = context.read<SavedJobCubit>();
    _candidateCubit = context.read<CandidateCubit>();
    _jobCubit = context.read<JobCubit>();
  }

  void _getOtherJobs(int no, Job job){
    _jobCubit.getOtherJobs(no, job);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isGetData) {
      _job = ModalRoute.of(context)!.settings.arguments as Job;
      _isSaved = _savedJobCubit.allSavedJobs().any((j) => j.jobId == _job.jobId);
      _otherJobsController.addPageRequestListener((pageKey){
        _getOtherJobs(pageKey, _job);
      });
      _isGetData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppliedJobCubit, AppliedJobState>(
        listener: (context, state) {
          if (state is AppliedJobSuccessState) {
            WidgetConstants.showSnackBar(context: this.context, message: TextConstants.applySuccessful);
          }else if (state is ErrorState){
            WidgetConstants.showSnackBar(context: this.context, message: state.errMessage);
          }
        }, child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          TextConstants.jobDetail,
          style: WidgetConstants.mainBold16Style,
        ),
        centerTitle: true,
        leading: const SizedBox(),
        actions: [
          GestureDetector(
            onTap: () async {
              if (_candidateCubit.state is NoLoggedInState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                return;
              }

              if (_candidateCubit.state is LoginSuccessState) {
                if (_isSaved) {
                  await _savedJobCubit.deleteJob(_job.jobId,
                      (_candidateCubit.state as LoginSuccessState).token);
                } else {
                  await _savedJobCubit.saveJob(_job.jobId,
                      (_candidateCubit.state as LoginSuccessState).token);
                }

                setState(() {
                  _isSaved = !_isSaved;
                });
              }
            },
            child: BlocBuilder<SavedJobCubit, SavedJobsState>(
              builder: (context, state) {
                final isSaved = _savedJobCubit
                    .allSavedJobs()
                    .any((job) => job.jobId == _job.jobId);
                return Icon(
                  isSaved
                      ? CupertinoIcons.bookmark_fill
                      : CupertinoIcons.bookmark,
                  color: ColorConstants.main,
                );
              },
            ),
          ),
          const SizedBox(
            width: 25,
          )
        ],
      ),
      body: _buildBody(),
    ),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: ValueConstants.screenWidth,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(), // Thêm hiệu ứng cuộn mượt
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ValueConstants.deviceWidthValue(uiValue: 24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 15)),

                    Container(
                      alignment: Alignment.center,
                      width: ValueConstants.deviceWidthValue(uiValue: 86),
                      height: ValueConstants.deviceWidthValue(uiValue: 86),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: ColorConstants.main),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _job.companyLogo != null
                          ? Image.network(
                        '${JobServices.displayJobLogoUrl}${_job.companyLogo}',
                        width: ValueConstants.deviceWidthValue(uiValue: 86),
                        height: ValueConstants.deviceWidthValue(uiValue: 86),
                        errorBuilder: (context, object, stacktrace) => _buildDefaultLogo(),
                      )
                          : _buildDefaultLogo(),
                    ),
                    SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 15)),

                    Text(
                      _job.jobName,
                      style: WidgetConstants.main22Style,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 10)),

                    Text(
                      textAlign: TextAlign.center,
                      _job.companyName,
                      style: WidgetConstants.black16Style,
                      softWrap: true,
                    ),

                    SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 10)),

                    SvgPicture.asset(AssetConstants.iconLocation),
                    SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 10)),
                    Text(
                      textAlign: TextAlign.center,
                      _job.location,
                      softWrap: true,
                      style: WidgetConstants.black16Style,
                    ),

                    SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 10)),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _buildJobPositionsList(),
                      ),
                    ),

                    SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 30)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildJobSubDetail(
                            asset: AssetConstants.iconProfile,
                            title: TextConstants.position,
                            content: _job.positions.isNotEmpty
                                ? _job.positions[0].name
                                : TextConstants.dontHave),
                        _buildJobSubDetail(
                            asset: AssetConstants.iconBag,
                            title: TextConstants.type,
                            content: _job.schedules.isNotEmpty
                                ? _job.schedules[0].name
                                : TextConstants.dontHave),
                        _buildJobSubDetail(
                            asset: AssetConstants.iconSalary,
                            title: TextConstants.salary,
                            content:
                            '\$${_job.salaryMin}k - \$${_job.salaryMax}k'),
                        _buildJobSubDetail(
                            asset: AssetConstants.iconCalendar,
                            title: TextConstants.deadline,
                            content: DateFormat(TextConstants.defaultDate)
                                .format(DateTime.parse(_job.endDate).toLocal()))
                      ],
                    ),

                    Container(
                      width: ValueConstants.screenWidth,
                      margin: EdgeInsets.only(top: ValueConstants.deviceHeightValue(uiValue: 30)),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          _buildJobDetailTab(TextConstants.description),
                          _buildJobDetailTab(TextConstants.company),
                        ],
                      ),
                    ),

                    SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 30)),
                    
                    SizedBox(
                      width: ValueConstants.screenWidth,
                      child: _selectedTab == TextConstants.description
                          ? _buildJobDescription()
                          : _buildCompanyOverview(),
                    ),

                    SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 30)), // Đảm bảo không bị che mất nội dung cuối
                  ],
                ),
              ),
            ),
          ),
          
          Container(
            width: ValueConstants.screenWidth,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: showApplyBottomSheet,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: ColorConstants.main,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  TextConstants.apply,
                  style: WidgetConstants.whiteBold16Style,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildDefaultLogo() {
    return const Icon(
      Icons.image_outlined,
      size: 24,
      color: ColorConstants.main,
    );
  }

  List<Container> _buildJobPositionsList() {
    return _job.positions
        .map((position) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                position.name,
                style: WidgetConstants.black12Style,
              ),
            ))
        .toList();
  }

  Widget _buildJobSubDetail(
      {required String asset, required String title, required String content}) {
    return Column(
      children: [
        Container(
          width: ValueConstants.deviceWidthValue(uiValue: 47),
          height: ValueConstants.deviceWidthValue(uiValue: 47),
          padding: const EdgeInsets.all(10),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: SvgPicture.asset(
            asset,
            width: ValueConstants.deviceWidthValue(uiValue: 24),
            height: ValueConstants.deviceWidthValue(uiValue: 24),
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 11),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          content,
          style: WidgetConstants.black12Style,
          softWrap: true,
        ),
      ],
    );
  }

  Widget _buildJobDetailTab(String title) {
    return Expanded(
        child: GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: _selectedTab == title
                ? Border.all(
                    color: Colors.white,
                    strokeAlign: BorderSide.strokeAlignOutside)
                : null,
            borderRadius: _selectedTab == title
                ? const BorderRadius.all(Radius.circular(8))
                : null,
            color: _selectedTab == title ? Colors.white : Colors.transparent),
        child: Text(
          title,
          style: WidgetConstants.blackBold12Style,
        ),
      ),
      onTap: () {
        setState(() {
          _selectedTab = title;
        });
      },
    ));
  }

  Widget _buildJobDescription() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            TextConstants.jobDescription,
            style: WidgetConstants.blackBold16Style,
          ),
          SizedBox(
            height: ValueConstants.deviceHeightValue(uiValue: 33),
          ),
          Text(
            _job.jobDescription,
            style: WidgetConstants.black14Style,
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyOverview() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            TextConstants.companyOverview,
            style: WidgetConstants.blackBold16Style,
          ),
          SizedBox(
            height: ValueConstants.deviceHeightValue(uiValue: 33),
          ),
          Text(
            _job.companyDescription,
            style: WidgetConstants.black14Style,
          ),
          SizedBox(
            height: ValueConstants.deviceHeightValue(uiValue: 33),
          ),
          const Text(
            TextConstants.companyAddress,
            style: WidgetConstants.blackBold16Style,
          ),
          SizedBox(
            height: ValueConstants.deviceHeightValue(uiValue: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(AssetConstants.iconLocation),
              SizedBox(
                width: ValueConstants.deviceWidthValue(uiValue: 5),
              ),
              Expanded(
                child: Text(
                  _job.location,
                  style: WidgetConstants.black14Style,
                  softWrap: true,
                ),
              ),
            ],
          ),
          SizedBox(
            height: ValueConstants.deviceHeightValue(uiValue: 16),
          ),
          const Text(
            TextConstants.otherJobs,
            style: WidgetConstants.blackBold16Style,
          ),
        ],
      ),
    );
  }

  void showApplyBottomSheet() {
    if (_candidateCubit.state is NoLoggedInState) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      return;
    }

    showModalBottomSheet(
        context: context,
        builder: (context) => ApplyBottomSheet(jobId: _job.jobId));
  }
}
