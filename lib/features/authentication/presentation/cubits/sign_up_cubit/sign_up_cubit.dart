import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/features/authentication/presentation/cubits/sign_up_cubit/sign_up_state.dart';

import '../../../data/repositories/auth_repository.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  String roleSelected = 'patient';
  SignUpCubit({
    required this.authRepository,
  }) : super(SignUpState(state: SignUpStatus.initial));
  //init getPlaygrounds_from_firebase branch
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(state.copyWith(state: SignUpStatus.loading));

    final result = await authRepository.register(
        email: email, password: password, name: name, phone: phone);

    result.fold(
      (l) {
        emit(state.copyWith(
          state: SignUpStatus.failure,
          erorrMessage: l.message,
        ));
      },
      (r) {
        emit(state.copyWith(
          state: SignUpStatus.success,
          successMessage: r,
        ));
      },
    );
  }

  changeVisiblePassword() {
    emit(state.copyWith(
        state: SignUpStatus.visiblePassword,
        isVisiblePassword: !state.isVisiblePassword));
  }

  changeVisibleConfirmPassword() {
    emit(state.copyWith(
        state: SignUpStatus.visiblePasswordConfirm,
        isVisiblePasswordConfirm: !state.isVisiblePasswordConfirm));
  }

  void check(bool value) {
    emit(state.copyWith(
      state: SignUpStatus.checked,
      isChecked: value, // Use the passed value directly
    ));
  }
}
