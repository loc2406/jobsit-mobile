import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/screens/active_account_screen.dart';
import 'package:jobsit_mobile/screens/login_screen.dart';

import '../cubits/candidate/candidate_state.dart';
import '../cubits/candidate/error_state.dart';
import '../cubits/candidate/loading_state.dart';
import '../cubits/candidate/register_success_state.dart';
import '../utils/color_constants.dart';
import '../utils/text_constants.dart';
import '../utils/validate_constants.dart';
import '../utils/value_constants.dart';
import '../utils/widget_constants.dart';
import '../widgets/input_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final CandidateCubit _cubit;
  final _formKey = GlobalKey();
  bool _isShowPass = false;
  bool _isShowConfirmPass = false;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = context.read<CandidateCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.main,
      appBar: AppBar(backgroundColor: ColorConstants.main, leading: const SizedBox(),),
      body: SizedBox.expand(child: Container(
        padding: EdgeInsets.symmetric(
            vertical: ValueConstants.screenHeight * 0.02,
            horizontal: ValueConstants.screenWidth * 0.03),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
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
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text.rich(TextSpan(
                                  text: TextConstants.email,
                                  children: [
                                    TextSpan(
                                        text: '*',
                                        style: WidgetConstants
                                            .inputFieldRequireStyle)
                                  ],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15))),
                            ),
                            InputField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validateMethod: ValidateConstants.validateEmailRegister,
                            ),
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
                                        style: WidgetConstants
                                            .inputFieldRequireStyle)
                                  ],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15))),
                            ),
                            InputField(
                              controller: _passController,
                              keyboardType: TextInputType.visiblePassword,
                              validateMethod: ValidateConstants.validatePasswordRegister,
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
                            SizedBox(
                              height: ValueConstants.screenHeight * 0.02,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text.rich(TextSpan(
                                  text: TextConstants.confirmPassword,
                                  children: [
                                    TextSpan(
                                        text: '*',
                                        style: WidgetConstants
                                            .inputFieldRequireStyle)
                                  ],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15))),
                            ),
                            InputField(
                              controller: _confirmPassController,
                              keyboardType: TextInputType.visiblePassword,
                              validateMethod: (confirmPass) => ValidateConstants.validateConfirmPassword(_passController.text, confirmPass),
                              suffixIcon: _isShowConfirmPass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              suffixIconClicked: () {
                                setState(() {
                                  _isShowConfirmPass = !_isShowConfirmPass;
                                });
                              },
                              isObscure: _isShowConfirmPass ? false : true,
                            ),
                            SizedBox(
                              height: ValueConstants.screenHeight * 0.02,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text.rich(TextSpan(
                                  text: TextConstants.firstAndLastName,
                                  children: [
                                    TextSpan(
                                        text: '*',
                                        style: WidgetConstants
                                            .inputFieldRequireStyle)
                                  ],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15))),
                            ),
                            InputField(
                              controller: _firstNameController,
                              keyboardType: TextInputType.text,
                              validateMethod: ValidateConstants.validateFirstName,
                            ),
                            SizedBox(
                              height: ValueConstants.screenHeight * 0.02,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text.rich(TextSpan(
                                  text: TextConstants.name,
                                  children: [
                                    TextSpan(
                                        text: '*',
                                        style: WidgetConstants
                                            .inputFieldRequireStyle)
                                  ],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15))),
                            ),
                            InputField(
                              controller: _lastNameController,
                              keyboardType: TextInputType.name,
                              validateMethod: ValidateConstants.validateLastName,
                            ),
                            SizedBox(
                              height: ValueConstants.screenHeight * 0.02,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text.rich(TextSpan(
                                  text: TextConstants.phone,
                                  children: [
                                    TextSpan(
                                        text: '*',
                                        style: WidgetConstants
                                            .inputFieldRequireStyle)
                                  ],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15))),
                            ),
                            InputField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              validateMethod: ValidateConstants.validatePhone,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: ValueConstants.screenHeight * 0.02,
                    ),
                    const Text(
                      TextConstants.registerNote,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: ValueConstants.screenHeight * 0.04,
                    ),
                    BlocConsumer<CandidateCubit, CandidateState>(builder: (context, state){
                      if (state is LoadingState){
                        return WidgetConstants.circularProgress;
                      }

                      return SizedBox(
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))))),
                              onPressed: handleBtnRegisterClicked,
                              child: const Text(
                                TextConstants.REGISTER,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              )));
                    }, listener: (context, state){
                      if (state is RegisterSuccessState){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(TextConstants.registerSuccessful)));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ActiveAccountScreen(), settings: RouteSettings(arguments: state.email)),
                        );
                      }else if (state is ErrorState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errMessage)));
                      }
                    }),
                    SizedBox(
                      height: ValueConstants.screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(TextConstants.alreadyHaveAccount,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                      GestureDetector(child: TextButton(
                          style: null,
                          onPressed: navigateLoginScreen,
                          child: const Text(
                            TextConstants.loginNow,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.main),
                          )),)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),),
    );
  }

  Future<void> handleBtnRegisterClicked() async {
    if ((_formKey.currentState as FormState).validate()){
      await _cubit.createCandidate(
        email: _emailController.text,
        password: _passController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phone: _phoneController.text,
      );

      await _cubit.sendActiveEmail(_emailController.text);
    }
  }

  void navigateLoginScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
