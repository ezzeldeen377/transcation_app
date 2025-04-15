import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/features/authentication/data/repositories/auth_repository.dart';
import 'verification_state.dart';

@injectable
class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this.repository) : super(const VerificationState());
  final codeController = TextEditingController();
  final AuthRepository repository;

  void setEmailPassword(String userEmail,String password) {
   emit(state.copyWith(email: userEmail,password: password));
  }

  Future<void> verifyCode() async {
    if (state.email == null) {
      emit(state.copyWith(
        status: VerificationStatus.error,
        errorMessage: "Email is required for verification",
      ));
      return;
    }

    emit(state.copyWith(status: VerificationStatus.loading));

    final result =
        await repository.verifyCode(state.email!, codeController.text.trim());

    result.fold(
      (failure) => emit(state.copyWith(
        status: VerificationStatus.error,
        errorMessage: failure.message,
      )),
      (r) => emit(state.copyWith(status: VerificationStatus.verified,user: r.user,accessToken: r.accessToken,expiresAt: r.expiresIn)),
    );
  }

  Future<void> resendCode() async {
    if (state.email == null) {
      emit(state.copyWith(
        status: VerificationStatus.error,
        errorMessage: "Email is required to resend code",
      ));
      return;
    }

    emit(state.copyWith(status: VerificationStatus.loading));

    final result = await repository.resendVerifyCode(state.email!);

    result.fold(
      (failure) => emit(state.copyWith(
        status: VerificationStatus.error,
        errorMessage: failure.message,
      )),
      (r) => emit(state.copyWith(status: VerificationStatus.canResend)),
    );
  }

  @override
  Future<void> close() {
    codeController.dispose();
    return super.close();
  }
}
