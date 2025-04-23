

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/core/error/failure.dart';
import 'package:transcation_app/features/authentication/data/model/login_response.dart';

import '../../../../core/utils/try_and_catch.dart';
import '../data_source/auth_remote_data_source.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>>  register(
      {required String email, required String password, required String name,required String phone});
  Future<Either<Failure, LoginResponse>> login(
      {required String email, required String password});
  Future<Either<Failure, User>>getUserData({required String token});
  Future<Either<Failure, String>>logout(String token);
   Future<Either<Failure,LoginResponse>> verifyCode(String email, String code);
  Future<Either<Failure,String>> resendVerifyCode(String email);
    Future<Either<Failure, LoginResponse>>refreshToken({required String token});
    Future<Either<Failure, Map<String,dynamic>>>deleteAccount({required String token});

}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});
@override
  Future<Either<Failure, String>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    return  executeTryAndCatchForRepository(() async {
      return await authDataSource.register(
        email: email,
        password: password,
        name: name,
        phone: phone
      );
      
    });
  }

  @override
  Future<Either<Failure, LoginResponse>> login(
      {required String email, required String password}) async {
    return executeTryAndCatchForRepository(() async {
      final response =
          await authDataSource.login(email: email, password: password);
      return LoginResponse.fromMap(response);
    });
  }

  @override
  Future<Either<Failure, User>> getUserData({required String token}) async {
    return executeTryAndCatchForRepository(() async {
      final userData = await authDataSource.getUserData(token: token);
      return User.fromMap(userData);
    });
  }
  
  @override
  Future<Either<Failure, String>> logout(String token) {
    return executeTryAndCatchForRepository(() async {
      return await authDataSource.logout(token);
    });
  }
  
  @override
  Future<Either<Failure, String>> resendVerifyCode(String email) {
    return executeTryAndCatchForRepository(() async {
      return await authDataSource.resendVerifyCode(email);
    });
  }
  
  @override
  Future<Either<Failure, LoginResponse>> verifyCode(String email, String code) {
    return executeTryAndCatchForRepository(() async {
      final response= await authDataSource.verifyCode(email, code);
      return LoginResponse.fromMap(response);
    });
  }
  
  @override
  Future<Either<Failure, LoginResponse>> refreshToken({required String token}) {
    return executeTryAndCatchForRepository(() async {
      final response= await authDataSource.refreshToken(token: token);
      return LoginResponse.fromMap(response);
    });
  }
  
  @override
  Future<Either<Failure, Map<String,dynamic>>> deleteAccount({required String token}) {
    return executeTryAndCatchForRepository(() async {
      final response= await authDataSource.deleteAccount(token: token);
      return response; 
    });
  }


 



}



