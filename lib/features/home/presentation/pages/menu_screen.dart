import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
import 'package:transcation_app/features/home/presentation/widgets/action_button.dart';
import 'package:transcation_app/features/home/presentation/widgets/menu_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  final String whatsappLink = "https://wa.me/message/66NFNOEP3S3LC1";
  final String websiteLink = "https://ethraawalet.com/";
    final String termsLink="https://www.termsfeed.com/live/dfa918d5-54c3-4730-bd02-544269a6c90f";


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

  Future<bool?> _showDeleteAccountDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColor.darkGray,
        title: Text(
          'حذف الحساب',
          style: TextStyles.fontCircularSpotify16BlackMedium.copyWith(
            color: AppColor.brandPrimary,
          ),
        ),
        content: Text(
          'هل أنت متأكد أنك تريد حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.',
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
                  .deleteAccount(context.read<AppUserCubit>().state.accessToken!);
            },
            child: Text(
              'حذف الحساب',
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
        if(state.isSuccessDeleteAccount){
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
                  child: Container(
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      color: AppColor.darkGray,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.brandHighlight.withOpacity(0.08),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: AppColor.brandHighlight.withOpacity(0.13),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColor.brandHighlight,
                                    AppColor.brandPrimary,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              padding: EdgeInsets.all(3.5.w),
                              child: CircleAvatar(
                                radius: 34.r,
                                backgroundColor: AppColor.darkGray,
                                child: Icon(
                                  Icons.person,
                                  size: 34.sp,
                                  color: AppColor.brandHighlight,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -2,
                              right: -2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.darkGray,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColor.brandPrimary,
                                    width: 1.5,
                                  ),
                                ),
                                padding: EdgeInsets.all(2),
                                child: Icon(
                                  Icons.verified,
                                  size: 16.sp,
                                  color: AppColor.brandPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 18.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.name ?? "",
                                style: TextStyles.fontCircularSpotify16BlackMedium.copyWith(
                                  color: AppColor.brandAccent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                user?.email ?? "",
                                style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
                                  color: AppColor.errorLightColor.withOpacity(0.7),
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: AppColor.brandPrimary.withOpacity(0.13),
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      size: 12.sp,
                                      color: AppColor.brandPrimary,
                                    ),
                                    SizedBox(width: 3.w),
                                    Text(
                                      'تم التحقق',
                                      style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
                                        color: AppColor.brandPrimary,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Add this block below the user info
                SizedBox(height: 16.h),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                //   child: Row(
                //     children: [
                //       ActionButton(
                //         imagePath: 'assets/icons/deposit.png',
                //         label: 'إيداع',
                //         onTap: () {
                //           // TODO: Add deposit action
                //         },
                //       ),
                //       SizedBox(width: 16.w),
                //       ActionButton(
                //         imagePath: 'assets/icons/withdraw.png',
                //         label: 'سحب',
                //         onTap: () {
                //           // TODO: Add withdraw action
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 24.h),
                // Menu Items
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      MenuItem(
                        icon: Icons.lock,
                        title: 'الخصوصية والأمان',
                        onTap: () {
  customelaunchUrl(termsLink, context);                        },
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
                      // In the Column of MenuItem widgets, add this before the logout option:
                      MenuItem(
                        icon: Icons.delete_forever,
                        title: 'حذف الحساب',
                        onTap: () async {
                          await _showDeleteAccountDialog(context);
                         
                        },
                      ),
                      MenuItem(
                        icon: Icons.logout,
                        title: 'تسجيل الخروج',
                        onTap: () async {
                         await _showLogoutDialog(context);
                         
                        },
                      ),
                      // Add this in your MenuScreen or another appropriate widget
                   
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
