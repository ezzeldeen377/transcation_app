import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/home/presentation/bloc/home/home_cubit_cubit.dart';

class UserBalance extends StatelessWidget {
  const UserBalance({super.key, this.pageController, required this.balance});
  final PageController? pageController;
  final String balance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(color: AppColor.brandDark, width: 0.3),
        ),
        leading: SvgPicture.asset(
          'assets/icons/balance.svg',
          color: AppColor.brandHighlight,
        ),
        title: Text(
          'Total Balance',
          style: TextStyle(
            color: AppColor.brandHighlight,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '\$$balance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.add, color: AppColor.brandHighlight),
          onPressed: () {
            if (pageController != null) {
              pageController!.animateToPage(
                1,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
      ),
    );
  }
}
