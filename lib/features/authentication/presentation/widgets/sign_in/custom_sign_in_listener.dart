import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_state.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/features/authentication/data/model/login_response.dart';
import '../../../../../core/common/cubit/app_user/app_user_cubit.dart';
import '../../../../../core/utils/show_snack_bar.dart';
import '../../cubits/sign_in_cubit/sign_in_cubit.dart';
import '../../cubits/sign_in_cubit/sign_in_state.dart';

class CustomSignInListener extends StatelessWidget {
  final Widget child;
  const CustomSignInListener({super.key, required this.child});

  void _navigateToHome(BuildContext context, User user,String token,int expireAt) {
    context.read<AppUserCubit>().saveUserData(user,token,expireAt);
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.initial,
      arguments: user,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final signInCubit = context.read<SignInCubit>();

    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) async {
        if (state.isSuccess) {
print('User: ${state.userModel}');
print('Access Token: ${state.accessToken}');
print('Expires At: ${state.expiresAt}');
          _navigateToHome(context, state.userModel!,state.accessToken!,state.expiresAt!);
        } else if (state.isFailure) {
          showSnackBar(context, state.erorrMessage ?? 'Something went wrong');
        }
      },
      child: child,
    );
  }
}
