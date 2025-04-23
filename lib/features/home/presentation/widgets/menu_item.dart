import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/text_styles.dart';
import 'package:transcation_app/core/utils/custom_container.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Widget? trailing;

  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          leading: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColor.brandHighlight,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: AppColor.brandHighlight.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColor.white,
              size: 24.sp,
            ),
          ),
          title: Text(
            title,
            style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: trailing ?? const Icon(
            Icons.chevron_right,
            color: AppColor.brandHighlight,
          ),
        ),
      ),
    );
  }
}