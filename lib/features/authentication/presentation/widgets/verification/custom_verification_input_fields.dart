import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/authentication/presentation/cubits/verification_cubit/verification_cubit.dart';
import 'package:transcation_app/features/authentication/presentation/cubits/verification_cubit/verification_state.dart';

class CustomVerificationInputFields extends StatelessWidget {
  const CustomVerificationInputFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerificationCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 45.w,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColor.brandHighlight,
                width: 1.5,
              ),
            ),
            child: TextField(
              controller: cubit.codeController,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.brandHighlight,
              ),

              cursorColor: AppColor.brandHighlight,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
                hintText: 'رمز التحقق',
                contentPadding: EdgeInsets.symmetric(vertical: 5),
              ),
              maxLength: 6, // Assuming the verification code is 6 digits
            ),
          ),
          verticalSpace(20),
          BlocBuilder<VerificationCubit, VerificationState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () =>
                    state.resendTimer > 0 ? null : cubit.resendCode(),
                child: Text(
                  'إعادة إرسال الرمز',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColor.brandHighlight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
