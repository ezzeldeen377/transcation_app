import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_state.dart';
import 'package:transcation_app/core/helpers/notification_helper.dart';
import 'package:transcation_app/core/helpers/secure_storage_helper.dart';
import 'package:transcation_app/features/authentication/data/model/login_response.dart';
import 'package:transcation_app/features/authentication/data/repositories/auth_repository.dart';

@injectable
class AppUserCubit extends Cubit<AppUserState> {
  AuthRepository authRepository;

  AppUserCubit({required this.authRepository})
      : super(AppUserState(state: AppUserStates.initial));
  static final LocalAuthentication localAuth = LocalAuthentication();
   void deleteAccount(String token) async {
    emit(state.copyWith(state: AppUserStates.loading));
    final result = await authRepository.deleteAccount(token:token);
    result.fold(
      (failure) => emit(state.copyWith(
        state: AppUserStates.failure,
        errorMessage: failure.message,
      )),
      (success) => emit(state.copyWith(
        state: AppUserStates.successDeleteAccount,
        errorMessage: success["message"],
      )),
    );
  }
  Future<void> saveUserData(User user, String token, int expireAt, String email,
      String password, bool isLogin) async {
    final res = await SecureStorageHelper.saveUserData(
        token, expireAt, user, email, password, isLogin);
    res.fold((l) {
      emit(state.copyWith(
        state: AppUserStates.failureSaveData,
        errorMessage: l,
      ));
    }, (r) {
      emit(state.copyWith(
        state: AppUserStates.success,
        user: user,
        accessToken: token,
        expiresAt: expireAt,
      ));
    });
  }

  Future<bool> checkLoginStatus() async {
    emit(state.copyWith(state: AppUserStates.loading));
    print("🔍 Checking login status...");
    final token = await SecureStorageHelper.getAccessToken();
    final expiry = await SecureStorageHelper.getTokenExpiry();
    final user = await SecureStorageHelper.getUserDataDirect();

    print("🔑 Token: ${token != null ? 'exists' : 'null'}");
    print("🔑 Token: $token");
    print("⏱️ Expiry: ${expiry != null ? expiry.toString() : 'null'}");

    if (token != null && expiry != null && user != null) {
      if (DateTime.now().isBefore(expiry)) {
        // Token is still valid
        print("✅ Token is valid - user is logged in");
        emit(state.copyWith(
          state: AppUserStates.loggedIn,
          user: user,
          accessToken: token,
          expiresAt: expiry.difference(DateTime.now()).inSeconds,
        ));
        return true;
      } else {
        // Token expired, try to refresh it
        print("🔄 Token expired - attempting to refresh");
        final response = await authRepository.refreshToken(token: token);

        return response.fold(
          (l) {
            print("❌ Token refresh failed: ${l.message}");
            emit(state.copyWith(
              state: AppUserStates.notLoggedIn,
              errorMessage: l.message,
            ));
            return false;
          },
          (r) async {
            print("✅ Token refresh successful");
            // await saveUserData(r.user!, r.accessToken!, r.expiresIn!,);
            print("💾 New user data saved");
            emit(state.copyWith(
              state: AppUserStates.loggedIn,
              user: r.user,
              accessToken: r.accessToken,
              expiresAt: r.expiresIn,
            ));
            return true;
          },
        );
      }
    } else {
      // No token or expiry date = logged out
      print("❌ No valid token or expiry - user is not logged in");
      emit(state.copyWith(
        state: AppUserStates.notLoggedIn,
      ));
      return false;
    }
  }

  Future<bool> checkLogin() async {
    try {
      bool isLoggedIn = await SecureStorageHelper.getIsLogin();

      if (isLoggedIn) {
        final bool canAuthenticateWithBiometrics = await localAuth.canCheckBiometrics;
        print("تم تسجيل الدخول للمستخدم ... ");
        final bool canAuthenticate = canAuthenticateWithBiometrics ||
            await localAuth.isDeviceSupported();
        if (canAuthenticate) {
          print("يمكن المصادقة ... ");
          final List<BiometricType> availableBiometrics =
              await localAuth.getAvailableBiometrics();

          if (availableBiometrics.isNotEmpty) {
            print("تم العثور على المقاييس الحيوية ... ");
            try {
              final bool didAuthenticate = await localAuth.authenticate(
                localizedReason: 'يرجى المصادقة لتسجيل الدخول',
                options: AuthenticationOptions(
                  biometricOnly: true,useErrorDialogs: true
                ),
              );

              if (!(didAuthenticate)) {
                emit(state.copyWith(
                  state: AppUserStates.notLoggedIn,
                  errorMessage: "تم إلغاء المصادقة البيومترية",
                ));
                return false;
              }
            } on PlatformException catch (ex) {
              print(ex.message);
              emit(state.copyWith(
                state: AppUserStates.notLoggedIn,
                errorMessage: ex.message,
              ));
              return false;
            }
          }else {

            emit(state.copyWith(
            state: AppUserStates.failure,
            errorMessage: "هذا الجهاز لا يدعم المصادقة البيومترية",
          ));
          }
        }
        print("تمت المصادقة...");
        var email = await SecureStorageHelper.getEmail();

        var password = await SecureStorageHelper.getPassword();
        await login(email: email!, password: password!);
        // var res = await AuthController.login(email!, password!);
               final deviceToken=await NotificationHelper.getFCMToken();
    if(deviceToken!=null) {
     await NotificationHelper.submitDeviceTokenToBackend(deviceToken);
    }
         return true;
      }
      emit(state.copyWith(
        state: AppUserStates.notLoggedIn,
        errorMessage: "لقد قمت بتسجيل الخروج",
      ));
      return isLoggedIn;
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(
        state: AppUserStates.notLoggedIn,
        errorMessage: e.toString(),
      ));
      return false;
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(state: AppUserStates.loading));

