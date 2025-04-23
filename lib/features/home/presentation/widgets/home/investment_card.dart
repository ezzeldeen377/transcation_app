import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/helpers/navigator.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/home/data/models/active_plans_response.dart';
import 'package:transcation_app/features/home/presentation/bloc/home/home_cubit_cubit.dart';
import 'package:transcation_app/features/home/presentation/bloc/offer/offer_cubit.dart';

class InvestmentCard extends StatelessWidget {
  final ActivePlan activePlan;
  final bool isActive;

  const InvestmentCard({
    super.key,
    required this.activePlan,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal:  20.w,vertical: 5.h),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          SizedBox(height: 16.h),
          Text(
            activePlan.plan.description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 20.h),
          _buildMetricsRow(),
          SizedBox(height: 20.h),
          _buildActionButton(context),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15.r),
      gradient: LinearGradient(
        colors: [
          AppColor.brandAccent,
          AppColor.brandAccent.withOpacity(0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColor.brandAccent.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: // In _buildHeader()
                  Text(
                activePlan.plan.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp, // Increased from 22.sp
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.trending_up,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ],
        ),
        if (activePlan.plan.special == 1)
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 18.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Special Offer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp, // Increased from 14.sp
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildMetricsRow() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildMetricRow(
            'العائد',
            '${activePlan.plan.profitMargin}%',
            Icons.show_chart,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Container(
              height: 1,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          _buildMetricRow(
            'المدة',
            '${activePlan.plan.durationDays} يوم',
            Icons.timer_outlined,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Container(
              height: 1,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          _buildMetricRow(
            'الاستثمار',
            '${activePlan.plan.price}\$',
            Icons.account_balance_wallet,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 20.sp),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp, // Increased from 16.sp
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }





  void _showConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: AppColor.darkGray,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تأكيد الاشتراك',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.h),
            _buildDetailRow('اسم الخطة', activePlan.plan.name),
            _buildDetailRow('العائد', activePlan.plan.profitMargin),
            _buildDetailRow('الاستثمار', activePlan.plan.price),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'إلغاء',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle plan subscription
                      activePlan.plan.special == 1
                          ? context.read<OfferCubit>().subscribePlan(
                              context.read<AppUserCubit>().state.accessToken!,
                              activePlan.plan.id)
                          : context.read<HomeCubit>().subscribePlan(
                              context.read<AppUserCubit>().state.accessToken!,
                              activePlan.plan.id);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.brandAccent,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'تأكيد',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Update the _buildActionButton method
  Widget _buildActionButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          print("Tabbbbbbbbbbbbbbbbbbed");
          if (!isActive) {
            _showConfirmationBottomSheet(context);
          } else {
            // Handle view details action
            context.pushNamed(RouteNames.planDetails, arguments: activePlan);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? AppColor.brandAccent : Colors.white,
          foregroundColor: isActive ? Colors.white : AppColor.brandAccent,
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 50.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          isActive ? 'عرض التفاصيل' : 'اختر الخطة',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: isActive ? Colors.white : AppColor.brandAccent,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
