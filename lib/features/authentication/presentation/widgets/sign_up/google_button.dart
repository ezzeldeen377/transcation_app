
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transcation_app/core/theme/app_color.dart';

class GoogleButton extends StatelessWidget {
  final void Function()? onTapButton;
  final bool isLoading;
  const GoogleButton(
      {super.key, required this.onTapButton, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTapButton,
      child: Container(
        height: 45.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color:  AppColor.brandHighlight.withOpacity(.3),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.brandHighlight,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/google.svg'),
                  SizedBox(width: 5.w),
                  Text(
                    "Connect with Google",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.brandBlack,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
