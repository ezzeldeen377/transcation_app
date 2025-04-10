// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:transcation_app/features/authentication/data/model/login_response.dart';

enum SignInStatus {
  initial,
  loading,
  success,
  failure,
  visible,
  
  successSignIn,
  failureSignIn,
  isAlreadySignIn,
  isNotSignIn,
}

extension SignInStateExtension on SignInState {
  bool get isInitial => state == SignInStatus.initial;
  bool get isLoading => state == SignInStatus.loading;
  bool get isSuccess => state == SignInStatus.success;
  bool get isFailure => state == SignInStatus.failure;
  bool get isVisible => state == SignInStatus.visible;
  bool get isSuccessSignIn => state == SignInStatus.successSignIn;
  bool get isFailureSignIn => state == SignInStatus.failureSignIn;
  bool get isAlreadySignIn => state == SignInStatus.isAlreadySignIn;
  bool get isNotSignIn => state == SignInStatus.isNotSignIn;
}

class SignInState {
  final SignInStatus state;
  final User? userModel;
  final String? erorrMessage;
  final String? email;
  final String? password;
 final String? accessToken;
  final int? expiresAt;
    final bool isVisible;
  SignInState({
    required this.state,
    this.userModel,
    this.erorrMessage,
    this.email,
    this.password,
    this.accessToken,
    this.expiresAt,
    this.isVisible = true,
  });

  SignInState copyWith({
    SignInStatus? state,
    User? userModel,
    String? erorrMessage,
    String? email,
    String? password,
    String? accessToken,
    int? expiresAt,
    bool? isVisible,
  }) {
    return SignInState(
      state: state ?? this.state,
      userModel: userModel ?? this.userModel,
      erorrMessage: erorrMessage ?? this.erorrMessage,
      email: email ?? this.email,
      password: password ?? this.password,
      accessToken: accessToken ?? this.accessToken,
      expiresAt: expiresAt ?? this.expiresAt,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  String toString() {
    return 'SignInState(state: $state, userModel: $userModel, erorrMessage: $erorrMessage, email: $email, password: $password, accessToken: $accessToken, expiresAt: $expiresAt, isVisible: $isVisible)';
  }

  
}
