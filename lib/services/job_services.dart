import 'dart:convert';
import 'dart:io';

import 'package:jobsit_mobile/services/base_services.dart';
import 'package:http/http.dart' as http;
import 'package:jobsit_mobile/utils/convert_constants.dart';
import 'package:jobsit_mobile/utils/exceptions/AppliedJobBeforeException.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';

import '../models/job.dart';

class JobServices {
  static const getJobUrl = '${BaseServices.url}/job?';
  static const searchJobUrl = '${BaseServices.url}/job/filter?';
  static const displayJobLogoUrl = '${BaseServices.url}/file/display/';
  static const getSavedJobUrl = '${BaseServices.url}/candidate-job-care?';
  static const saveJobUrl = '${BaseServices.url}/candidate-job-care?idJob=';
  static const deleteJobUrl = '${BaseServices.url}/candidate-job-care?idJob=';
  static const getOtherJobsUrl = '${BaseServices.url}/job/active/company/';
  static const applyJobUrl = '${BaseServices.url}/candidate-application';
  static const getAppliedJobsUrl = '${BaseServices.url}/candidate-application?';

  // Response key
  static const contentsKey = 'contents';
  static const companyDTOKey = 'companyDTO';
  static const idKey = 'id';
  static const nameKey = 'name';
  static const titleKey = 'title';
  static const logoKey = 'logo';
  static const descriptionKey = 'description';
  static const positionDTOSKey = 'positionDTOS';
  static const scheduleDTOSKey = 'scheduleDTOS';
  static const majorDTOSKey = 'majorDTOS';
  static const locationKey = 'location';
  static const amountKey = 'amount';
  static const postingDateKey = 'postingDate';
  static const applicationDeadlineKey = 'applicationDeadline';
  static const lastKey = 'last';
  static const minAllowanceKey = 'minAllowance';
  static const maxAllowanceKey = 'maxAllowance';
  static const countryKey = 'country';
  static const cityKey = 'city';
  static const districtKey = 'district';
  static const addressKey = 'address';
  static const jobDTOKey = 'jobDTO';
  static const referenceLetterKey = 'referenceLetter';
  static const candidateApplicationKey = 'candidateApplication';

  // Response value
  static const dataExistingValue = 'DATA EXISTING';

  static Future<Map<String, dynamic>> getJobs({
    required String name,
    required String address,
    required int scheduleId,
    required int positionId,
    required int  majorId,
    required int no,
    required int limit,
  }) async {

    String api = '${searchJobUrl}no=$no&limit=$limit';

    if (name.isNotEmpty) api += '&title=$name';
    if (address.isNotEmpty) api += '&address=$address';
    if (scheduleId != -1) api += '&jobScheduleIds=$scheduleId';
    if (positionId != -1) api += '&jobPositionIds=$positionId}';
    if (majorId != -1) api += '&jobMajorIds=$majorId';

    final uri = Uri.parse(api);

    final response = await http.get(uri, headers: BaseServices.headers);

    if (response.statusCode != 200) {
      throw Exception(TextConstants.getJobError);
    }

    final Map<String, dynamic> jobsObject =
        jsonDecode(utf8.decode(response.bodyBytes));

    final List<dynamic> jobContents = jobsObject[contentsKey];
    final bool isLastPage = jobsObject[lastKey];

    return {
      contentsKey: jobContents,
      lastKey: isLastPage,
    };
  }

  static Future<Map<String, dynamic>> getSavedJobs({ required String token, required int no, required int limit}) async {

    final uri = Uri.parse('${getSavedJobUrl}no=$no&limit=$limit');

    final response = await http.get(uri, headers: BaseServices.getHeaderWithToken(token));

    if (response.statusCode != 200) {
      throw Exception(TextConstants.getSavedJobError);
    }

    final Map<String, dynamic> jobsObject =
    jsonDecode(utf8.decode(response.bodyBytes));

    final List<dynamic> jobContents = jobsObject[contentsKey];
    final bool isLastPage = jobsObject[lastKey];

    return {
      contentsKey: jobContents,
      lastKey: isLastPage,
    };
  }

  static saveJob({required int jobId, required String token}) async {
    final uri = Uri.parse('$saveJobUrl$jobId');

    final response = await http.post(uri, headers: BaseServices.getHeaderWithToken(token));

    if (response.statusCode != 200) {
      throw Exception(TextConstants.saveJobError);
    }
  }

  static deleteJob({required int jobId, required String token}) async {
    final uri = Uri.parse('$deleteJobUrl$jobId');

    final response = await http.delete(uri, headers: BaseServices.getHeaderWithToken(token));

    if (response.statusCode != 200) {
      throw Exception(TextConstants.deleteJobError);
    }
  }

  static applyJob({required String token, required File cvFile, required String letter, required int idJob}) async {
    final uri = Uri.parse(applyJobUrl);

    final body = {
      jobDTOKey: {
        idKey: idJob,
      },
      referenceLetterKey: letter
    };

    var request = http.MultipartRequest("POST", uri);

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields[candidateApplicationKey] = jsonEncode(body);

    request.files.add(
      await http.MultipartFile.fromPath(
        'fileCV',
        cvFile.path,
      ),
    );

    final response = await request.send();

    if (response.statusCode != 201) {
      if (response.statusCode == 409){
        throw AppliedJobBeforeException();
      }else{
        throw Exception(TextConstants.applyError);
      }
    }
  }

  static Future<Map<String, dynamic>> getOtherJobs({required int no, required int companyId, required int limit}) async {
    final uri = Uri.parse('$getOtherJobsUrl$companyId?no=$no&limit=$limit');

    final response = await http.get(uri, headers: BaseServices.headers);

    if (response.statusCode != 200) {
      throw Exception(TextConstants.getOtherJobsError);
    }

    final Map<String, dynamic> otherJobsObject = jsonDecode(utf8.decode(response.bodyBytes));

    final List<dynamic> otherJobsContents = otherJobsObject[contentsKey];
    final bool isLastPage = otherJobsObject[lastKey];

    return {
      contentsKey: otherJobsContents,
      lastKey: isLastPage,
    };
  }

  static getAppliedJobs({required String token, required int no, required int limit}) async {
    final uri = Uri.parse('${getAppliedJobsUrl}no=$no&limit=$limit');

    final response = await http.get(uri, headers: BaseServices.getHeaderWithToken(token));

    if (response.statusCode != 200) {
      throw Exception(TextConstants.getAppliedJobError);
    }

    final Map<String, dynamic> jobsObject = jsonDecode(utf8.decode(response.bodyBytes));

    final List<dynamic> jobContents = jobsObject[contentsKey];
    final bool isLastPage = jobsObject[lastKey];

    return {
      contentsKey: jobContents,
      lastKey: isLastPage,
    };
  }
}
