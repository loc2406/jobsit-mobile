import 'package:jobsit_mobile/utils/text_constants.dart';

class ValidateConstants{
  static String? validateEmailLogin(String? email){
    if (email == null || email.trim().isEmpty){
      return TextConstants.pleaseInputEmail;
    }

    final RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    );

    final isValidLength = email.length >= 6 && email.length <= 256;

    if (!emailRegex.hasMatch(email) || !isValidLength){
      return TextConstants.emailOrPasswordIncorrect;
    }

    return null;
  }

  static String? validatePasswordLogin(String? password){
    if (password == null || password.trim().isEmpty){
      return TextConstants.pleaseInputPassword;
    }

    return null;
  }

  static String? validateEmailRegister(String? email){
    if (email == null || email.trim().isEmpty){
      return TextConstants.pleaseInputEmail;
    }

    final isValidMinLength = email.length >= 6;
    if (!isValidMinLength){
      return TextConstants.pleaseInputMin6Digits;
    }

    final isValidMaxLength = email.length <= 256;
    if (!isValidMaxLength){
      return TextConstants.pleaseInputMax256Digits;
    }

    final RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    );

    if (!emailRegex.hasMatch(email)){
      return TextConstants.emailIncorrect;
    }

    return null;
  }

  static String? validatePasswordRegister(String? password){
    if (password == null || password.trim().isEmpty){
      return TextConstants.pleaseInputPassword;
    }

    final isValidLength = password.length >= 6 && password.length <=32;
    if (!isValidLength){
      return TextConstants.passwordMustFrom6To32Digits;
    }

    final isContainsUpperCase = RegExp(r'[A-Z]').hasMatch(password);
    if (!isContainsUpperCase){
      return TextConstants.pleaseInputAtLeast1UpperCase;
    }

    final isContainsNumber = RegExp(r'[0-9]').hasMatch(password);
    if (!isContainsNumber){
      return TextConstants.pleaseInputAtLeast1Number;
    }

    return null;
  }

  static String? validateConfirmPassword(String password, String? confirmPassword){
    if (confirmPassword == null || confirmPassword.trim().isEmpty){
      return TextConstants.pleaseConfirmPassword;
    }

    if (confirmPassword != password){
      return TextConstants.confirmPasswordIncorrect;
    }

    return null;
  }

  static String? validateFirstName(String? firstName){
    if (firstName == null || firstName.trim().isEmpty){
      return TextConstants.pleaseInputFirstName;
    }

    final isValidLength = firstName.length >= 2 && firstName.length <=32;
    if (!isValidLength){
      return TextConstants.firstNameMustFrom2To32Digits;
    }

    final RegExp firstNameRegex = RegExp(
        r"^[A-Za-zÀ-Ỹà-ỹ ]{2,32}$"
    );

    if (!firstNameRegex.hasMatch(firstName)){
      return TextConstants.invalidFirstName;
    }

    return null;
  }

  static String? validateLastName(String? lastName){
    if (lastName == null || lastName.trim().isEmpty){
      return TextConstants.pleaseInputLastName;
    }

    final isValidLength = lastName.length >= 2 && lastName.length <=32;
    if (!isValidLength){
      return TextConstants.lastNameMustFrom2To32Digits;
    }

    final RegExp lastNameRegex = RegExp(
        r"^[A-Za-zÀ-Ỹà-ỹ]{2,32}$"
    );

    if (!lastNameRegex.hasMatch(lastName)){
      return TextConstants.invalidLastName;
    }

    return null;
  }

  static String? validatePhone(String? phone){
    if (phone == null || phone.trim().isEmpty){
      return TextConstants.pleaseInputPhone;
    }

    final isValidLength = phone.length >= 8 && phone.length <=13;
    if (!isValidLength){
      return TextConstants.phoneMustFrom8To13Digits;
    }

    final RegExp phoneRegex = RegExp(
        r"^(84|0[35789])\d{8}$"
    );

    if (!phoneRegex.hasMatch(phone)){
      return TextConstants.invalidPhone;
    }

    return null;
  }

  static String? validateOtp(String? otp){
    if (otp == null || otp.trim().isEmpty){
      return TextConstants.pleaseInputOtp;
    }

    if (otp.length != 6){
      return TextConstants.otpMustHave6Number;
    }

    return null;
  }
}