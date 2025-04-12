import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_state.dart';
import 'package:transcation_app/core/helpers/navigator.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/text_styles.dart';
import 'package:transcation_app/core/utils/web_view.dart';
import 'package:transcation_app/features/home/presentation/widgets/menu_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  final String whatsappLink = "https://wa.me/message/66NFNOEP3S3LC1";
  final String websiteLink = "https://ethraawalet.com/";

  Future<bool?> _showLogoutDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColor.darkGray,
        title: Text(
          'تسجيل الخروج',
          style: TextStyles.fontCircularSpotify16BlackMedium.copyWith(
            color: AppColor.brandPrimary,
          ),
        ),
        content: Text(
          'هل أنت متأكد أنك تريد تسجيل الخروج؟',
          style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
            color: AppColor.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'إلغاء',
              style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
                color: AppColor.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
              context
                  .read<AppUserCubit>()
                  .onLogout(context.read<AppUserCubit>().state.accessToken!);
            },
            child: Text(
              'تسجيل الخروج',
              style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
                color: AppColor.brandHighlight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUserCubit>().state.user;
    return BlocListener<AppUserCubit, AppUserState>(
      listener: (context, state) {
        if (state.isClearUserData) {
          context.pushNamedAndRemoveAll(RouteNames.signIn);
        }
        if (state.isSignOut) {
          context.read<AppUserCubit>().clearUserData();
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.darkGray,
        appBar: AppBar(
          backgroundColor: AppColor.darkGray,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColor.brandHighlight),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'القائمة',
            style: TextStyles.fontCircularSpotify16BlackMedium.copyWith(
              color: AppColor.brandHighlight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                // User Profile Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            backgroundColor:
                                AppColor.brandHighlight.withOpacity(0.1),
                            child: Icon(
                              Icons.person,
                              size: 40.sp,
                              color: AppColor.brandHighlight,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: AppColor.brandHighlight,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColor.white, width: 2),
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 12.sp,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? "",
                              style: TextStyles.fontCircularSpotify16BlackMedium
                                  .copyWith(
                                color: AppColor.brandAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              user?.email ?? "",
                              style: TextStyles.fontCircularSpotify14BlackMedium
                                  .copyWith(
                                color:
                                    AppColor.errorLightColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                // Menu Items
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      MenuItem(
                        icon: Icons.settings,
                        title: 'الإعدادات',
                        onTap: () {
                          // Navigate to Settings screen
                        },
                      ),
                      MenuItem(
                        icon: Icons.lock,
                        title: 'الخصوصية والأمان',
                        onTap: () {
                          // Navigate to Privacy & Security screen
                        },
                      ),
                      MenuItem(
                        icon: Icons.help_outline,
                        title: 'المساعدة والدعم',
                        onTap: () {
                          // Navigate to Help & Support screen
                          customelaunchUrl(whatsappLink, context);
                        },
                      ),
                      MenuItem(
                        icon: Icons.info_outline,
                        title: 'حول',
                        onTap: () {
                          // Navigate to About screen
                                                    customelaunchUrl(websiteLink, context);

                        },
                      ),
                      MenuItem(
                        icon: Icons.logout,
                        title: 'تسجيل الخروج',
                        onTap: () async {
                          final shouldLogout = await _showLogoutDialog(context);
                          if (shouldLogout == true) {
                            // Implement logout logic
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
