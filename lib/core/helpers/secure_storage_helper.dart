import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:transcation_app/features/authentication/data/model/login_response.dart';

class SecureStorageHelper {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static const String _userKey = 'user_data';
  static const String _firstTime = 'first_time';
  static const String _ratingListKey = 'ratingList';
  static const String _accessTokenKey = 'accessToken';
  static const String _expireDateKey = 'expireData';
  static const String _isLogin = 'isLogin';
  static const String _password = 'password';
  static const String _email = 'email';

  static final _storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
  );
  // Save user data
  static Future<Either<String, void>> saveUserData(
      String token, int expireAt, User user,String email,String password, bool isLogin) async {
    try {
      await _storage.write(
        key: _userKey,
        value: user.toJson(),
      );
      await _storage.write(key: _accessTokenKey, value: token);
      await _storage.write(
        key: _expireDateKey,
        value:
            DateTime.now().add(Duration(seconds: expireAt)).toIso8601String(),
      );
      await _storage.write(key: _isLogin, value: isLogin.toString());
      await _storage.write(key: _email, value: email);
      await _storage.write(key: _password, value: password);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
  // Get email from storage
  static Future<String?> getEmail() async {
    final email = await _storage.read(key: _email);
    return email;
  }

  // Get password from storage  
  static Future<String?> getPassword() async {
    final password = await _storage.read(key: _password);
    return password;
  }

  // Get login status from storage
  static Future<bool> getIsLogin() async {
    final isLogin = await _storage.read(key: _isLogin);
    return bool.tryParse(isLogin??'false')??false; // Return false if isLogin is null or not a boolean
  }
  // Get user data
  static Future<Either<String, User?>> getUserData() async {
    try {
      final userData = await _storage.read(key: _userKey);
      if (userData != null) {
        return Right(User.fromJson(userData));
      }
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
  // Get user data
  static Future< User?> getUserDataDirect() async {
      final userData = await _storage.read(key: _userKey);
      if (userData != null) {
        return User.fromJson(userData);
      }
      return null;
  
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    final token = await _storage.read(key: _accessTokenKey);
    return token;
  }

  // Get token expiry date
  static Future<DateTime?> getTokenExpiry() async {
    final expiryStr = await _storage.read(key: _expireDateKey);
    if (expiryStr != null) {
      return DateTime.parse(expiryStr);
    }
    return null;
  }

  // Remove user data
  static Future<Either<String, void>> removeUserData() async {
    try {
      await _storage.delete(key: _userKey);
      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _expireDateKey);
      await _storage.delete(key: _isLogin);
      await _storage.delete(key: _email);
      await _storage.delete(key: _password);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Check if user is logged in
  static Future<Either<String, User>> isUserLoggedIn() async {
    try {
      final userData = await _storage.read(key: _userKey);
      if (userData != null) {
        return Right(User.fromJson(userData));
      }
      return const Left('User is not logged in');
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, String?>> isFirstInstallation() async {
    try {
      final flag = await _storage.read(key: _firstTime);
      if (flag != null) {
        return Right(flag);
      }
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, void>> saveInstalltionFlag() async {
    try {
      await _storage.write(
        key: _firstTime,
        value: 'installed',
      );
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<void> saveStringList(List<String> list) async {
    final jsonString = jsonEncode(list);
    await _storage.write(
      key: _ratingListKey,
      value: jsonString,
    );
  }

  static Future<List<String>> getStringList() async {
    final jsonString = await _storage.read(key: _ratingListKey);
    if (jsonString != null) {
      return List<String>.from(jsonDecode(jsonString));
    }
    return [];
  }
}
