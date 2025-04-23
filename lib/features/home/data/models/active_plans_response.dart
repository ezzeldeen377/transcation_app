import 'package:transcation_app/features/home/data/models/plans_response.dart';

class ActivePlansResponse {
  final String message;
  final List<ActivePlan>? plans;
  final double balance;
  final double totalProfit;

  ActivePlansResponse({
    required this.message,
    required this.plans,
    required this.balance,
    required this.totalProfit,
  });

  factory ActivePlansResponse.fromMap(Map<String, dynamic> map) {
    return ActivePlansResponse(
      message: map['message'] ?? '',
      plans: map['plans'] != null 
          ? List<ActivePlan>.from(
              (map['plans'] as List<dynamic>).map((x) => ActivePlan.fromMap(x)))
          : [],
      balance: ((map['balance'] as num?) ?? 0).toDouble(),
      totalProfit: ((map['total_profit'] as num?) ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'plans': plans?.map((x) => x.toMap()).toList() ?? [],
      'balance': balance,
      'total_profit': totalProfit,
    };
  }
}
class ActivePlan {
  final Plan plan;
  final String status;
  final double profit;
  final String expiryDate;
  final String? startDate;

  ActivePlan({
    required this.plan,
    required this.status,
    required this.profit,
    required this.expiryDate,
    required this.startDate,
  });

  factory ActivePlan.fromMap(Map<String, dynamic> map) {
    return ActivePlan(
      plan: Plan.fromMap(map['plan']),
      status: map['status'],
      profit: (map['profit'] as num).toDouble(),
      expiryDate: map['expiry_date'],
      startDate: map['start_date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'plan': plan.toMap(),
      'status': status,
      'profit': profit,
      'expiry_date': expiryDate,
      'start_date': startDate,
    };
  }
}