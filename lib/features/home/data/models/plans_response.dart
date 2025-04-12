// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PlansResponse {
  final String? message;
  final List<Plan> plans;
  PlansResponse({
    this.message,
    required this.plans,
  });

  PlansResponse copyWith({
    String? message,
    List<Plan>? plans,
  }) {
    return PlansResponse(
      message: message ?? this.message,
      plans: plans ?? this.plans,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'plans': plans.map((x) => x.toMap()).toList(),
    };
  }

  factory PlansResponse.fromMap(Map<String, dynamic> map) {
    return PlansResponse(
      message: map['message'] != null ? map['message'] as String : null,
      plans: List<Plan>.from((map['plans'] as List<dynamic>).map<Plan>((x) => Plan.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlansResponse.fromJson(String source) => PlansResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PlansResponse(message: $message, plans: $plans)';

  @override
  bool operator ==(covariant PlansResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message &&
      listEquals(other.plans, plans);
  }

  @override
  int get hashCode => message.hashCode ^ plans.hashCode;
}


class OffersResponse {
  final String? message;
  final List<Plan> offers;
  OffersResponse({
    this.message,
    required this.offers,
  });

  OffersResponse copyWith({
    String? message,
    List<Plan>? offers,
  }) {
    return OffersResponse(
      message: message ?? this.message,
      offers: offers ?? this.offers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'offers': offers.map((x) => x.toMap()).toList(),
    };
  }

  factory OffersResponse.fromMap(Map<String, dynamic> map) {
    return OffersResponse(
      message: map['message'] != null ? map['message'] as String : null,
      offers: List<Plan>.from((map['offers'] as List<dynamic>).map<Plan>((x) => Plan.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory OffersResponse.fromJson(String source) => OffersResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OffersResponse(message: $message, offers: $offers)';

  @override
  bool operator ==(covariant OffersResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message &&
      listEquals(other.offers, offers);
  }

  @override
  int get hashCode => message.hashCode ^ offers.hashCode;
  }

class Plan {
  final int id;
  final String name;
  final String description;
  final String profitMargin;
  final int durationDays;
  final String price;
  final int special;
  final DateTime createdAt;
  final DateTime updatedAt;

  Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.profitMargin,
    required this.durationDays,
    required this.price,
    required this.special,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      profitMargin: map['profit_margin'],
      durationDays: map['duration_days'],
      price: map['price'],
      special: map['special'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'profit_margin': profitMargin,
      'duration_days': durationDays,
      'price': price,
      'special': special,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}