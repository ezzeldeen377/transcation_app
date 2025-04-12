
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/theme/app_color.dart';

class CustomDontHaveAccountRow extends StatelessWidget {
  final VoidCallback onTap;

  const CustomDontHaveAccountRow({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          "ليس لديك حساب؟",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
          )
        ),
        horizontalSpace(5),
        InkWell(
          onTap: onTap,
          child: Text(
            "سجل الآن",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.brandAccent,
            ),
          ),
        ),
      ],
    );
  }
}
