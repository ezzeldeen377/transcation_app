import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/show_snack_bar.dart';
import 'package:transcation_app/features/home/data/models/active_plans_response.dart';
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
          if(state.isFailure){
         if(state.message!=null) showSnackBar(context,state.message!);
        }
        if (state.isSubscribePlan) {
          context.read<OfferCubit>().getUserActivePlan(
              context.read<AppUserCubit>().state.accessToken!);
          context.read<OfferCubit>().getPlanReuslt(
              context.read<AppUserCubit>().state.accessToken!,
              state.subscriptedPlan!.planId.toString());
        }
        if (state.isSuccessPlanDetails) {
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
                    color: AppColor.brandAccent,
                    size: 50.sp,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'نجاح!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'تم الاشتراك في الخطة بنجاح.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {

                      Navigator.popAndPushNamed(context,RouteNames.planDetails,arguments: state.userActivePlan);

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.brandAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 10.h,
                      ),
                    ),
                    child: Text(
                      'حسنا',
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
              'العروض الخاصة',
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
                        'العروض المميزة',
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
      aspectRatio:  14/16,
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
              'لا توجد خطط استثمارية متاحة.',
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
                              'لماذا تختار عروضنا الخاصة؟',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            _buildBenefitItem(
                              Icons.star,
                              'مزايا حصرية',
                              'احصل على ميزات متميزة وعوائد أعلى',
                            ),
                            SizedBox(height: 12.h),
                            _buildBenefitItem(
                              Icons.trending_up,
                              'عوائد معززة',
                              'استمتع بهوامش ربح أعلى من الخطط القياسية',
                            ),
                            SizedBox(height: 12.h),
                            _buildBenefitItem(
                              Icons.timer,
                              'عرض محدود',
                              'لا تفوت هذه الفرص المحدودة بوقت معين',
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
                              'كيف يعمل',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            _buildStepItem(
                              '١',
                              'اختر خطتك',
                              'اختر من عروضنا الحصرية المميزة',
                            ),
                            _buildStepItem(
                              '٢',
                              'اشترك',
                              'أكمل عملية الاشتراك',
                            ),
                            _buildStepItem(
                              '٣',
                              'اكسب العوائد',
                              'راقب نمو استثمارك مع عوائد أعلى',
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

