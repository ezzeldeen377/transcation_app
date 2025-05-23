// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:transcation_app/features/authentication/data/model/login_response.dart';

enum VerificationStatus {
  initial,
  loading,
  verified,
  error,
  canResend,
  resened
}
extension VerificationStatusX on VerificationState {
  bool get isInitial => status == VerificationStatus.initial;
  bool get isLoading => status == VerificationStatus.loading;
  bool get isVerified => status == VerificationStatus.verified; 
  bool get isError => status == VerificationStatus.error;
  bool get isCanResend => status == VerificationStatus.canResend;
  bool get isResened => status == VerificationStatus.resened;
}
class VerificationState {
  final VerificationStatus status;
  final String? errorMessage;
  final User? user;
   final String? accessToken;
  final int? expiresAt;
  final String? email;
  final String? password;
  final String? phone;
  
  final int resendTimer;

  const VerificationState({
    this.status = VerificationStatus.initial,
    this.errorMessage,
    this.user,
    this.accessToken,
    this.expiresAt,
    this.email,
    this.password,
    this.resendTimer = 0,this.phone,
  });

  VerificationState copyWith({
    VerificationStatus? status,
    String? errorMessage,
    User? user,
    String? accessToken,
    int? expiresAt,
    String? email,
    String? password,
    String? phone,
    int? resendTimer,
  }) {
    return VerificationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      expiresAt: expiresAt ?? this.expiresAt,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone?? this.phone,
      resendTimer: resendTimer ?? this.resendTimer,
    );
  }
}
