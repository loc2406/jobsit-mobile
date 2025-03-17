import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:jobsit_mobile/services/base_services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';

import '../models/candidate.dart';
import '../models/university.dart';

class CandidateServices {
  static const createCandidateUrl = '${BaseServices.url}/candidate';
  static const sendActiveEmailUrl = '${BaseServices.url}/mail/active-user?';
  static const activeEmailByOtpUrl = '${BaseServices.url}/active?';
  static const loginCandidateUrl = '${BaseServices.url}/login';
  static const getCandidateByIdUrl = '${BaseServices.url}/candidate/user/';
  static const getCandidateAvatarUrl = '${BaseServices.url}/file/display/';
  static const updateCandidateUrl = '${BaseServices.url}/candidate/';
  static const universitiesUrl = '${BaseServices.url}/university?no=0&&limit=10';
  static const updateSearchableUrl = '${BaseServices.url}/candidate/searchable/';
  static const updateMailReceiveUrl = '${BaseServices.url}/candidate/email-notification/';
  static const logoutUrl = '${BaseServices.url}/logout?token=';

  // Response key
  static const userDTOKey = 'userDTO';
  static const userCreationDTOKey = 'userCreationDTO';
  static const candidateOtherInfoDTOKey = 'candidateOtherInfoDTO';
  static const emailKey = 'email';
  static const passwordKey = 'password';
  static const firstNameKey = 'firstName';
  static const lastNameKey = 'lastName';
  static const genderKey = 'gender';
  static const phoneKey = 'phone';
  static const birthDayKey = 'birthDay';
  static const messageKey = 'message';
  static const tokenKey = 'token';
  static const idUserKey = 'idUser';
  static const nameKey = 'name';
  static const locationKey = 'location';
  static const candidateProfileDTOKey = 'candidateProfileDTO';
  static const userProfileDTOKey = 'userProfileDTO';
  static const universityDTOKey = 'universityDTO';
  static const idKey = 'id';
  static const contentsKey = 'contents';

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
    final uri =
        Uri.parse("${CandidateServices.sendActiveEmailUrl}email=$email");
    final response = await http.get(uri, headers: BaseServices.headers);

    if (response.statusCode != 200) {
      final Map<String, dynamic> errBody = jsonDecode(response.body);
      final errMessage = errBody[messageKey].toString();

      if (errMessage == dataExistingValue) {
        throw Exception(TextConstants.emailIsExistedError);
      } else {
        throw Exception(TextConstants.sendActiveEmailError);
      }
    }
  }

  static sendOtpToActiveAccount(String otp) async {
    final uri = Uri.parse("${CandidateServices.activeEmailByOtpUrl}otp=$otp");
    final response = await http.get(uri, headers: BaseServices.headers);

    if (response.statusCode != 200) {
      throw Exception(TextConstants.sendOtpToActiveError);
    }
  }

  static Future<Map<String, dynamic>> loginAccount(
      String email, String password) async {
    final uri = Uri.parse(CandidateServices.loginCandidateUrl);
    final body = {
      CandidateServices.emailKey: email,
      CandidateServices.passwordKey: password,
    };

    final response = await http.post(uri,
        headers: BaseServices.headers, body: jsonEncode(body));

    if (response.statusCode != 201) {
      throw Exception(TextConstants.emailOrPasswordIncorrectError);
    }

    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<Candidate> getCandidateById(int id) async {
    final uri = Uri.parse('${CandidateServices.getCandidateByIdUrl}$id');

    final response = await http.get(uri, headers: BaseServices.headers);

    if (response.statusCode != 200) {
      throw Exception(TextConstants.getCandidateInfoFailedError);
    }

    return Candidate.fromMap(
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);
  }

  static String getCandidateAvatarLink(String avatar) {
    return '$getCandidateAvatarUrl$avatar';
  }

  static Future<void> updateCandidate({
    required int candidateId,
    required String token,
    required File? avatar,
    required String firstName,
    required String lastName,
    required String birthdate,
    required String phone,
    required bool? gender,
    required String location,
    University? university,
  }) async {
    final uri =
        Uri.parse('${CandidateServices.updateCandidateUrl}$candidateId');

    var request = http.MultipartRequest("PUT", uri);

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';

    Map<String, dynamic> candidateData = {
      userProfileDTOKey: {
        firstNameKey: firstName,
        lastNameKey: lastName,
        genderKey: gender != null ? (gender == true ? 1 : 0) : null,
        phoneKey: phone,
        birthDayKey: birthdate,
        locationKey: location
      },
      candidateOtherInfoDTOKey:
        university != null
          ? {
            universityDTOKey: {
              idKey: university.id
            }
          } : {}
    };

    request.fields[candidateProfileDTOKey] = jsonEncode(candidateData);

    if (avatar != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'fileAvatar',
          avatar.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception(TextConstants.updateCandidateInfoFailedError);
    }
  }

  static Future<List<University>> getUniversities() async {
    try {
      final response = await http.get(Uri.parse(universitiesUrl));

      if (response.statusCode == 200) {
        // Đối với danh sách k phân trang
        // final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

        // Đối với data phân trang
        final dataObject = jsonDecode(utf8.decode(response.bodyBytes));
        final List<dynamic> data = dataObject[contentsKey];

        return data.map((university) => University.fromMap(university)).toList();
      } else {
        throw Exception(TextConstants.loadUniversitiesFailedError);
      }
    } catch (e) {
      throw Exception('${TextConstants.unexpectedError}: $e');
    }
  }

  static updateSearchable(int id, String token) async {
    final uri = Uri.parse('${CandidateServices.updateSearchableUrl}$id');

    final response = await http.put(uri,
        headers: BaseServices.getHeaderWithToken(token));

    if (response.statusCode != 200) {
      throw Exception(TextConstants.updateSearchableError);
    }
  }

  static updateMailReceive(int id, String token) async {
    final uri = Uri.parse('${CandidateServices.updateMailReceiveUrl}$id');

    final response = await http.put(uri,
        headers: BaseServices.getHeaderWithToken(token));

    if (response.statusCode != 200) {
      throw Exception(TextConstants.updateMailReceiveError);
    }
  }

  static logout(String token) async {
    final uri = Uri.parse('${CandidateServices.logoutUrl}$token');

    final response = await http.post(uri, headers: BaseServices.headers);

    if (response.statusCode != 200) {
      throw Exception(TextConstants.logoutFailedError);
    }
  }
}
