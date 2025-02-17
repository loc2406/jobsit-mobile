import 'dart:convert';

import 'package:jobsit_mobile/services/base_services.dart';
import 'package:http/http.dart' as http;

class CandidateServices {
  static const createCandidateUri = '${BaseServices.uri}/candidate';
  static const sendActiveEmailUri = '${BaseServices.uri}/mail/active-user?';

  static const userCreationDTOKey = 'userCreationDTO';
  static const candidateOtherInfoDTOKey = 'candidateOtherInfoDTO';
  static const emailKey = 'email';
  static const passwordKey = 'password';
  static const firstNameKey = 'firstName';
  static const lastNameKey = 'lastName';
  static const phoneKey = 'phone';

  static createCandidate(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phone}) async {

    final uri = Uri.parse(CandidateServices.createCandidateUri);
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
      throw Exception('Error when create candidate: ${response.reasonPhrase}');
    }
  }

  static sendActiveEmail(String email) async {
    final uri = Uri.parse("${CandidateServices.createCandidateUri}email=$email");
    final response = await http.get(uri, headers: BaseServices.headers);

    if (response.statusCode != 200){
      throw Exception("Error when send active email: ${response.reasonPhrase}");
    }
  }
}
