import 'dart:convert';

import 'package:jobsit_mobile/services/base_services.dart';
import 'package:http/http.dart' as http;
import 'package:jobsit_mobile/utils/convert_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';

import '../models/job.dart';

class JobServices {
  static const getJobUrl = '${BaseServices.url}/job?';
  static const searchJobUrl = '${BaseServices.url}/job/filter?';

  // Response key
  static const contentsKey = 'contents';
  static const companyDTOKey = 'companyDTO';
  static const idKey = 'id';
  static const nameKey = 'name';
  static const logoKey = 'logo';
  static const descriptionKey = 'description';
  static const locationKey = 'location';
  static const positionDTOsKey = 'positionDTOs';
  static const amountKey = 'amount';
  static const startDateKey = 'startDate';
  static const endDateKey = 'endDate';

  // Response value
  static const dataExistingValue = 'DATA EXISTING';

  static Future<List<Job>> getJob({
    required int page,
    required int limit,
  }) async {
    final uri = Uri.parse('${JobServices.getJobUrl}no=$page&limit=$limit');

    final response = await http.get(uri, headers: BaseServices.headers);

    if (response.statusCode != 200) {
      throw Exception(TextConstants.getJobError);
    }

    final Map<String, dynamic> jobsObject =jsonDecode(utf8.decode(response.bodyBytes));;
    final List<dynamic> jobContents = jobsObject[contentsKey];

    return jobContents.map((jobMap) => Job.fromMap(jobMap as Map<String, dynamic>)).toList();
  }

  // static sendActiveEmail(String email) async {
  //   final uri =
  //       Uri.parse("${CandidateServices.sendActiveEmailUrl}email=$email");
  //   final response = await http.get(uri, headers: BaseServices.headers);
  //
  //   if (response.statusCode != 200) {
  //     final Map<String, dynamic> errBody = jsonDecode(response.body);
  //     final errMessage = errBody[messageKey].toString();
  //
  //     if (errMessage == dataExistingValue) {
  //       throw Exception(TextConstants.emailIsExistedError);
  //     } else {
  //       throw Exception(TextConstants.sendActiveEmailError);
  //     }
  //   }
  // }
  //
  // static sendOtpToActiveAccount(String otp) async {
  //   final uri = Uri.parse("${CandidateServices.activeEmailByOtpUrl}otp=$otp");
  //   final response = await http.get(uri, headers: BaseServices.headers);
  //
  //   if (response.statusCode != 200) {
  //     throw Exception(TextConstants.sendOtpToActiveError);
  //   }
  // }
  //
  // static Future<Map<String, dynamic>> loginAccount(
  //     String email, String password) async {
  //   final uri = Uri.parse(CandidateServices.loginCandidateUrl);
  //   final body = {
  //     CandidateServices.emailKey: email,
  //     CandidateServices.passwordKey: password,
  //   };
  //
  //   final response = await http.post(uri,
  //       headers: BaseServices.headers, body: jsonEncode(body));
  //
  //   if (response.statusCode != 201) {
  //     throw Exception(TextConstants.emailOrPasswordIncorrectError);
  //   }
  //
  //   return jsonDecode(response.body);
  // }
}
