import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptomusService {
  final String _baseUrl = 'https://api.cryptomus.com/v1';
  final String _merchantId;
  final String _paymentKey;

  CryptomusService({
    required String merchantId,
    required String paymentKey,
  })  : _merchantId = merchantId,
        _paymentKey = paymentKey;

  Future<Map<String, dynamic>> createPayment({
    required String amount,
    required String currency,
    required String orderId,
    String? callbackUrl,
    String? successUrl,
    String? failureUrl,
  }) async {
    final url = Uri.parse('$_baseUrl/payment');
    final payload = {
      'amount': amount,
      'currency': currency,
      'order_id': orderId,
      'callback_url': callbackUrl,
      'success_url': successUrl,
      'failure_url': failureUrl,
    };

    final response = await http.post(
      url,
      headers: _getHeaders(payload),
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create payment: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getPaymentStatus(String paymentId) async {
    final url = Uri.parse('$_baseUrl/payment/status');
    final payload = {'payment_id': paymentId};

    final response = await http.post(
      url,
      headers: _getHeaders(payload),
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get payment status: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getBalance() async {
    final url = Uri.parse('$_baseUrl/balance');
    final payload = {'merchant_id': _merchantId};

    final response = await http.post(
      url,
      headers: _getHeaders(payload),
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get balance: ${response.body}');
    }
  }

  Map<String, String> _getHeaders(Map<String, dynamic> payload) {
    final sign = base64Encode(
      utf8.encode(
        jsonEncode(payload) + _paymentKey,
      ),
    );

    return {
      'merchant': _merchantId,
      'sign': sign,
      'Content-Type': 'application/json',
    };
  }
}