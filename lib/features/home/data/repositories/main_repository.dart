import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/core/error/failure.dart';
import 'package:transcation_app/core/utils/try_and_catch.dart';
import 'package:transcation_app/features/authentication/data/model/login_response.dart';
import 'package:transcation_app/features/home/data/datasources/main_remote_data_source.dart';
import 'package:transcation_app/features/home/data/models/active_plans_response.dart';
import 'package:transcation_app/features/home/data/models/notifcation_response.dart';
import 'package:transcation_app/features/home/data/models/plans_response.dart';
import 'package:transcation_app/features/home/data/models/subscription_response.dart';
import 'package:transcation_app/features/home/data/models/transaction_history_response.dart';
import 'package:transcation_app/features/home/data/models/withdraw_response.dart';

abstract class MainRepository {
  Future<Either<Failure, User>> getUserProfile({required String token});
  Future<Either<Failure, PlansResponse>> getAllPlans();
  Future<Either<Failure, OffersResponse>> getAllOffers();
  Future<Either<Failure, NotificationResponse>> getAllNotifcations();
  Future<Either<Failure, ActivePlansResponse>> getUserActivePlan(String token);
  Future<Either<Failure, SubscriptionResponse>> subscribePlan(
      String token, int planId);
  Future<Either<Failure, Map<String, dynamic>>> checkPlans(String token);
  Future<Either<Failure, WithdrawResponse>> withdraw(Map<String, dynamic> data);
  Future<Either<Failure, TransactionHistoryResponse>> getLastTranscations(
      String token);
  Future<Either<Failure, ActivePlan>> getPlanReuslt(String token,String planId);
  Future<Either<Failure, Map<String,dynamic>>> updateDeviceToken(String token,String userIdentifer);
}

@Injectable(as: MainRepository)
class MainRepositoryImpl implements MainRepository {
  final MainRemoteDataSource dataSource;

  MainRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, User>> getUserProfile({required String token}) {
    return executeTryAndCatchForRepository(() async {
      final response = await dataSource.getUserProfile(token);
      return User.fromMap(response);
    });
  }

  @override
  Future<Either<Failure, PlansResponse>> getAllPlans() {
    return executeTryAndCatchForRepository(() async {
      final response = await dataSource.getAllPlans();
      return PlansResponse.fromMap(response);
    });
  }

  @override
  Future<Either<Failure, OffersResponse>> getAllOffers() {
    return executeTryAndCatchForRepository(() async {
      final response = await dataSource.getAllOffers();
      return OffersResponse.fromMap(response);
    });
  }

  @override
  Future<Either<Failure, NotificationResponse>> getAllNotifcations() {
    return executeTryAndCatchForRepository(() async {
      final response = await dataSource.getAllNotifcations();
      return NotificationResponse.fromMap(response);
    });
  }

  @override
  Future<Either<Failure, ActivePlansResponse>> getUserActivePlan(String token) {
    return executeTryAndCatchForRepository(() async {
      final response = await dataSource.getUserActivePlan(token);
      return ActivePlansResponse.fromMap(response);
    });
  }

  @override
  Future<Either<Failure, SubscriptionResponse>> subscribePlan(
      String token, int planId) {
    return executeTryAndCatchForRepository(() async {
      final response = await dataSource.subscribePlan(token, planId);
      return SubscriptionResponse.fromMap(response);
    });
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> checkPlans(String token) {
    return executeTryAndCatchForRepository(() async {
      final response = await dataSource.checkPlans(token);
      return response;
    });
  }

  @override
  Future<Either<Failure, WithdrawResponse>> withdraw(
      Map<String, dynamic> data) {
    return executeTryAndCatchForRepository(() async {
      final response = await dataSource.withdraw(data);
      return WithdrawResponse.fromMap(response);
    });
  }

  @override
  Future<Either<Failure, TransactionHistoryResponse>> getLastTranscations(
      String token) {
    return executeTryAndCatchForRepository(() async {
      final response = await dataSource.getLastTranscations(token);
      return TransactionHistoryResponse.fromMap(response);
    });
  }

  @override
  Future<Either<Failure, ActivePlan>> getPlanReuslt(String token,String planId) {
    return executeTryAndCatchForRepository(() async {
      final response = await dataSource.getPlanReuslt(token,planId);
      return ActivePlan.fromMap(response);
    });
  }
  
  @override
  Future<Either<Failure, Map<String, dynamic>>> updateDeviceToken(String token, String userIdentifer) {
    return executeTryAndCatchForRepository(() async {
      final response = await dataSource.updateDeviceToken(token,userIdentifer);
      return response; 
    });
  }
}
