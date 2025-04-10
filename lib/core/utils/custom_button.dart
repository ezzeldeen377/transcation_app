import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';

class CustomButton extends StatelessWidget {
  final Widget buttonContent;
  final void Function()? onTapButton;
  final int? animationIndex;

  const CustomButton(
      {super.key,
      required this.buttonContent,
      required this.onTapButton,
      this.animationIndex});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTapButton,
        child: Container(
            height: 60.h,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColor.brandHighlight,
                  AppColor.brandAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.brandHighlight.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: buttonContent,
            )));
  }
}
