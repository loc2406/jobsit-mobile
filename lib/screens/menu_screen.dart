import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:jobsit_mobile/cubits/candidate/no_logged_in_state.dart';
import 'package:jobsit_mobile/screens/applied_job_screen.dart';
import 'package:jobsit_mobile/screens/home_screen.dart';
import 'package:jobsit_mobile/screens/saved_job_screen.dart';
import 'package:jobsit_mobile/utils/asset_constants.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';

import 'account_screen.dart';
import 'login_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;
  late final CandidateCubit _cubit;

  List<Widget> screens = [
    const HomeScreen(),
    const AppliedJobScreen(),
    const SavedJobScreen(),
    const AccountScreen()
  ];

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CandidateCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.grayBackground,
        child: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: TextConstants.home),
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_repair_service_outlined),
              label: TextConstants.applied),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetConstants.iconBookmark, width: 24, height: 24, colorFilter: ColorFilter.mode(_currentIndex == 2 ? ColorConstants.main : Colors.black, BlendMode.srcIn),),
              label: TextConstants.saved),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetConstants.iconProfile, width: 24, height: 24, colorFilter: ColorFilter.mode(_currentIndex == 3 ? ColorConstants.main : Colors.black, BlendMode.srcIn),),
              label: TextConstants.saved),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {

          if(_cubit.state is NoLoggedInState){
            if ((index == 2 || index == 3) && _currentIndex != index){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
            }
          }

          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: ColorConstants.main,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
