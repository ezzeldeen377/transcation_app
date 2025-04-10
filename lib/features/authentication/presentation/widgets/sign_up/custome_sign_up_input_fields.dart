
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/custom_text_form_field.dart';

import '../../../../../core/helpers/validators.dart';
import '../../cubits/sign_up_cubit/sign_up_cubit.dart';
import '../../cubits/sign_up_cubit/sign_up_state.dart';

class CustomeSignUpInputFields extends StatelessWidget {
  final Function onSubmit;
  const CustomeSignUpInputFields({
    super.key,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SignUpCubit>();
   
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          verticalSpace(10),
          CustomTextFormField(
            validator: emailValidator,
            hint: "Enter your email",
            keyboardType: TextInputType.emailAddress,
            suffixIcon: const Icon(
              Icons.email_outlined,
              color: AppColor.brandHighlight,
            ),
            controller: cubit.emailController,
            animationIndex: 0,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
          ),
          SizedBox(height: 15.h),
          Text(
            "Username",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          verticalSpace(10),
          CustomTextFormField(
            validator: emptyValidator,
            hint: "Enter your username",
            keyboardType: TextInputType.name,
            suffixIcon: const Icon(
              Icons.person,
                            color: AppColor.brandHighlight,

            ),
            controller: cubit.nameController,
            animationIndex: 1,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.username],
          ),
          SizedBox(height: 15.h),
          Text(
            "Phone",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          verticalSpace(10),
          CustomTextFormField(
            validator: emptyValidator,
            hint: "Enter your phone number",
            keyboardType: TextInputType.number,
            suffixIcon: const Icon(
              Icons.call,
                            color: AppColor.brandHighlight,

            ),
            controller: cubit.phoneController,
            animationIndex: 1,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.telephoneNumber],
          ),
          SizedBox(height: 15.h),
          Text(
            "Password",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          verticalSpace(10),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return CustomTextFormField(
                validator: emptyValidator,
                hint: "Enter your password",
                obscureText: state.isVisiblePassword,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<SignUpCubit>().changeVisiblePassword();
                  },
                  icon: Icon(
                    state.isVisiblePassword == true
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off_outlined,
                                      color: AppColor.brandHighlight,

                  ),
                ),
                controller: cubit.passwordController,
                animationIndex: 2,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
              );
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "Confirm Password",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          verticalSpace(10),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return CustomTextFormField(
                animationIndex: 3,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please confirm your password";
                  } else if (value != cubit.passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                hint: "Confirm your password",
                keyboardType: TextInputType.visiblePassword,
                obscureText: state.isVisiblePasswordConfirm,
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<SignUpCubit>().changeVisibleConfirmPassword();
                  },
                  icon: Icon(
                    state.isVisiblePasswordConfirm == true
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off_outlined,
                                      color: AppColor.brandHighlight,

                  ),
                ),
                controller: cubit.confirmPasswordController,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.newPassword],
              );
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return Checkbox(
                    activeColor: AppColor.brandHighlight,
                    value: state.isChecked,
                    onChanged: (value) {
                      context.read<SignUpCubit>().check(value!);
                    },
                  );
                },
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Wrap(
                  children: [
                    Text(
                      "I agree to the ",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigate to Terms & Conditions page if needed
                      },
                      child: Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.brandPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
