import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transcation_app/core/networking/api_constant.dart';

class HttpServices {
  static final HttpServices _instance = HttpServices._internal();
  final Duration _timeout = const Duration(seconds: 30);

  factory HttpServices() {
    return _instance;
  }

  HttpServices._internal();

  static HttpServices get instance => _instance;

  Future<Map<String, dynamic>> get(String endPoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + endPoint),
        headers: headers ?? {'Content-Type': 'application/json'},
      ).timeout(_timeout);

      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to perform GET request: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> post(
    String endPoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstant.baseUrl + endPoint),
        headers: headers ?? {'Content-Type': 'application/json'},
        body: body != null ? json.encode(body) : null,
      ).timeout(_timeout);

      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to perform POST request: ${e.toString()}');
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      print('HTTP Error: ${response.statusCode}\nBody: ${response.body}');
      throw Exception('Server Error: ${(json.decode(response.body) as Map<String, dynamic>)['email']}');
    }
  }
}