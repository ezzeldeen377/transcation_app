// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:transcation_app/features/authentication/data/model/login_response.dart';

enum SignUpStatus {
  initial,
  loading,
  success,
  failure,
  visiblePassword,
  visiblePasswordConfirm,
  checked,
}

extension SignInStateExtension on SignUpState {
  bool get isInitial => state == SignUpStatus.initial;
  bool get isLoading => state == SignUpStatus.loading;
  bool get isSuccess => state == SignUpStatus.success;
  bool get isFailure => state == SignUpStatus.failure;
  bool get isVisiblePassword => state == SignUpStatus.visiblePassword;
  bool get isVisiblePasswordConfirm =>
      state == SignUpStatus.visiblePasswordConfirm;
  bool get isChecked => state == SignUpStatus.checked;
}

class SignUpState {
  final SignUpStatus state;
  final User? userModel;
  final String? erorrMessage;
  final String? successMessage;
  final bool isVisiblePassword;
  final bool isVisiblePasswordConfirm;
  final bool isChecked;
  SignUpState({
    required this.state,
    this.userModel,
    this.erorrMessage,
    this.successMessage,
    this.isVisiblePassword = true,
    this.isVisiblePasswordConfirm = true,
    this.isChecked = false,
  });

  SignUpState copyWith({
    SignUpStatus? state,
    User? userModel,
    String? erorrMessage,
    String? successMessage,
    bool? isVisiblePassword,
    bool? isVisiblePasswordConfirm,
    bool? isChecked,
  }) {
    return SignUpState(
      state: state ?? this.state,
      userModel: userModel ?? this.userModel,
      erorrMessage: erorrMessage ?? this.erorrMessage,
      successMessage: successMessage ?? this.successMessage,
      isVisiblePassword: isVisiblePassword ?? this.isVisiblePassword,
      isVisiblePasswordConfirm: isVisiblePasswordConfirm ?? this.isVisiblePasswordConfirm,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  String toString() {
    return 'SignUpState(state: $state, userModel: $userModel, erorrMessage: $erorrMessage, successMessage: $successMessage, isVisiblePassword: $isVisiblePassword, isVisiblePasswordConfirm: $isVisiblePasswordConfirm, isChecked: $isChecked)';
  }
}
