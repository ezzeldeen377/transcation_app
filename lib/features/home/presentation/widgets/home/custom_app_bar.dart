import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/text_styles.dart';
import 'package:transcation_app/features/home/presentation/bloc/home/home_cubit_cubit.dart';
import 'package:transcation_app/features/home/presentation/pages/notification_page.dart';
import 'package:transcation_app/features/home/presentation/pages/menu_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.darkGray,
      elevation: 4,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: AppColor.darkGray,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: BlocBuilder<HomeCubit, HomeState>(
            
            builder: (context, state) {
                  final userIdentifier=state.user?.userIdentifier??"null";

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: userIdentifier.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('User ID copied to clipboard')),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColor.brandDark,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "ID: $userIdentifier",
                            style: TextStyles.fontCircularSpotify12GreyRegular,
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.copy, color: AppColor.brandHighlight),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications,
                            color: AppColor.brandHighlight),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.notification);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.menu, color: AppColor.brandHighlight),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.menu);
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
