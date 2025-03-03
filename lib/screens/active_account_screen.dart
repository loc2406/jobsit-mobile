import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/cubits/candidate/active_success_state.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:jobsit_mobile/cubits/candidate/error_state.dart';
import 'package:jobsit_mobile/cubits/candidate/loading_state.dart';
import 'package:jobsit_mobile/cubits/candidate/register_success_state.dart';
import 'package:jobsit_mobile/screens/login_screen.dart';
import 'package:jobsit_mobile/utils/asset_constants.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/validate_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';
import 'package:jobsit_mobile/utils/widget_constants.dart';
import 'package:jobsit_mobile/widgets/input_field.dart';

class ActiveAccountScreen extends StatefulWidget {
  const ActiveAccountScreen({super.key});

  @override
  State<ActiveAccountScreen> createState() => _ActiveAccountScreenState();
}

class _ActiveAccountScreenState extends State<ActiveAccountScreen> {
  late final CandidateCubit _cubit;
  String? _email;
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CandidateCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _email ??= ModalRoute.of(context)!.settings.arguments.toString();
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
            vertical: ValueConstants.deviceHeightValue(uiValue: 18) ,
            horizontal: ValueConstants.deviceWidthValue(uiValue: 12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              TextConstants.verifyEmail,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24),
            ),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 8),
            ),
            const Text(
              TextConstants.pleaseInputOTPInEmail,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            ),
            SizedBox(
                height: ValueConstants.deviceHeightValue(uiValue: 8)
            ),
            Form(
              key: _formKey,
              child: InputField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  validateMethod: ValidateConstants.validateOtp),
            ),
            SizedBox(
                height: ValueConstants.deviceHeightValue(uiValue: 16)
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
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                              vertical: 12, horizontal: 32)),
                          backgroundColor:
                              WidgetStatePropertyAll(ColorConstants.main),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))))),
                      onPressed: verifyEmail,
                      child: const Text(
                        TextConstants.VERIFY_EMAIL,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                      )));
            }, listener: (context, state) {
              if (state is ActiveSuccessState) {
                  Navigator.pop(context);
              } else if (state is ErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errMessage)));
              }
            }),
            SizedBox(
                height: ValueConstants.deviceHeightValue(uiValue: 16)
            ),
            GestureDetector(
              onTap: sendOtpAgain,
              child: const Text.rich(TextSpan(
                  text: TextConstants.dontReceiveOTP,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                        text: TextConstants.sendOTPAgain,
                        style: TextStyle(
                            color: ColorConstants.main,
                            fontSize: 13,
                            fontWeight: FontWeight.w400))
                  ])),
            )
          ],
        ),
      )),
    );
  }

  Future<void> verifyEmail() async {
    if ((_formKey.currentState as FormState).validate()) {
      await _cubit.sendOtpToActiveAccount(_otpController.text);
    }
  }

  Future<void> sendOtpAgain() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text(TextConstants.sentOtpMess)));
    await _cubit.sendActiveEmail(_email!);
  }
}
