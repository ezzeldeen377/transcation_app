import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/custom_container.dart';
import 'package:transcation_app/features/home/data/models/active_plans_response.dart';
import 'package:transcation_app/features/home/data/models/plans_response.dart';
import 'package:transcation_app/features/home/presentation/bloc/my_plans/my_plans_cubit.dart';
import 'package:transcation_app/features/home/presentation/bloc/my_plans/my_plans_state.dart';
import 'package:transcation_app/features/home/presentation/pages/profit_page.dart';

class PlanDetailsScreen extends StatefulWidget {
  final ActivePlan activePlan;

  const PlanDetailsScreen({super.key, required this.activePlan});

  @override
  State<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen>
    with TickerProviderStateMixin {
  late double progress;
  late int daysRemaining;
  late int daysSpent;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _calculateProgress();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _calculateProgress() {
    startTime = DateTime.parse(
        widget.activePlan.startDate ?? DateTime.now().toString());
    endTime = DateTime.parse(widget.activePlan.expiryDate);
    final now = DateTime.now();
    final totalDays = widget.activePlan.plan.durationDays;
    final difference = now.difference(startTime).inDays;

    daysSpent = difference.clamp(0, totalDays);
    daysRemaining = (totalDays - daysSpent).clamp(0, totalDays);
    progress = (daysSpent / totalDays).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              widget.activePlan.plan.name,
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
                if (widget.activePlan.plan.special == 1)
                  Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColor.brandHighlight.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                          color: AppColor.brandHighlight.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star,
                            color: AppColor.brandHighlight, size: 24.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'خطة خاصة',
                          style: TextStyle(
                            color: AppColor.brandHighlight,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                Stack(
                  children: [
                    CustomContainer(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                                'معرف الخطة', '#${widget.activePlan.plan.id}'),
                            SizedBox(height: 8.h),
                            _buildInfoRow('الحالة', widget.activePlan.status),
                            SizedBox(height: 8.h),
                            _buildInfoRow('مبلغ الاستثمار',
                                '\$${widget.activePlan.plan.price}'),
                            SizedBox(height: 8.h),
                            _buildInfoRow('العائدات',
                                '${widget.activePlan.plan.profitMargin}%'),
                            SizedBox(height: 8.h),
                            _buildInfoRow('المدة',
                                '${widget.activePlan.plan.durationDays} يوم'),
                            SizedBox(height: 8.h),
                            _buildInfoRow(
                                'تاريخ البدء', _formatDate(startTime)),
                            SizedBox(height: 8.h),
                            _buildInfoRow(
                                'تاريخ الانتهاء', _formatDate(endTime)),
                            SizedBox(height: 16.h),
                            Text(
                              'التقدم',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.white,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.grey[800],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.brandHighlight),
                              minHeight: 8.h,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildProgressDetail(
                                  'الأيام المنقضية',
                                  daysSpent.toString(),
                                  Icons.calendar_today,
                                ),
                                _buildProgressDetail(
                                  'الأيام المتبقية',
                                  daysRemaining.toString(),
                                  Icons.timer_outlined,
                                ),
                                _buildProgressDetail(
                                  'التقدم',
                                  '${(progress * 100).toStringAsFixed(1)}%',
                                  Icons.show_chart,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  'الوصف',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.brandHighlight,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomContainer(
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Text(
                            widget.activePlan.plan.description,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.easeInOut,
                        opacity: 1.0,
                        child: AnimatedSlide(
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.easeOutCubic,
                          offset: const Offset(0.0, 0.0),
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 1200),
                            curve: Curves.easeInOut,
                            builder: (context, value, child) => Transform.scale(
                              scale: value,
                              child: Lottie.asset(
                                'assets/animation/coin.json',
                                width: 100.w,
                                repeat: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  'الأرباح',
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
                      children: [
                        SizedBox(height: 8.h),
                        BlocBuilder<MyPlansCubit,MyPlansState>(
                          builder: (context, state) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColor.brandHighlight.withOpacity(0.1),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 4.w,
                                          height: 16.h,
                                          decoration: BoxDecoration(
                                            color: AppColor.brandHighlight,
                                            borderRadius: BorderRadius.circular(2.r),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: Text(
                                            'إجمالي الربح حتي الان ',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white70,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '\$${(state.userActivePlan?.profit??0).toStringAsFixed(1)}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.white,
                                      ),
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColor.brandHighlight, size: 20.sp),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: AppColor.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.brandHighlight.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 4.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: AppColor.brandHighlight,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
