import 'dart:convert';

class TransactionHistoryResponse {
  final String message;
  final List<Withdrawal> withdrawals;
  final List<Deposit> deposits;
  final List<Subscription> subscriptions;

  TransactionHistoryResponse({
    required this.message,
    required this.withdrawals,
    required this.deposits,
    required this.subscriptions,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'withdrawals': withdrawals.map((x) => x.toMap()).toList(),
      'deposits': deposits.map((x) => x.toMap()).toList(),
      'subscriptions': subscriptions.map((x) => x.toMap()).toList(),
    };
  }

  factory TransactionHistoryResponse.fromMap(Map<String, dynamic> map) {
    return TransactionHistoryResponse(
      message: map['message'] ?? '',
      withdrawals: List<Withdrawal>.from(
          map['withdrawals']?.map((x) => Withdrawal.fromMap(x)) ?? []),
      deposits:
          List<Deposit>.from(map['deposits']?.map((x) => Deposit.fromMap(x)) ?? []),
      subscriptions: List<Subscription>.from(
          map['subscriptions']?.map((x) => Subscription.fromMap(x)) ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionHistoryResponse.fromJson(String source) =>
      TransactionHistoryResponse.fromMap(json.decode(source));
}

class Withdrawal {
  final int id;
  final int userId;
  final String amount;
  final String? usdt;
  final String? bank;
  final String? western;
  final String? moneyOffice;
  final DateTime createdAt;
  final DateTime updatedAt;

  Withdrawal({
    required this.id,
    required this.userId,
    required this.amount,
    this.usdt,
    this.bank,
    this.western,
    this.moneyOffice,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'usdt': usdt,
      'bank': bank,
      'western': western,
      'money_office': moneyOffice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Withdrawal.fromMap(Map<String, dynamic> map) {
    return Withdrawal(
      id: map['id']?.toInt() ?? 0,
      userId: map['user_id']?.toInt() ?? 0,
      amount: map['amount'] ?? '',
      usdt: map['usdt'],
      bank: map['bank'],
      western: map['western'],
      moneyOffice: map['money_office'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Withdrawal.fromJson(String source) =>
      Withdrawal.fromMap(json.decode(source));
}

class Deposit {
  final int id;
  final int userId;
  final String amount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Deposit({
    required this.id,
    required this.userId,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Deposit.fromMap(Map<String, dynamic> map) {
    return Deposit(
      id: map['id']?.toInt() ?? 0,
      userId: map['user_id']?.toInt() ?? 0,
      amount: map['amount'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Deposit.fromJson(String source) => Deposit.fromMap(json.decode(source));
}

class Subscription {
  final int id;
  final int userId;
  final int planId;
  final DateTime expiratoryDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Subscription({
    required this.id,
    required this.userId,
    required this.planId,
    required this.expiratoryDate,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'plan_id': planId,
      'expiratory_date': expiratoryDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id']?.toInt() ?? 0,
      userId: map['user_id']?.toInt() ?? 0,
      planId: map['plan_id']?.toInt() ?? 0,
      expiratoryDate: DateTime.parse(map['expiratory_date']),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Subscription.fromJson(String source) =>
      Subscription.fromMap(json.decode(source));
}