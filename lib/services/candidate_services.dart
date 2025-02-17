import 'dart:convert';

import 'package:jobsit_mobile/services/base_services.dart';
import 'package:http/http.dart' as http;
import 'package:jobsit_mobile/utils/text_constants.dart';

class CandidateServices {
  static const createCandidateUrl = '${BaseServices.uri}/candidate';
  static const sendActiveEmailUrl = '${BaseServices.uri}/mail/active-user?';
  static const activeEmailByOtpUrl = '${BaseServices.uri}/active?';
  static const loginCandidateUrl = '${BaseServices.uri}/login';

  // Response key
  static const userCreationDTOKey = 'userCreationDTO';
  static const candidateOtherInfoDTOKey = 'candidateOtherInfoDTO';
  static const emailKey = 'email';
  static const passwordKey = 'password';
  static const firstNameKey = 'firstName';
  static const lastNameKey = 'lastName';
  static const phoneKey = 'phone';
  static const messageKey = 'message';
  static const tokenKey = 'token';
  static const idUserKey = 'idUser';

  // Response value
  static const dataExistingValue = 'DATA EXISTING';

  static createCandidate(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phone}) async {

    final uri = Uri.parse(CandidateServices.createCandidateUrl);
    final body = {
      CandidateServices.userCreationDTOKey: {
        CandidateServices.emailKey: email,
        CandidateServices.passwordKey: password,
        CandidateServices.lastNameKey: lastName,
        CandidateServices.firstNameKey: firstName,
        CandidateServices.phoneKey: phone,
      },
      CandidateServices.candidateOtherInfoDTOKey: null
    };

    final response = await http.post(uri,
        body: jsonEncode(body), headers: BaseServices.headers);

    if (response.statusCode != 201) {
      throw Exception(TextConstants.createCandidateError);
    }
  }

  static sendActiveEmail(String email) async {
    final uri = Uri.parse("${CandidateServices.sendActiveEmailUrl}email=$email");
    final response = await http.get(uri, headers: BaseServices.headers);

    if (response.statusCode != 200){
      final Map<String, dynamic> errBody = jsonDecode(response.body);
      final errMessage = errBody[messageKey].toString();

      if (errMessage == dataExistingValue){
        throw Exception(TextConstants.emailIsExistedError);
      }else{
        throw Exception(TextConstants.sendActiveEmailError);
      }
    }
  }

  static sendOtpToActiveAccount(String otp) async {
    final uri = Uri.parse("${CandidateServices.activeEmailByOtpUrl}otp=$otp");
    final response = await http.get(uri, headers: BaseServices.headers);

    if (response.statusCode != 200){
      throw Exception(TextConstants.sendOtpToActiveError);
    }
  }

  static Future<Map<String, dynamic>> loginAccount(String email, String password) async {
    final uri = Uri.parse(CandidateServices.loginCandidateUrl);
    final body = {
    CandidateServices.emailKey: email,
    CandidateServices.passwordKey: password,
    };
    
    final response = await http.post(uri, headers: BaseServices.headers, body: jsonEncode(body));

    if (response.statusCode != 201){
      throw Exception(TextConstants.emailOrPasswordIncorrectError);
    }

    return jsonDecode(response.body);
  }
}
