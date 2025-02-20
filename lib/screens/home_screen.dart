import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/cubits/job/empty_state.dart';
import 'package:jobsit_mobile/cubits/job/job_cubit.dart';
import 'package:jobsit_mobile/cubits/job/job_state.dart';
import 'package:jobsit_mobile/cubits/job/loaded_state.dart';
import 'package:jobsit_mobile/cubits/job/loading_state.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';
import 'package:jobsit_mobile/utils/widget_constants.dart';
import 'package:jobsit_mobile/widgets/job_item.dart';

import '../cubits/job/error_state.dart';
import '../utils/asset_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final JobCubit _cubit;
  bool isInitializeData = false;
  final _searchController = TextEditingController();
  var _jobs = [];
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<JobCubit>();
    _getJobs(page: _page);
  }

  Future<void> _getJobs({required int page}) async {
    await _cubit.getJobs(page: page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(
            margin: EdgeInsets.only(left: ValueConstants.screenWidth * 0.06),
            child: Image.asset(
              AssetConstants.logoHome,
            ),
          ),
          leadingWidth: ValueConstants.screenWidth * 0.35,
          actions: [
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                        BorderSide(color: ColorConstants.main, width: 2)),
                    borderRadius: BorderRadius.all(Radius.circular(200))),
                child: const Icon(Icons.person, color: ColorConstants.main),
              ),
            ),
            SizedBox(
              width: ValueConstants.screenWidth * 0.06,
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ValueConstants.screenHeight * 0.04,
              horizontal: ValueConstants.screenWidth * 0.06),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _searchController,
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
                  SizedBox(
                      width: ValueConstants.deviceWidthValue(uiValue: 8)),
                  GestureDetector(
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
              Expanded(child: BlocBuilder<JobCubit, JobState>(builder: (context, state) {
                if (state is ErrorState) {
                  return Center(
                    child: Text(state.errMessage),
                  );
                } else if (state is EmptyState) {
                  return const Center(
                    child: Text(TextConstants.noDataMess),
                  );
                } else if (state is LoadedState) {
                  _jobs = state.jobs;
                  _page = state.page;

                  return _buildJobList();
                } else {
                  return const Center(child: WidgetConstants.circularProgress);
                }
              }))
            ],
          ),
        ));
  }

  Widget _buildJobList() {
    return ListView.builder(
      itemBuilder: (context, index) => JobItem(job: _jobs[index]),
      itemCount: _jobs.length,
    );
  }
}
