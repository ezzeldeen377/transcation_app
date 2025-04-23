import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/text_styles.dart';
import 'package:transcation_app/core/utils/custom_container.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final IconData icon;

  const NotificationItem({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        trailing: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColor.brandHighlight,
                AppColor.brandAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: AppColor.brandHighlight.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
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
          textDirection: TextDirection.rtl,
          style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
            color: AppColor.brandPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            Text(
              description,
              textDirection: TextDirection.rtl,
              style: TextStyles.fontCircularSpotify12GreyRegular.copyWith(
                color: AppColor.white.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              time,
              textDirection: TextDirection.rtl,
              style: TextStyles.fontCircularSpotify12GreyRegular.copyWith(
                color: AppColor.errorLightColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}