import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/custom_container.dart';
import 'package:transcation_app/features/home/domain/models/plan.dart';
import 'package:transcation_app/features/home/presentation/pages/profit_page.dart';

class PlanDetailsScreen extends StatefulWidget {
  final Plan plan;

  const PlanDetailsScreen({Key? key, required this.plan}) : super(key: key);

  @override
  State<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {
  late DateTime startTime;
  double progress = 0.04;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    // _startTimer();
  }

  // void _startTimer() {
  //   Future.delayed(const Duration(seconds: 1), () {
  //     if (mounted) {
  //       setState(() {
  //         final now = DateTime.now();
  //         final difference = now.difference(startTime);
  //         final durationInHours = int.parse(widget.plan.duration.split(' ')[0]);
  //         progress = (difference.inHours / (durationInHours * 24)).clamp(0.0, 1.0);
  //       });
  //       _startTimer();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.plan.type,
          style: TextStyle(
            color: AppColor.brandHighlight,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.darkGray,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.brandHighlight),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomContainer(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Returns', '${widget.plan.returns}%'),
                    SizedBox(height: 8.h),
                    _buildInfoRow('Status', widget.plan.status),
                    SizedBox(height: 8.h),
                    _buildInfoRow('Minimum Investment', '${widget.plan.minInvestment}'),
                    SizedBox(height: 8.h),
                    _buildInfoRow('Duration', widget.plan.duration),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time Progress',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.grey[800],
                                valueColor: AlwaysStoppedAnimation<Color>(AppColor.brandHighlight),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${(progress * 100).toStringAsFixed(1)}%',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColor.brandHighlight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.w),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfitPage(plan: widget.plan),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: AppColor.brandHighlight.withOpacity(0.1),
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          ),
                          child: Text(
                            'View Profit',
                            style: TextStyle(
                              color: AppColor.brandHighlight,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.brandHighlight,
              ),
            ),
            SizedBox(height: 8.h),
            CustomContainer(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  widget.plan.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Benefits',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.brandHighlight,
              ),
            ),
            SizedBox(height: 8.h),
            CustomContainer(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: widget.plan.benefits.map((benefit) => _buildBenefitItem(benefit)).toList(),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Historical Performance',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.brandHighlight,
              ),
            ),
            SizedBox(height: 8.h),
            CustomContainer(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: widget.plan.historicalPerformance.entries
                      .map((entry) => _buildPerformanceItem(entry.key, entry.value))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.brandHighlight,
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitItem(String benefit) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: AppColor.brandHighlight,
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              benefit,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(String year, double performance) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            year,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white70,
            ),
          ),
          Text(
            '${performance.toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.brandHighlight,
            ),
          ),
        ],
      ),
    );
  }
}