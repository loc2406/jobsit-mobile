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
    String? name,
    String provinceName = '',
    int scheduleId = -1,
    int positionId = -1,
    int majorId = -1,
    required int no,
    required int limit,
  }) async {

    late Uri uri;

    if (name == null){
      uri = Uri.parse('${JobServices.getJobUrl}no=$no&limit=$limit');
    }else{
      String api = '${JobServices.searchJobUrl}'
          '&name=${name ?? ''}'
          '&provinceName=$provinceName'
          '&no=$no'
          '&limit=$limit';

      if (scheduleId != -1) api += '&schedule=${ConvertConstants.getNameById(ValueConstants.schedules, scheduleId)}';
      if (positionId != -1) api += '&position=${ConvertConstants.getNameById(ValueConstants.positions, positionId)}';
      if (majorId != -1) api += '&major=${ConvertConstants.getNameById(ValueConstants.majors, majorId)}';

      uri = Uri.parse(api);
    }

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
