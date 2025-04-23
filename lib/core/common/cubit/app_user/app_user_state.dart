// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:transcation_app/features/authentication/data/model/login_response.dart';

enum AppUserStates {
  initial,
  failure,
  notLoggedIn,
  loggedIn,
  signOut,
  installed,
  notInstalled,
  success,
  gettedData,
  failureSaveData,
  clearUserData,
  loading,
  updated,
  successDeleteAccount
}

extension AppUserStateExtension on AppUserState {
  bool get isInitial => state == AppUserStates.initial;
  bool get isLoggedIn => state == AppUserStates.loggedIn;
  bool get isNotLoggedIn => state == AppUserStates.notLoggedIn;
  bool get isFailure => state == AppUserStates.failure;
  bool get isSignOut => state == AppUserStates.signOut;
  bool get isInstalled => state == AppUserStates.installed;
  bool get isNotInstalled => state == AppUserStates.notInstalled;
  bool get isSuccess => state == AppUserStates.success;
  bool get isGettedData => state == AppUserStates.gettedData;
  bool get isFailureSaveData => state == AppUserStates.failureSaveData;
  bool get isClearUserData => state == AppUserStates.clearUserData;
  bool get isLoading => state == AppUserStates.loading;
  bool get isUpdated => state == AppUserStates.updated;
  bool get isSuccessDeleteAccount => state == AppUserStates.successDeleteAccount;
}

class AppUserState {
  final AppUserStates state;
  final User? user;
  final String? accessToken;
  final int? expiresAt;
  final String? errorMessage;
  AppUserState({
    required this.state,
    this.user,
    this.accessToken,
    this.expiresAt,
    this.errorMessage,
  });

  AppUserState copyWith({
    AppUserStates? state,
    User? user,
    String? accessToken,
    int? expiresAt,
    String? errorMessage,
  }) {
    return AppUserState(
      state: state ?? this.state,
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      expiresAt: expiresAt ?? this.expiresAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'AppUserState(state: $state, user: $user, accessToken: $accessToken, expiresAt: $expiresAt, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(covariant AppUserState other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.user == user &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => state.hashCode ^ user.hashCode ^ errorMessage.hashCode;
}
