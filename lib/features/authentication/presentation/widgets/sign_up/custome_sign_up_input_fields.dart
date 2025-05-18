import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/custom_text_form_field.dart';
import 'package:transcation_app/core/utils/web_view.dart';

import '../../../../../core/helpers/validators.dart';
import '../../cubits/sign_up_cubit/sign_up_cubit.dart';
import '../../cubits/sign_up_cubit/sign_up_state.dart';

class CustomeSignUpInputFields extends StatelessWidget {
  final Function onSubmit;
  final String termsLink =
      "https://www.termsfeed.com/live/dfa918d5-54c3-4730-bd02-544269a6c90f";
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
            "البريد الإلكتروني",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          verticalSpace(10),
          CustomTextFormField(
            validator: emailValidator,
            hint: "أدخل بريدك الإلكتروني",
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
            "اسم المستخدم",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          verticalSpace(10),
          CustomTextFormField(
            validator: emptyValidator,
            hint: "أدخل اسم المستخدم",
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
            "رقم الواتساب",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          verticalSpace(10),
          IntlPhoneField(
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: AppColor.white,
                fontSize: 14.sp,
              ),
              fillColor: AppColor.brandDark,
              filled: true,
            ),
            initialCountryCode: 'SY',
            pickerDialogStyle: PickerDialogStyle(
              backgroundColor: AppColor.darkGray,
              searchFieldInputDecoration: InputDecoration(
                hintText: 'بحث',
                hintStyle: TextStyle(color: AppColor.white.withOpacity(0.5)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.brandHighlight),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColor.brandHighlight.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.brandHighlight),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                fillColor: AppColor.darkGray,
                filled: true,
              ),
              searchFieldCursorColor: AppColor.brandHighlight,
              countryNameStyle: TextStyle(
                color: AppColor.white,
                fontSize: 14.sp,
              ),
              countryCodeStyle: TextStyle(
                color: AppColor.white,
                fontSize: 14.sp,
              ),
            ),
            languageCode: "ar",
            dropdownTextStyle: TextStyle(
              color: AppColor.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            style: TextStyle(
              color: AppColor.white,
              fontSize: 14.sp,
            ),
            dropdownIcon: const Icon(
              Icons.arrow_drop_down,
              color: AppColor.brandHighlight,
            ),
            onChanged: (value) {
              print(value.completeNumber);
              cubit.phoneController.text = value.completeNumber;
            },
          ),
          SizedBox(height: 10.h),
          Text(
            "كلمة المرور",
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
                hint: "أدخل كلمة المرور",
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
            "تأكيد كلمة المرور",
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
                    return "يرجى تأكيد كلمة المرور";
                  } else if (value != cubit.passwordController.text) {
                    return "كلمات المرور غير متطابقة";
                  }
                  return null;
                },
                hint: "تأكيد كلمة المرور",
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
                      "أوافق على ",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        customelaunchUrl(termsLink, context);
                      },
                      child: Text(
                        "الشروط والأحكام",
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
