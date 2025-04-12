import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/custom_container.dart';
import 'package:transcation_app/features/home/data/models/plans_response.dart';
import 'package:transcation_app/features/home/presentation/bloc/my_plans/my_plans_cubit.dart';
import 'package:transcation_app/features/home/presentation/bloc/my_plans/my_plans_state.dart';
import 'package:transcation_app/features/home/presentation/pages/plan_details_screen.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({Key? key}) : super(key: key);

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                automaticallyImplyLeading: false,

        title: Text(
          'خططي الاستثمارية',
          style: TextStyle(
            color: AppColor.brandHighlight,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.darkGray,
      ),
      body: BlocBuilder<MyPlansCubit, MyPlansState>(
        builder: (context, state) {
          if (state.isLoading || state.isInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.brandHighlight,
              ),
            );
          }

          final activePlans = state.activePlans ?? [];
          if (activePlans.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 64.sp,
                    color: AppColor.brandHighlight,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'لا توجد خطط نشطة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'لم تستثمر في أي خطط حتى الآن',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: activePlans.length,
            itemBuilder: (context, index) {
              final activePlan = activePlans[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlanDetailsScreen(activePlan: activePlan),
                      ),
                    );
                  },
                  child: CustomContainer(
                    horizontal: 0,
                    child: Stack(
                      children: [
                        if (activePlan.plan.special == 1)
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.brandHighlight,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.r),
                                  bottomRight: Radius.circular(15.r),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'مميزة',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12.r),
                                    decoration: BoxDecoration(
                                      color: AppColor.brandHighlight.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Icon(
                                      Icons.diamond_outlined,
                                      size: 24.sp,
                                      color: AppColor.brandHighlight,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      activePlan.plan.name,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: activePlan.status.toLowerCase() == 'active'
                                          ? Colors.green.withOpacity(0.2)
                                          : Colors.orange.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      activePlan.status,
                                      style: TextStyle(
                                        color: activePlan.status.toLowerCase() == 'active'
                                            ? Colors.green
                                            : Colors.orange,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  _buildDetailItem(
                                    'العائد',
                                    '${activePlan.plan.profitMargin}%',
                                    Icons.trending_up,
                                  ),
                                  SizedBox(width: 24.w),
                                  _buildDetailItem(
                                    'المدة',
                                    '${activePlan.plan.durationDays} يوم',
                                    Icons.timer_outlined,
                                  ),
                                  SizedBox(width: 24.w),
                                  _buildDetailItem(
                                    'الاستثمار',
                                    '${activePlan.plan.price} \$',
                                    Icons.attach_money,
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'انقر للتفاصيل',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColor.brandHighlight,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Widget _buildDetailItem(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: AppColor.brandHighlight,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
