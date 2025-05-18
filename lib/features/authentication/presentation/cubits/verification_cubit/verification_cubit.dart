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

  void setEmailPassword(String userEmail,String password,String phone) {
   emit(state.copyWith(email: userEmail,password: password,phone: phone));
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
    if (state.phone == null) {
      emit(state.copyWith(
        status: VerificationStatus.error,
        errorMessage: "phone is required to resend code",
      ));
      return;
    }

    emit(state.copyWith(status: VerificationStatus.loading));

    final result = await repository.resendVerifyCode(state.phone!);

    result.fold(
      (failure) => emit(state.copyWith(
        status: VerificationStatus.error,
        errorMessage: failure.message,
      )),
      (r) => emit(state.copyWith(status: VerificationStatus.canResend)),
    );
    
    // Start the timer after sending the code
    emit(state.copyWith(resendTimer: 180)); // 3 minutes in seconds
    _startResendTimer();
  }

  void _startResendTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendTimer > 0) {
        emit(state.copyWith(resendTimer: state.resendTimer - 1,errorMessage:null));
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    codeController.dispose();
    return super.close();
  }
}
