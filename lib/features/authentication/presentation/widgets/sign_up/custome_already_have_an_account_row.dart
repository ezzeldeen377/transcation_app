
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';

class CustomeAlreadyHaveAnAccountRow extends StatelessWidget {
  final VoidCallback onTap;
  const CustomeAlreadyHaveAnAccountRow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          "لديك حساب بالفعل؟",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context,RouteNames.signIn);
          },
          child: Text(
            "تسجيل الدخول",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.brandHighlight,
            ),
          ),
        ),
      ],
    );
  }
}
