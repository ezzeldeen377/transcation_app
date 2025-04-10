import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/home/presentation/widgets/notification_item.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  List<Map<String, dynamic>> get _dummyNotifications => [
    {
      'title': 'Payment Received',
      'description': 'You received \$500 from John Doe',
      'time': '2 minutes ago',
      'icon': Icons.payment,
    },
    {
      'title': 'New Message',
      'description': 'You have a new message from support team',
      'time': '15 minutes ago',
      'icon': Icons.message,
    },
    {
      'title': 'Account Update',
      'description': 'Your account details have been updated',
      'time': '1 hour ago',
      'icon': Icons.account_circle,
    },
    {
      'title': 'Security Alert',
      'description': 'New login detected from unknown device',
      'time': '2 hours ago',
      'icon': Icons.security,
    },
    {
      'title': 'Transaction Failed',
      'description': 'Payment to Jane Smith failed',
      'time': '3 hours ago',
      'icon': Icons.error,
    },
    {
      'title': 'Promotion',
      'description': 'Special offer: 20% cashback on next transaction',
      'time': '5 hours ago',
      'icon': Icons.local_offer,
    },
    {
      'title': 'Account Verified',
      'description': 'Your account verification is complete',
      'time': '1 day ago',
      'icon': Icons.verified,
    },
    {
      'title': 'New Feature',
      'description': 'Check out our new investment options',
      'time': '2 days ago',
      'icon': Icons.new_releases,
    },
    {
      'title': 'Payment Due',
      'description': 'Upcoming payment reminder for loan',
      'time': '3 days ago',
      'icon': Icons.calendar_today,
    },
    {
      'title': 'Profile Update',
      'description': 'Please update your profile information',
      'time': '4 days ago',
      'icon': Icons.person_outline,
    },
  ];

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
            'Notifications',
            style: TextStyle(
              color: AppColor.brandHighlight,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.brandHighlight,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        itemCount: _dummyNotifications.length,
        itemBuilder: (context, index) {
          final notification = _dummyNotifications[index];
          return NotificationItem(
            title: notification['title'],
            description: notification['description'],
            time: notification['time'],
            icon: notification['icon'],
          );
        },
      ),
    );
  }
}