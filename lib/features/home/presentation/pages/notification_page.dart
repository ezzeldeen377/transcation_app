import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/home/presentation/bloc/home/home_cubit_cubit.dart';
import 'package:transcation_app/features/home/presentation/widgets/notification_item.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_localizations/flutter_localizations.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGray,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          backgroundColor: AppColor.darkGray,
          elevation: 0,
          title: Text(
            'الإشعارات',
            style: TextStyle(
              color: AppColor.brandHighlight,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.brandHighlight,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading || state.isInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.brandHighlight,
              ),
            );
          }

          final notifications = state.notifications ?? [];
          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 48.sp,
                    color: AppColor.brandHighlight,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'لا توجد إشعارات حتى الآن',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return NotificationItem(
                title: notifications[index].title,
                description: notifications[index].message,
                time: timeago.format(notifications[index].createdAt,locale: 'ar'),
                icon: Icons.new_releases,
              );
            },
          );
        },
      ),
     ) );
  }
}
