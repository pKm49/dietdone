import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GetSupportNumberApiService {
  final url = ApiConfig.baseUrl + ApiConfig.Support;
  final Storage = FlutterSecureStorage();
  Future<String> getSupportNumber() async {
    final accessTOken = await Storage.read(key: "access_token");
    log(accessTOken.toString(), name: "acces token");

    try {
      final response = await http.get(Uri.parse(url),
          headers: {"Authorization": "Bearer $accessTOken"});
      if (response.statusCode == 200) {
        log(response.body, name: "Suppport number");
        final number = json.decode(response.body)["payload"];
        return number;
      }
    } catch (e) {
      Exception("Error while getting support number $e");
    } finally {}
    return "";
  }
}
