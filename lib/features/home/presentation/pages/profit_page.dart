import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/custom_container.dart';
import 'package:transcation_app/features/home/data/models/plans_response.dart';

class ProfitPage extends StatelessWidget {
  final Plan plan;

  const ProfitPage({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل الربح',
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
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
                      _buildProfitRow('الاستثمار المبدئي', '${plan.price}'),
                      SizedBox(height: 8.h),
                      _buildProfitRow('العائد الحالي', '${plan.profitMargin}%'),
                      SizedBox(height: 8.h),
                      _buildProfitRow('الربح المتوقع', '${_calculateEstimatedProfit()}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfitRow(String label, String value) {
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

  String _calculateEstimatedProfit() {
    final investment = double.parse(plan.price.toString());
    final returns = double.parse(plan.profitMargin.toString());
    final profit = (investment * returns) / 100;
    return profit.toStringAsFixed(2);
  }
}