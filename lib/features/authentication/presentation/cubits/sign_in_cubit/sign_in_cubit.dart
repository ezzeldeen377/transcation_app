import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/auth_repository.dart';
import 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final AuthRepository authRepository;
  SignInCubit({
    required this.authRepository,
  }) : super(SignInState(state: SignInStatus.initial));

  Future<void> login() async {
    emit(state.copyWith(state: SignInStatus.loading));
    final result = await authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    result.fold((l) {
      emit(state.copyWith(
        state: SignInStatus.failure,
        erorrMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(state: SignInStatus.success, userModel: r.user,accessToken: r.accessToken,expiresAt: r.expiresIn));
    });
  }


  changeVisiblePassword() {
    emit(state.copyWith(
        state: SignInStatus.visible, isVisible: !state.isVisible));
  }

  // Future<void> checkUesrSignin(
  //     {required String email, required String password}) async {
  //   final result = await authRepository.checkUesrSignin();
  //   result.fold((error) {
  //     emit(state.copyWith(
  //         state: SignInStatus.isAlreadySignIn,
  //         email: email,
  //         password: password,
  //         erorrMessage: state.erorrMessage));
  //   }, (userData) {
  //     if (userData) {
  //       emit(state.copyWith(
  //           state: SignInStatus.isAlreadySignIn,
  //           email: email,
  //           password: password));
  //     } else {
  //       emit(state.copyWith(
  //           state: SignInStatus.isNotSignIn, email: email, password: password));
  //     }
  //   });
  // }
}
