import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey();
  bool _isSaveLoginState = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ValueConstants.screenHeight * 0.02,
          horizontal: ValueConstants.screenWidth * 0.03),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(TextConstants.logoLoginAsset),
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
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            TextConstants.email,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorConstants.main)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12)),
                        ),
                        SizedBox(
                          height: ValueConstants.screenHeight * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            TextConstants.password,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.visibility_sharp,
                                color: ColorConstants.main,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorConstants.main)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12)),
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
                const SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 32)),
                            backgroundColor:
                                WidgetStatePropertyAll(ColorConstants.main),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))))),
                        onPressed: null,
                        child: Text(
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
                        "HOẶC",
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
    );
  }
}
