import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/cubits/job/job_cubit.dart';
import 'package:jobsit_mobile/screens/active_account_screen.dart';

import 'package:jobsit_mobile/screens/forgot_password_screen.dart';
import 'package:jobsit_mobile/screens/login_screen.dart';
import 'package:jobsit_mobile/screens/menu_screen.dart';
import 'package:jobsit_mobile/screens/splash_screen.dart';
import 'package:jobsit_mobile/screens/test.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ValueConstants.initScreenSize(context);

    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => CandidateCubit()),
      BlocProvider(create: (context) => JobCubit()),
    ], child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.main),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    ));
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return const SplashScreen();
    //return const ForgotPasswordScreen();
     //return const ActiveAccountScreen();
     //return const MenuScreen();
  //  return const SaveImageScreen();

  }
}
