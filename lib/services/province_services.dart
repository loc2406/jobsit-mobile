import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jobsit_mobile/models/province.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';

import 'base_services.dart';

class ProvinceServices{

  static const provincesApi = 'https://provinces.open-api.vn/api/?depth=1';
  static String districtApi(int code) => 'https://provinces.open-api.vn/api/p/$code?depth=2';

  // Key
  static const nameKey = 'name';
  static const dataKey = 'data';
  static const districtsKey = 'districts';

  static Future<List<Province>> getProvinces() async {
    try{
      final response = await http.get(Uri.parse(provincesApi));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        // final List<dynamic> data = object[dataKey];
        return data.map((province) => Province.fromMap(province as Map<String, dynamic>)).toList();
      } else {
        throw Exception(TextConstants.loadProvincesFailedError);
      }
    }catch(e){
      throw Exception(TextConstants.apiError);
    }
  }

  static Future<List<String>> getDistricts(int? provinceCode) async {
    if (provinceCode == null) return [];
    try{
      final response = await http.get(Uri.parse(districtApi(provinceCode)));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final List<dynamic> districts = data[districtsKey];
        return districts.map((e) => e[nameKey].toString()).toList();
      } else {
        throw Exception(TextConstants.loadProvincesFailedError);
      }
    }catch(e){
      throw Exception(TextConstants.apiError);
    }
  }
}