import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:unada_interview/model/list_model.dart';
import 'package:unada_interview/utills/api_url.dart';

class ApiService {


  static Future<ResponseData?> getAllApi() async {
    final response = await http.get(Uri.parse(ApiUrl.getListUrl));

    if (response.statusCode == 200) {
      final jsonString = response.body;
      final jsonData = json.decode(jsonString)["responseData"];
      return listModelFromJson(jsonString).responseData;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }


}
