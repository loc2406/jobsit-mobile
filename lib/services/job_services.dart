import 'dart:convert';

import 'package:jobsit_mobile/services/base_services.dart';
import 'package:http/http.dart' as http;
import 'package:jobsit_mobile/utils/convert_constants.dart';
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

  // Response key
  static const contentsKey = 'contents';
  static const companyDTOKey = 'companyDTO';
  static const idKey = 'id';
  static const nameKey = 'name';
  static const logoKey = 'logo';
  static const descriptionKey = 'description';
  static const locationKey = 'location';
  static const positionDTOsKey = 'positionDTOs';
  static const scheduleDTOsKey = 'scheduleDTOs';
  static const amountKey = 'amount';
  static const startDateKey = 'startDate';
  static const endDateKey = 'endDate';
  static const lastKey = 'last';
  static const salaryMinKey = 'salaryMin';
  static const salaryMaxKey = 'salaryMax';
  static const jobDTOKey = 'jobDTO';

  // Response value
  static const dataExistingValue = 'DATA EXISTING';

  static Future<Map<String, dynamic>> getJobs({
    String name = '',
    String provinceName = '',
    String schedule = '',
    String position = '',
    String major = '',
    required int no,
    required int limit,
  }) async {

    String api = '${searchJobUrl}no=$no&limit=$limit';
    
    if (name.isNotEmpty) api += '&name=$name';
    if (provinceName.isNotEmpty) api += '&provinceName=$provinceName';
    if (schedule.isNotEmpty) api += '&schedule=$schedule';
    if (position.isNotEmpty) api += '&position=$position}';
    if (major.isNotEmpty) api += '&major=$major';

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
}
