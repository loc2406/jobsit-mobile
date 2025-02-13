import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/color_constants.dart';
import '../utils/text_constants.dart';
import '../utils/value_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ValueConstants.screenHeight * 0.02,
          horizontal: ValueConstants.screenWidth * 0.03),
      color: Colors.white,
      child: SingleChildScrollView(child: Column(
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
          const Text(TextConstants.REGISTER,
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
                        SizedBox(
                          height: ValueConstants.screenHeight * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            TextConstants.confirmPassword,
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
                        SizedBox(
                          height: ValueConstants.screenHeight * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            TextConstants.firstAndLastName,
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
                            TextConstants.name,
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
                            TextConstants.phone,
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
                      ],
                    )),
                SizedBox(
                  height: ValueConstants.screenHeight * 0.02,
                ),
                const Text(TextConstants.registerNote, style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
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
                          TextConstants.REGISTER,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ))),
                SizedBox(
                  height: ValueConstants.screenHeight * 0.04,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(TextConstants.alreadyHaveAccount,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                    SizedBox(width: 10,),
                    Text(
                      TextConstants.loginNow,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.main),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),),
    );
  }
}
