import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:jobsit_mobile/cubits/candidate/error_state.dart';
import 'package:jobsit_mobile/cubits/candidate/loading_state.dart';
import 'package:jobsit_mobile/cubits/candidate/login_success_state.dart';
import 'package:jobsit_mobile/screens/register_screen.dart';
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
  late final CandidateCubit _cubit;
  final _formKey = GlobalKey();
  bool _isShowPass = false;
  bool _isSaveLoginState = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = context.read<CandidateCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.main,
      appBar: AppBar(
        backgroundColor: ColorConstants.main,
        leading: const SizedBox(),
      ),
      body: SizedBox.expand(
          child: Container(
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
                              child: Text(TextConstants.email, style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15)),
                            ),
                            InputField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validateMethod:
                                    ValidateConstants.validateEmailLogin),
                            SizedBox(
                              height: ValueConstants.screenHeight * 0.02,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(TextConstants.password, style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15)),
                            ),
                            InputField(
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              validateMethod:
                                  ValidateConstants.validatePasswordLogin,
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
                    BlocConsumer<CandidateCubit, CandidateState>(
                        builder: (context, state) {
                      if (state is LoadingState) {
                        return WidgetConstants.circularProgress;
                      }

                      return SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              style: const ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 32)),
                                  backgroundColor: WidgetStatePropertyAll(
                                      ColorConstants.main),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))))),
                              onPressed: handleLogin,
                              child: const Text(
                                TextConstants.LOGIN,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              )));
                    }, listener: (context, state) {
                      if (state is LoginSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(TextConstants.loginSuccessful)));
                      } else if (state is ErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errMessage)));
                      }
                    }),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))))),
                            onPressed: null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    TextConstants.iconGgLoginAsset),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))))),
                            onPressed: null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    TextConstants.iconFbLoginAsset),
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
                    const Text(TextConstants.dontHaveAccount,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                    GestureDetector(child: TextButton(
                        style: null,
                        onPressed: navigateRegisterScreen,
                        child: const Text(
                          TextConstants.Register,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.main),
                        )),)
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<void> handleLogin() async {
    if ((_formKey.currentState as FormState).validate()) {
      await _cubit.loginAccount(
          email: _emailController.text, password: _passwordController.text);
    }
  }

  void navigateRegisterScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }
}
