import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobsit_mobile/cubits/job/empty_state.dart';
import 'package:jobsit_mobile/cubits/job/job_cubit.dart';
import 'package:jobsit_mobile/cubits/job/job_state.dart';
import 'package:jobsit_mobile/cubits/job/loaded_state.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';
import 'package:jobsit_mobile/utils/widget_constants.dart';
import 'package:jobsit_mobile/widgets/filter_bottom_sheet.dart';
import 'package:jobsit_mobile/widgets/job_item.dart';

import '../cubits/job/error_state.dart';
import '../models/job.dart';
import '../models/province.dart';
import '../utils/asset_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final JobCubit _cubit;
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
    _cubit = context.read<JobCubit>();
    _getProvinces();
    _pagingController.addPageRequestListener((pageKey) async {
      await _getJobs(pageKey);
    });
  }

  Future<void> _getProvinces() async {
    final provinces = await _cubit.getProvinces();
    setState(() {
      _provinces = provinces;
    });
  }

  Future<void> _getJobs(int no) async {
    await _cubit.getJobs(
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
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
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
                decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                        BorderSide(color: ColorConstants.main, width: 2)),
                    borderRadius: BorderRadius.all(Radius.circular(200))),
                child: const Icon(Icons.person, color: ColorConstants.main),
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
                child: BlocListener<JobCubit, JobState>(
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
                  child: _buildJobList(),
                ),
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
            itemBuilder: (context, job, index) => JobItem(job: job),
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
}
