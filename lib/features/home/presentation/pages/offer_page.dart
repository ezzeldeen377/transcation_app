import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/home/data/models/active_plans_response.dart';
import 'package:transcation_app/features/home/data/models/plans_response.dart';
import 'package:transcation_app/features/home/presentation/bloc/home/home_cubit_cubit.dart';
import 'package:transcation_app/features/home/presentation/bloc/offer/offer_cubit.dart';
import 'package:transcation_app/features/home/presentation/widgets/home/investment_card.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
     int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<OfferCubit, OfferState>(
      listener: (context, state) {
        if (state.isSubscribePlan) {
          context.read<OfferCubit>().getUserActivePlan(
              context.read<AppUserCubit>().state.accessToken!);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppColor.darkGray,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: AppColor.brandPrimary,
                    size: 50.sp,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Success!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Your plan has been subscribed successfully.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.brandPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 10.h,
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Special Offers',
              style: TextStyle(
                color: AppColor.brandHighlight,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppColor.darkGray,
          ),
          body:

               SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured Offers Section
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        'Featured Offers',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                     BlocBuilder<OfferCubit, OfferState>(
      builder: (context, state) {
        final plans = state.offers ?? [];
        final activeUserPlan = state.userActivePlans ?? [];
        if (state.isLoading || state.isInitial) {
          return AspectRatio(
      aspectRatio:  16/14,
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
              'No investment plans available.',
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
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: CarouselSlider.builder(
                itemCount: plans.length,
                options: CarouselOptions(
                  aspectRatio:14/16,
                  clipBehavior: Clip.none,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                  enlargeFactor: 0.2, 
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
    ),
                    
                    // Benefits Section
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Why Choose Our Special Offers?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            _buildBenefitItem(
                              Icons.star,
                              'Exclusive Benefits',
                              'Get access to premium features and higher returns',
                            ),
                            SizedBox(height: 12.h),
                            _buildBenefitItem(
                              Icons.trending_up,
                              'Enhanced Returns',
                              'Enjoy higher profit margins than standard plans',
                            ),
                            SizedBox(height: 12.h),
                            _buildBenefitItem(
                              Icons.timer,
                              'Limited Time',
                              'Don\'t miss out on these time-sensitive opportunities',
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // How It Works Section
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColor.brandAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColor.brandAccent.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How It Works',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            _buildStepItem(
                              '1',
                              'Choose Your Plan',
                              'Select from our exclusive special offers',
                            ),
                            _buildStepItem(
                              '2',
                              'Subscribe',
                              'Complete the subscription process',
                            ),
                            _buildStepItem(
                              '3',
                              'Earn Returns',
                              'Watch your investment grow with higher returns',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    ))         );
            }
          
    
  }
bool isPlanActive(int planId, List<ActivePlan> activeUserPlans) {
    return activeUserPlans.any((activePlan) => activePlan.plan.id == planId);
  }
 

  Widget _buildBenefitItem(IconData icon, String title, String description) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColor.brandAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: AppColor.brandHighlight, size: 24.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepItem(String number, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: AppColor.brandHighlight,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