    final response = await authRepository.login(
      email: email,
      password: password,
    );

    response.fold(
      (failure) {
        emit(state.copyWith(
          state: AppUserStates.failure,
          errorMessage: failure.message,
        ));
      },
      (loginResponse) async {
        await saveUserData(
          loginResponse.user!,
          loginResponse.accessToken!,
          loginResponse.expiresIn!,
          email,
          password,
          true,
        );
    
        emit(state.copyWith(
          state: AppUserStates.loggedIn,
          user: loginResponse.user,
          accessToken: loginResponse.accessToken,
          expiresAt: loginResponse.expiresIn,
        ));
      },
    );
  }

  Future<void> signOut() async {
    final res = await SecureStorageHelper.removeUserData();
    res.fold(
        (l) => emit(state.copyWith(
              state: AppUserStates.failure,
              errorMessage: 'فشل تسجيل الخروج',
            )),
        (r) => emit(state.copyWith(
              state: AppUserStates.notLoggedIn,
              user: null,
            )));
  }

  Future<void> getUser({required String token}) async {
    final result = await authRepository.getUserData(token: token);
    result.fold(
        (l) => emit(state.copyWith(
              state: AppUserStates.failure,
              errorMessage: l.message,
            )), (r) {
      emit(state.copyWith(
        state: AppUserStates.gettedData,
        user: r,
      ));
    });
  }

  // Check if user is logged in
  void isUserLoggedIn() async {
    final res = await SecureStorageHelper.isUserLoggedIn();
    res.fold((l) {
      emit(state.copyWith(
        state: AppUserStates.notLoggedIn,
        errorMessage: l,
      ));
    }, (r) {
      emit(state.copyWith(state: AppUserStates.loggedIn, user: r));
    });
  }

  // Get stored user data
  void getStoredUserData() async {
    final res = await SecureStorageHelper.getUserData();
    res.fold(
        (l) => emit(state.copyWith(
              state: AppUserStates.failure,
              errorMessage: l,
            )),
        (r) => emit(state.copyWith(state: AppUserStates.loggedIn, user: r)));
  }

  Future<void> onLogout(String token) async {
    final res = await authRepository.logout(token);
    res.fold(
        (l) => emit(state.copyWith(
              state: AppUserStates.failure,
              errorMessage: l.message,
            )),
        (r) => emit(state.copyWith(state: AppUserStates.signOut)));
  }

  // void isFirstInstallation() async {
  //   emit(state.copyWith(state: AppUserStates.loading));
  //   final res = await SecureStorageHelper.isFirstInstallation();
  //   res.fold(
  //       (l) => emit(state.copyWith(
  //             state: AppUserStates.failure,
  //             errorMessage: l,
  //           )),
  //       (r) {
  //         if (r==null) {
  //           emit(state.copyWith(state: AppUserStates.notInstalled));
  //         } else {
  //           emit(state.copyWith(state: AppUserStates.installed));
  //         }
  //       });
  // }

  // void saveInstallationFlag() async {
  //   final res = await SecureStorageHelper.saveInstalltionFlag();
  //   res.fold((l) {
  //     emit(state.copyWith(
  //       state: AppUserStates.failure,
  //       errorMessage: l,
  //     ));
  //   }, (r) {
  //     emit(state.copyWith(
  //       state: AppUserStates.installed,
  //     ));
  //   });
  // }

  void clearUserData() async {
    final res = await SecureStorageHelper.removeUserData();
    res.fold((l) {
      emit(state.copyWith(
        state: AppUserStates.failure,
        errorMessage: 'حدث خطأ أثناء مسح البيانات',
      ));
    }, (r) {
      emit(AppUserState(
        state: AppUserStates.clearUserData,
      ));
    });
  }
}
