import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/helpers/notification_helper.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/custom_button.dart';
import 'package:transcation_app/core/utils/show_snack_bar.dart';
import 'package:transcation_app/features/authentication/presentation/widgets/sign_in/custome_title_text.dart';
import 'package:transcation_app/features/authentication/presentation/widgets/verification/custom_verification_input_fields.dart';
import '../cubits/verification_cubit/verification_cubit.dart';
import '../cubits/verification_cubit/verification_state.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});


  

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationCubit, VerificationState>(
      listener: (context, state) async {
        if (state.errorMessage != null) {
          showSnackBar(context, state.errorMessage!);
        }
        if (state.isVerified) {
        await  context.read<AppUserCubit>().saveUserData(state.user!, state.accessToken!, state.expiresAt!, state.email!, state.password!, true);
          final deviceToken=await NotificationHelper.getFCMToken();
    if(deviceToken!=null) {
     await NotificationHelper.submitDeviceTokenToBackend(deviceToken);
    }
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              backgroundColor: AppColor.darkGray,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: AppColor.brandAccent,
                    size: 50.sp,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'تم بنجاح!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'تم التحقق من حسابك بنجاح.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteNames.initial,
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.brandAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 10.h,
                      ),
                    ),
                    child: Text(
                      'موافق',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
      child: GestureDetector(
    onTap: () {
      FocusScope.of(context).unfocus();
    },
    child: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeTitleText(
                title: "التحقق",
                animatedText: "أدخل الرمز المرسل إلى  رقم الواتساب الخاص بيك للتأكيد",
                padding: EdgeInsetsDirectional.only(
                    top: 35.h, bottom: 65.h, end: 35.w, start: 35.w),
              ),
              const CustomVerificationInputFields(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: BlocBuilder<VerificationCubit, VerificationState>(
                  builder: (context, state) {
                    return Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      
                        if (state.resendTimer > 0) ...[
                          verticalSpace(8),
                          Text(
                            "يمكنك إعادة الإرسال بعد ${state.resendTimer} ثانية",
                            style: TextStyle(
                              color: AppColor.brandHighlight,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
              verticalSpace(5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    BlocBuilder<VerificationCubit, VerificationState>(
                      builder: (context, state) {
                        return CustomButton(
                          buttonContent: state.isLoading
                              ? const CircularProgressIndicator(color: AppColor.white)
                              : Text(
                                "تحقق",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.white,
                                  ),
                                ),
                          animationIndex: 3,
                          onTapButton:  () {
                                  context.read<VerificationCubit>().verifyCode();
                                },
                        );
                      },
                    ),
                    verticalSpace(15),
                  ],
                ),
              ).animate()
                  .slideY(
                      begin: 1,
                      end: 0,
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 800))
                  .fadeIn(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 800))
                  .then(delay: const Duration(milliseconds: 200)),
            ],
          ),
        ),
      ),
    ),
         ) );
  }
}