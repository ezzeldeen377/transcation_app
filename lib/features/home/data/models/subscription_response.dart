class SubscriptionResponse {
  final String message;
  final SubscriptedPlan userPlan;

  SubscriptionResponse({
    required this.message,
    required this.userPlan,
  });

  factory SubscriptionResponse.fromMap(Map<String, dynamic> json) {
    return SubscriptionResponse(
      message: json['message'],
      userPlan: SubscriptedPlan.fromMap(json['user_plan']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user_plan': userPlan.toJson(),
    };
  }
}

class SubscriptedPlan {
  final int userId;
  final int planId;  // Changed from String to int
  final DateTime expiratoryDate;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  SubscriptedPlan({
    required this.userId,
    required this.planId,
    required this.expiratoryDate,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory SubscriptedPlan.fromMap(Map<String, dynamic> json) {
    return SubscriptedPlan(
      userId: json['user_id'],
      planId: json['plan_id'],  // Now it will correctly parse the integer
      expiratoryDate: DateTime.parse(json['expiratory_date']),
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'plan_id': planId,
      'expiratory_date': expiratoryDate.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
