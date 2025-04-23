import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/text_styles.dart';

class ActionButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    Key? key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.darkGray,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.brandHighlight.withOpacity(0.08),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: AppColor.brandHighlight.withOpacity(0.15),
            width: 1,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: AppColor.brandHighlight.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    imagePath,
                    width: 18.w,
                    height: 18.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                label,
                style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
                  color: AppColor.brandAccent,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}