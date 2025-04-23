class CryptomusPayment {
  final String paymentId;
  final String orderId;
  final String amount;
  final String currency;
  final String status;
  final String? paymentUrl;

  CryptomusPayment({
    required this.paymentId,
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.status,
    this.paymentUrl,
  });

  factory CryptomusPayment.fromJson(Map<String, dynamic> json) {
    return CryptomusPayment(
      paymentId: json['payment_id'],
      orderId: json['order_id'],
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
      paymentUrl: json['payment_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_id': paymentId,
      'order_id': orderId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'payment_url': paymentUrl,
    };
  }
}