import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/widget_constants.dart';

class InputField extends StatelessWidget {
  final IconData? suffixIcon;
  final void Function()? suffixIconClicked;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isObscure;
  final String? Function(String?) validateMethod;

  const InputField({super.key,
    required this.controller,
    required this.keyboardType,
    required this.validateMethod,
    this.isObscure = false,
    this.suffixIcon,
    this.suffixIconClicked});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        suffixIcon: suffixIcon != null ? IconButton(
          icon: Icon(suffixIcon,
            color: ColorConstants.main,),
          onPressed: suffixIconClicked,
        ) : null,
        enabledBorder: WidgetConstants.inputFieldBorder,
        focusedBorder: WidgetConstants.inputFieldBorder,
        errorBorder: WidgetConstants.inputFieldBorder,
        focusedErrorBorder: WidgetConstants.inputFieldBorder,
      ),
      validator: validateMethod,
      keyboardType: keyboardType,
      obscureText: isObscure,
    );
  }
}
