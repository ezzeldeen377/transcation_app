import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/home/data/models/active_plans_response.dart';
import 'package:transcation_app/features/home/presentation/bloc/home/home_cubit_cubit.dart';
import 'package:transcation_app/features/home/presentation/widgets/home/investment_card.dart';

class InvestmentPlansCarousel extends StatefulWidget {
  const InvestmentPlansCarousel({super.key});

  @override
  State<InvestmentPlansCarousel> createState() => _InvestmentPlansCarouselState();
}

class _InvestmentPlansCarouselState extends State<InvestmentPlansCarousel> {
  int _currentIndex = 0;


  bool isPlanActive(int planId, List<ActivePlan> activeUserPlans) {
    return activeUserPlans.any((activePlan) => activePlan.plan.id == planId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final plans = state.plans ?? [];
        final activeUserPlan = state.userActivePlans ?? [];
        if (state.isLoading || state.isInitial) {
          return AspectRatio(
            aspectRatio: 16/15,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColor.brandHighlight,
              ),
            ),
          );
        } else if (plans.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(
              'لا توجد خطط استثمارية متاحة',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h),  // Increased from 10.h
              child: CarouselSlider.builder(
                itemCount: plans.length,
                options: CarouselOptions(
                  aspectRatio: 20/19,  // Changed from 18/17 to give more height
                  clipBehavior: Clip.none,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,  // Increased from 0.8
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                  enlargeFactor: 0.16,  // Increased from 0.2
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                // In the itemBuilder, you can now use:
                itemBuilder: (context, index, realIndex) {
                  var plan = plans[index];
                  ActivePlan? activePlan = activeUserPlan.firstWhere(
                    (active) => active.plan.id == plan.id,
                    orElse: () => ActivePlan(
                      plan: plan, // Provide a default ActivePlan if needed
                      status: 'inactive',
                      profit: 0.0,
                      expiryDate: '',
                      startDate: '',
                    ),
                  );
                  return InvestmentCard(
                    activePlan: activePlan,
                    isActive: isPlanActive(plan.id, activeUserPlan),
                  );
                },
              ),
            ),
            verticalSpace(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: plans.asMap().entries.map((entry) {
                return Container(
                  width: 8.w,
                  height: 8.w,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key 
                        ? AppColor.brandHighlight 
                        : AppColor.white,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10.h),
          ],
        );
      },
    );
  }
}