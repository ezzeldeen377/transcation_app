import 'package:injectable/injectable.dart';
import 'package:transcation_app/core/networking/api_constant.dart';
import 'package:transcation_app/core/networking/http_services.dart';
import 'package:transcation_app/core/utils/try_and_catch.dart';

abstract class MainRemoteDataSource {
  Future<Map<String, dynamic>> getUserProfile(String token);
  Future<Map<String, dynamic>> getAllPlans();
  Future<Map<String, dynamic>> getAllOffers();
  Future<Map<String, dynamic>> getAllNotifcations();
  Future<Map<String, dynamic>> getUserActivePlan(String token);
  Future<Map<String, dynamic>> subscribePlan(String token, int planId);
  Future<Map<String, dynamic>> checkPlans(String token);
  Future<Map<String, dynamic>> withdraw(Map<String, dynamic> withdrawData);
  Future<Map<String, dynamic>> getLastTranscations(String token);
  Future<Map<String, dynamic>> getPlanReuslt(String token, String planId);
  Future<Map<String, dynamic>> updateDeviceToken(String token, String userIdentifer);

  
}

@Injectable(as: MainRemoteDataSource)
class MainRemoteDataSourceImpl implements MainRemoteDataSource {
  @override
  Future<Map<String, dynamic>> getUserProfile(String token) {
    return executeTryAndCatchForDataLayer(() {
      print("token $token");
      return HttpServices.instance
          .post(ApiConstant.meEndPoint, body: {'token': token});
    });
  }

  @override
  Future<Map<String, dynamic>> getAllPlans() {
    return executeTryAndCatchForDataLayer(() {
      return HttpServices.instance.get(ApiConstant.plansEndPoint);
    });
  }

  @override
  Future<Map<String, dynamic>> getAllOffers() {
    return executeTryAndCatchForDataLayer(() async {
      final resuslt =
          await HttpServices.instance.get(ApiConstant.offersEndPoint);
      print(resuslt);
      return resuslt;
    });
  }

  @override
  Future<Map<String, dynamic>> getAllNotifcations() {
    return executeTryAndCatchForDataLayer(() {
      return HttpServices.instance.get(ApiConstant.notificationsEndPoint);
    });
  }

  @override
  Future<Map<String, dynamic>> getUserActivePlan(String token) {
    return executeTryAndCatchForDataLayer(() {
      return HttpServices.instance.post(ApiConstant.usersPlanEndPoint, body: {
        "token": token,
      });
    });
  }

  @override
  Future<Map<String, dynamic>> subscribePlan(String token, int planId) {
    return executeTryAndCatchForDataLayer(() {
      return HttpServices.instance
          .post(ApiConstant.subscribePlanEndPoint, body: {
        "token": token,
        "plan_id": planId,
      });
    });
  }

  @override
  Future<Map<String, dynamic>> checkPlans(String token) {
    return executeTryAndCatchForDataLayer(() {
      return HttpServices.instance.post(ApiConstant.checkplanEndPoint, body: {
        "token": token,
      });
    });
  }

  @override
  Future<Map<String, dynamic>> withdraw(Map<String, dynamic> withdrawData) {
    print("withdrawData $withdrawData");
    return executeTryAndCatchForDataLayer(() {
      return HttpServices.instance
          .post(ApiConstant.withdrawEndPoint, body: withdrawData);
    });
  }

  @override
  Future<Map<String, dynamic>> getLastTranscations(String token) {
    return executeTryAndCatchForDataLayer(() {
      return HttpServices.instance
          .post(ApiConstant.lastTransactionsEndPoint, body: {
        "token": token,
      });
    });
  }

  @override
  Future<Map<String, dynamic>> getPlanReuslt(String token, String planId) {
    return executeTryAndCatchForDataLayer(() {
      return HttpServices.instance.post(ApiConstant.planResultEndPoint, body: {
        "token": token,
        "plan_id": planId,
      });
    });
  }
  
  @override
  Future<Map<String, dynamic>> updateDeviceToken(String token, String userIdentifer) {
   return executeTryAndCatchForDataLayer(() {
      return HttpServices.instance.post(ApiConstant.deviceTokenEndPoint, body: {
        "token": token,
        "user_identifier": userIdentifer,
      });
    });
  }
}
