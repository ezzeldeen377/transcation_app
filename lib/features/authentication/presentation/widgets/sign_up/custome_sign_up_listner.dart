import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcation_app/core/routes/routes.dart';
import '../../../../../core/utils/show_snack_bar.dart';
import '../../cubits/sign_up_cubit/sign_up_cubit.dart';
import '../../cubits/sign_up_cubit/sign_up_state.dart';

class CustomeSignUpListner extends StatelessWidget {
  final Widget child;
  const CustomeSignUpListner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.isSuccess) {
          
          showCustomDialog(
            context,
            "تم إرسال رمز التحقق إلى بريدك الإلكتروني.",
            "تم إنشاء الحساب بنجاح",
            () {
              Navigator.popAndPushNamed(context, RouteNames.verification,arguments:{
                'email':cubit.emailController.text.trim(),
                'password':cubit.passwordController.text.trim(),
              });
            },            
          );
        } else if (state.isFailure) {
          showSnackBar(context, state.erorrMessage ?? '');
        }
      },
      child: child,
    );
  }
}
