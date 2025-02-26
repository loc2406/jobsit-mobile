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
  static const lastKey = 'last';

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
}
