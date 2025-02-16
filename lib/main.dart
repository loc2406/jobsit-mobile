import 'package:flutter/material.dart';
import 'package:jobsit_mobile/screens/change_passwork.dart';
import 'package:jobsit_mobile/screens/login_screen.dart';
import 'package:jobsit_mobile/screens/splash_screen.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';

// void main() {
//   runApp(const MyApp());
// }
void main() {
  runApp(const ChangePasswordApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    ValueConstants.init(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
