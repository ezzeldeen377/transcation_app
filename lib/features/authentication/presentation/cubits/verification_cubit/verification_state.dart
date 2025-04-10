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

  const VerificationState({
    this.status = VerificationStatus.initial,
    this.errorMessage,
    this.user,
    this.accessToken,
    this.expiresAt,
  });

  VerificationState copyWith({
    VerificationStatus? status,
    String? errorMessage,
    User? user,
    String? accessToken,
    int? expiresAt,
  }) {
    return VerificationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  String toString() {
    return 'VerificationState(status: $status, errorMessage: $errorMessage, user: $user, accessToken: $accessToken, expiresAt: $expiresAt)';
  }

 
}
