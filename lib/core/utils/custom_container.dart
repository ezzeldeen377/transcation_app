import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child, this.horizontal=10,});
  final Widget child;
  final double? horizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: horizontal!.w),
      decoration: BoxDecoration(
        color: AppColor.darkGray,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColor.brandPrimary.withOpacity(0.3),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.brandDark.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
