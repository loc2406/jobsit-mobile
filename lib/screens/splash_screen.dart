import 'package:flutter/material.dart';
import 'package:jobsit_mobile/screens/active_account_screen.dart';
import 'package:jobsit_mobile/screens/login_screen.dart';
import 'package:jobsit_mobile/screens/register_screen.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';

import '../utils/value_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _isShowingDialog = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isShowingDialog ?ColorConstants.main : Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
              child: Image.asset(
            TextConstants.splashLogoAsset,
            width: ValueConstants.screenWidth * 0.85,
            height: ValueConstants.screenHeight * 0.1,
          )),
          Expanded(
              child: Column(
            children: [
              const Text(
                TextConstants.splashTitle,
                style: TextStyle(
                    color: ColorConstants.splashTitle,
                    fontSize: 36,
                    fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 33,
                    top: ValueConstants.screenHeight * 0.02,
                    right: 33),
                child: const Text(
                  textAlign: TextAlign.center,
                  TextConstants.splashContent,
                  style: TextStyle(
                      color: ColorConstants.splashContent,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 20,
                    top: ValueConstants.screenHeight * 0.03,
                    right: 20),
                child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 32)),
                            backgroundColor:
                                WidgetStatePropertyAll(ColorConstants.main),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))))),
                        onPressed: showRegisterDialog,
                        child: const Text(
                          TextConstants.registerAccount,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 20,
                    top: ValueConstants.screenHeight * 0.02,
                    right: 20),
                child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 32)),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    side:
                                        BorderSide(color: ColorConstants.main),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))))),
                        onPressed: showLoginDialog,
                        child: const Text(
                          TextConstants.haveAccountBefore,
                          style: TextStyle(
                              color: ColorConstants.main,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ))),
              ),
            ],
          ))
        ],
      ),
    );
  }

  void showLoginDialog() {
    setState(() {
      _isShowingDialog = true;
    });
    showModalBottomSheet(
      isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: ValueConstants.screenHeight * 0.85), // dialog hiển thị sẽ có chiều cao tối đa bằng 90% chiều cao màn hình
        barrierColor: _isShowingDialog ? Colors.transparent : null, // Không làm tối nền phía sau
      shape: const RoundedRectangleBorder(borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context, builder: (context) => const LoginScreen()).whenComplete((){
      setState(() {
        _isShowingDialog = false;
      });
    });
  }

  void showRegisterDialog() {
    setState(() {
      _isShowingDialog = true;
    });
    showModalBottomSheet(
        isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: ValueConstants.screenHeight * 0.85), // dialog hiển thị sẽ có chiều cao tối đa bằng 90% chiều cao màn hình
        barrierColor: _isShowingDialog ? Colors.transparent : null, // Không làm tối nền phía sau
        shape: const RoundedRectangleBorder(borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context, builder: (context) => const RegisterScreen()).whenComplete((){
      setState(() {
        _isShowingDialog = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ActiveAccountScreen()));
    });
  }
}
