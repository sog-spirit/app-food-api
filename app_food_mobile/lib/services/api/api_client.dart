import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../constants.dart';

class ApiClient {
  final Map<String, String> headers = {"Content-type": "application/json"};
  //get
  Future<http.Response> GET(String url) async {
    print("$baseApi$url");
    Response response =
        await http.get(Uri.parse("$baseApi$url"), headers: headers);
    print(response.statusCode);
    return response;
  }

  //post
  Future<http.Response> POST(String url, data) async {
    print('le tuan ${jsonEncode(data)}');
    Response response = await http.post(Uri.parse("$baseApi$url"),
        body: jsonEncode(data), headers: headers);
    print(response.statusCode);
    return response;
  }

  //patch
  Future<http.Response> PATCH(String url, data) async {
    Response response = await patch(Uri.parse("$baseApi$url"),
        headers: headers, body: jsonEncode(data));
    print('Status code: ${response.statusCode}');
    return response;
  }

  //put
  Future<http.Response> PUT(String url, data) async {
    Response response = await put(Uri.parse(url), headers: headers, body: data);
    print(response.statusCode);
    return response;
  }
}
