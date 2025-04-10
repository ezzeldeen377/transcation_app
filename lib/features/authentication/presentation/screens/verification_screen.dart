import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
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
      listener: (context, state) {
        if (state.errorMessage != null) {
          showSnackBar(context, state.errorMessage!);
        }
        if (state.isVerified) {
          context.read<AppUserCubit>().saveUserData(state.user!, state.accessToken!,state.expiresAt!);
          Navigator.pushNamed(context, RouteNames.initial);
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
                title: "Verification",
                animatedText: "Enter the code sent to your email",
                padding: EdgeInsetsDirectional.only(
                    top: 35.h, bottom: 65.h, end: 35.w, start: 35.w),
              ),
              const CustomVerificationInputFields(),
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
                                  "Verify",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.white,
                                  ),
                                ),
                          animationIndex: 3,
                          onTapButton: () {
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