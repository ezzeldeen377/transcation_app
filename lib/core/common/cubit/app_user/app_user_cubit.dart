import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_state.dart';
import 'package:transcation_app/core/helpers/secure_storage_helper.dart';
import 'package:transcation_app/features/authentication/data/model/login_response.dart';
import 'package:transcation_app/features/authentication/data/repositories/auth_repository.dart';

@injectable
class AppUserCubit extends Cubit<AppUserState> {
  AuthRepository authRepository;

  AppUserCubit({required this.authRepository})
      : super(AppUserState(state: AppUserStates.initial));

  Future<void> saveUserData(User user, String token, int expireAt) async {
    final res = await SecureStorageHelper.saveUserData(token, expireAt, user);
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
  final user =await SecureStorageHelper.getUserDataDirect();
  
  print("🔑 Token: ${token != null ? 'exists' : 'null'}");
  print("⏱️ Expiry: ${expiry != null ? expiry.toString() : 'null'}");

  if (token != null && expiry != null && user!= null) {
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
          await saveUserData(r.user!, r.accessToken!, r.expiresIn!);
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


  Future<void> signOut() async {
    final res = await SecureStorageHelper.removeUserData();
    res.fold(
        (l) => emit(state.copyWith(
              state: AppUserStates.failure,
              errorMessage: 'Failed to sign out',
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
        errorMessage: l,
      ));
    }, (r) {
      emit(AppUserState(
        state: AppUserStates.clearUserData,
      ));
    });
  }
}
