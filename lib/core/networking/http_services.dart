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

  Future<Map<String, dynamic>> get(String endPoint,
      {Map<String, String>? headers}) async {
    try {
      final response = await http
          .get(
            Uri.parse(ApiConstant.baseUrl + endPoint),
            headers: headers ?? {'Content-Type': 'application/json'},
          )
          .timeout(_timeout);

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
      final response = await http
          .post(
            Uri.parse(ApiConstant.baseUrl + endPoint),
            headers: headers ?? {'Content-Type': 'application/json'},
            body: body != null ? json.encode(body) : null,
          )
          .timeout(_timeout);
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to perform POST request: ${e.toString()}');
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
      final body = json.decode(response.body);
      print('HTTP Response: ${response.statusCode}\nBody: $body  ${body}');
      
      if (body is Map<String, dynamic>) {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          if (body.isEmpty) return {};
          return body;
         
        } else if (response.statusCode == 422) {
           throw Exception(body['error'] ??body['message']?? "empty values");
          } else if (response.statusCode == 401) {
          throw Exception(body['error'] ?? "Unauthorized access");
        } else {
          throw Exception(body['error'] ?? "An error occurred");
        }
      } else {
        if(body !is List){
          return {};
        }else {
          throw Exception(
            "Unexpected server response format. Please try again later.");
        }
      }
   
  }
}
