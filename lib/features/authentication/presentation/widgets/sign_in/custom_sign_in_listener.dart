import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/helpers/notification_helper.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/authentication/data/model/login_response.dart';
import '../../../../../core/common/cubit/app_user/app_user_cubit.dart';
import '../../../../../core/utils/show_snack_bar.dart';
import '../../cubits/sign_in_cubit/sign_in_cubit.dart';
import '../../cubits/sign_in_cubit/sign_in_state.dart';

class CustomSignInListener extends StatelessWidget {
  final Widget child;
  const CustomSignInListener({super.key, required this.child});

  Future<void> _navigateToHome(BuildContext context, User user,String token,int expireAt,String email,String password,bool isLogin) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.darkGray,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: AppColor.brandHighlight,
              ),
              SizedBox(height: 16.h),
              Text(
                                'جاري تسجيل الدخول...',
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        );
      },
    );

    await context.read<AppUserCubit>().saveUserData(user,token,expireAt,email,password,isLogin);
    final deviceToken=await NotificationHelper.getFCMToken();
    if(deviceToken!=null) {
      await NotificationHelper.submitDeviceTokenToBackend(deviceToken);
    }

    Navigator.of(context).pop(); // Dismiss loading dialog
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
          _navigateToHome(context, state.userModel!,state.accessToken!,state.expiresAt!,signInCubit.emailController.text.trim(),signInCubit.passwordController.text.trim(),true);
        } else if (state.isFailure) {
          showSnackBar(context, state.erorrMessage ?? 'Something went wrong');
        }
      },
      child: child,
    );
  }
}
