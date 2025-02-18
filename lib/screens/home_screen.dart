import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/cubits/job/empty_state.dart';
import 'package:jobsit_mobile/cubits/job/job_cubit.dart';
import 'package:jobsit_mobile/cubits/job/job_state.dart';
import 'package:jobsit_mobile/cubits/job/loaded_state.dart';
import 'package:jobsit_mobile/cubits/job/loading_state.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/widget_constants.dart';
import 'package:jobsit_mobile/widgets/job_item.dart';

import '../cubits/job/error_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final JobCubit _cubit;
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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: TextConstants.searchJob,
                hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13, fontStyle: FontStyle.italic),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: Icon(
                  Icons.search,
                  color: ColorConstants.main,
                ),
                focusedBorder: WidgetConstants.inputFieldBorder,
                enabledBorder: WidgetConstants.inputFieldBorder),
          ),
          BlocBuilder<JobCubit, JobState>(builder: (context, state){
            if (state is ErrorState){
              return Center(child: Text(state.errMessage),);
            }else if (state is EmptyState){
              return const Center(child: Text(TextConstants.noDataMess),);
            }else if (state is LoadedState){
              _jobs = state.jobs;
              _page = state.page;

              return _buildJobList();
            }else{
              return WidgetConstants.circularProgress;
            }
          })
        ],
      ),
    );
  }

  Widget _buildJobList(){
    return Expanded(child: ListView.builder(itemBuilder: (context, index) => JobItem(job: _jobs[index]), itemCount: _jobs.length,));
  }
}
