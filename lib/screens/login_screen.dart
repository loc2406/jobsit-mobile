import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/validate_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';
import 'package:jobsit_mobile/utils/widget_constants.dart';
import 'package:jobsit_mobile/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey();
  bool _isShowPass = false;
  bool _isSaveLoginState = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      padding: EdgeInsets.symmetric(
          vertical: ValueConstants.screenHeight * 0.02,
          horizontal: ValueConstants.screenWidth * 0.03),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  TextConstants.logoLoginAsset,
                  width: ValueConstants.screenWidth * 0.24,
                  height: ValueConstants.screenHeight * 0.03,
                ),
                Row(
                  children: [
                    IconButton(
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: ColorConstants.main,
                        )),
                  ],
                )
              ],
            ),
            const Text(TextConstants.LOGIN,
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.main)),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text.rich(TextSpan(
                                text: TextConstants.email,
                                children: [
                                  TextSpan(
                                      text: '*',
                                      style:
                                      WidgetConstants.inputFieldRequireStyle)
                                ],
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15))),
                          ),
                          InputField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validateMethod: ValidateConstants.validateEmailLogin),
                          SizedBox(
                            height: ValueConstants.screenHeight * 0.02,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text.rich(TextSpan(
                                text: TextConstants.password,
                                children: [
                                  TextSpan(
                                      text: '*',
                                      style:
                                      WidgetConstants.inputFieldRequireStyle)
                                ],
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15))),
                          ),
                          InputField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validateMethod: ValidateConstants.validatePasswordLogin,
                            suffixIcon: _isShowPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixIconClicked: () {
                              setState(() {
                                _isShowPass = !_isShowPass;
                              });
                            },
                            isObscure: _isShowPass ? false : true,
                          ),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _isSaveLoginState,
                            onChanged: (value) {
                              setState(() {
                                _isSaveLoginState = !_isSaveLoginState;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: ColorConstants.main,
                            side: const BorderSide(
                                color: ColorConstants.main, width: 2),
                          ),
                          const Text(
                            TextConstants.saveLoginState,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      const Text(
                        TextConstants.forgotPassword,
                        style: TextStyle(
                            color: ColorConstants.main,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorConstants.main),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ValueConstants.screenHeight * 0.04,
                  ),
                  SizedBox(
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
                          onPressed: handleLogin,
                          child: const Text(
                            TextConstants.LOGIN,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ))),
                  SizedBox(
                    height: ValueConstants.screenHeight * 0.05,
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: ColorConstants.divider,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          TextConstants.OR,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.divider,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: ColorConstants.divider,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ValueConstants.screenHeight * 0.05,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          style: const ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 32)),
                              backgroundColor: WidgetStatePropertyAll(
                                  ColorConstants.btnLoginGoogle),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4))))),
                          onPressed: null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(TextConstants.iconGgLoginAsset),
                              const SizedBox(
                                width: 6,
                              ),
                              const Text(
                                TextConstants.LOGIN_WITH_GOOGLE,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ))),
                  SizedBox(
                    height: ValueConstants.screenHeight * 0.02,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          style: const ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 32)),
                              backgroundColor: WidgetStatePropertyAll(
                                  ColorConstants.btnLoginFb),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4))))),
                          onPressed: null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(TextConstants.iconFbLoginAsset),
                              const SizedBox(
                                width: 6,
                              ),
                              const Text(
                                TextConstants.LOGIN_WITH_FB,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ))),
                  SizedBox(
                    height: ValueConstants.screenHeight * 0.02,
                  ),
                  const Text(TextConstants.dont_have_account,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
                  SizedBox(
                    height: ValueConstants.screenHeight * 0.02,
                  ),
                  const Text(
                    TextConstants.Register,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.main),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleLogin() {
    if ((_formKey.currentState as FormState).validate()) {

    }
  }
}
