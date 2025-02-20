import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/cubits/candidate/init_state.dart';
import 'package:jobsit_mobile/screens/home_screen.dart';
import 'package:jobsit_mobile/screens/saved_work_screen.dart';
import 'package:jobsit_mobile/utils/asset_constants.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/widget_constants.dart';

import 'account_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const SavedWorkScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: ColorConstants.grayBackground,child: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: TextConstants.home),
          BottomNavigationBarItem(icon: Icon(Icons.home_repair_service_outlined), label: TextConstants.applied),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border_rounded), label: TextConstants.saved),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: TextConstants.account),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
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
