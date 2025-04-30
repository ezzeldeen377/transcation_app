import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/text_styles.dart';


class DateAndCountdownWidget extends StatefulWidget {
  final DateTime startAt;
  final DateTime endAt;
  const DateAndCountdownWidget({super.key, required this.startAt, required this.endAt});

  @override
  State<DateAndCountdownWidget> createState() => _DateAndCountdownWidgetState();
}

class _DateAndCountdownWidgetState extends State<DateAndCountdownWidget> {
  late ValueNotifier<Duration> getRemainingDuration;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    getRemainingDuration = ValueNotifier<Duration>(
        widget.endAt.difference(DateTime.now()));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remainingDuration = widget.endAt.difference(DateTime.now().subtract(Duration(hours: 3)));


      print("startAt ${widget.endAt}");
            print("now ${DateTime.now()}");
            print("remainingDuration ${remainingDuration}");

      if (remainingDuration.isNegative) {
        _timer?.cancel();
        getRemainingDuration.value = Duration.zero;
      } else {
        getRemainingDuration.value = remainingDuration;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    getRemainingDuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColor.brandHighlight.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColor.brandHighlight.withOpacity(0.3),
          width: 1,
        ),
      ),
      child:  Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer_outlined,
                color: AppColor.brandHighlight,
                size: 15.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'الوقت المتبقي',
                style: TextStyle(
                  color: AppColor.brandHighlight,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColor.brandHighlight.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ValueListenableBuilder<Duration>(
              valueListenable: getRemainingDuration,
              builder: (context, duration, child) {
                if (duration.isNegative || duration == Duration.zero) {
                  return Text(
                    'انتهت المدة',
                    style: TextStyle(
                      color: AppColor.brandHighlight,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }

                final days = duration.inDays;
                final hours = (duration.inHours % 24);
                final minutes = (duration.inMinutes % 60);
                final seconds = (duration.inSeconds % 60);

                String timeText = '';
                if (days > 0) {
                  timeText = '$days يوم و ${hours}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
                } else {
                  timeText = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
                }

                return Text(
                  timeText,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
