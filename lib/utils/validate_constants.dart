import 'dart:io';

import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:path/path.dart' as path;

import '../models/province.dart';

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
      return TextConstants.pleaseInputMin6Letters;
    }

    final isValidMaxLength = email.length <= 256;
    if (!isValidMaxLength){
      return TextConstants.pleaseInputMax256Letters;
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
      return TextConstants.passwordMustFrom6To32Letters;
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
      return TextConstants.firstNameMustFrom2To32Letters;
    }

    if (firstName[firstName.length-1] == ' '){
      return TextConstants.pleaseNotFinishBySpace;
    }

    return null;
  }

  static String? validateLastName(String? lastName){
    if (lastName == null || lastName.trim().isEmpty){
      return TextConstants.pleaseInputLastName;
    }

    final isValidLength = lastName.length >= 2 && lastName.length <=32;
    if (!isValidLength){
      return TextConstants.lastNameMustFrom2To32Letters;
    }

    if (lastName[lastName.length-1] == ' '){
      return TextConstants.pleaseNotFinishBySpace;
    }

    return null;
  }

  static String? validatePhoneRegister(String? phone){
    if (phone == null || phone.trim().isEmpty){
      return TextConstants.pleaseInputPhone;
    }

    final isValidLength = phone.length >= 8 && phone.length <=13;
    if (!isValidLength){
      return TextConstants.phoneMustFrom8To13Letters;
    }

    final RegExp phoneRegex = RegExp(
        r"^(84|0[35789])\d{8}$"
    );

    if (!phoneRegex.hasMatch(phone)){
      return TextConstants.invalidPhone;
    }

    return null;
  }

  static String? validatePhoneCandidateInfo(String? phone){
    if (phone == null || phone.trim().isEmpty){
      return TextConstants.pleaseInputPhone;
    }

    final isValidLength = phone.length >= 8 && phone.length <=13;
    if (!isValidLength){
      return TextConstants.phoneMustFrom8To13Letters;
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

  static String? validateSchool(String? school){
    if (school == null || school.trim().isEmpty){
      return TextConstants.pleaseInputSchool;
    }

    return null;
  }

  static String? validateCandidateAvatar(File? img){
    if (img == null) return TextConstants.pleaseUpdateAvatar;
    // String extension = path.extension(img.path).toLowerCase();
    // extension == ".jpg" || extension == ".png"
    int imgSize = img.lengthSync();

    if (imgSize > 512 * 1024) {
      return TextConstants.avatarSizeMustSmallerThan512KB;
    }

    return null;
  }

  static String? validateBirthdate(String? birthdate){
    if (birthdate == TextConstants.defaultCandidateBirthdate){
      return TextConstants.pleaseSelectBirthdate;
    }

    return null;
  }

  static String? validateGender(bool? gender){
    if (gender == null){
      return TextConstants.pleaseSelectGender;
    }

    return null;
  }

  static String? validateCity(Province? city){
    if (city == null){
      return TextConstants.pleaseSelectCity;
    }

    return null;
  }

  static String? validateDistrict(String? district){
    if (district == null){
      return TextConstants.pleaseSelectDistrict;
    }

    return null;
  }

  static String? validateAddress(String? address){
    if (address == null || address.trim().isEmpty|| address.length < 8 || address.length > 255){
      return TextConstants.addressMustFrom8To255Letters;
    }

    final regex = RegExp(r'^[a-zA-ZÀ-Ỹà-ỹ0-9._/-\s]*$');
    if (!regex.hasMatch(address)){
      return TextConstants.pleaseInputCorrectAddressRegex;
    }

    if (address[address.length-1] == ' '){
      return TextConstants.pleaseNotFinishBySpace;
    }

    return null;
  }
}