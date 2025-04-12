import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/helpers/navigator.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:flutter/services.dart';
import 'package:transcation_app/core/theme/text_styles.dart';
import 'package:transcation_app/core/utils/custom_container.dart';
import 'package:transcation_app/features/home/presentation/bloc/home/home_cubit_cubit.dart';
import 'package:transcation_app/features/home/presentation/pages/notification_page.dart';
import 'package:transcation_app/features/home/presentation/pages/menu_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:transcation_app/features/home/presentation/widgets/home/custom_app_bar.dart';
import 'package:transcation_app/features/home/presentation/widgets/home/investment_plans_carousel.dart';
import 'package:transcation_app/features/home/presentation/widgets/home/user_balance.dart';
import 'package:transcation_app/features/home/presentation/widgets/profit_card.dart';
import 'package:transcation_app/features/home/presentation/widgets/home/investment_card.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:collection/collection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.controller});
  final PageController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
 

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.isSubscribePlan) {
          context.read<HomeCubit>().getUserActivePlan(
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
                    color: AppColor.brandAccent,
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
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Remove ColorList from _HomePageState as it's no longer needed

              // In the build method, replace the BlocBuilder with:
              ProfitCard(),
              SizedBox(height: 10.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return UserBalance(
                    pageController: widget.controller,
                    balance: (state.user?.balance ?? 0).toString(),
                  );
                },
              ),
              SizedBox(height: 20.h),
              InvestmentPlansCarousel(),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      'Deposit',
                      Icons.arrow_downward,
                      AppColor.brandPrimary,
                      () {
                        widget.controller.animateToPage(1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                    ),
                    _buildActionButton(
                      'Withdraw',
                      Icons.arrow_upward,
                      AppColor.brandHighlight,
                      () {
                        widget.controller.animateToPage(2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                    ),
                    _buildActionButton(
                      'History',
                      Icons.history,
                      AppColor.brandAccent,
                      () {
                        context.pushNamed(RouteNames.historyPage);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Transactions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        final transactions = state.history;
                        if(state.isLoading||state.isInitial){
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColor.brandHighlight,
                            ), 
                          );
                        }
                        if (transactions == null) {
                          return Center(
                            child: Text(
                              'No recent transactions',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        }

                        final lastDeposit = transactions.deposits.firstOrNull;
                        final lastWithdrawal =
                            transactions.withdrawals.firstOrNull;
                        final lastSubscription =
                            transactions.subscriptions.firstOrNull;
                        // Get plan details for the last subscription
                        final lastPlanDetails = lastSubscription != null
                            ? state.planDetails![lastSubscription.planId]
                            : null;

                        // if (lastDeposit == null &&
                        //     lastWithdrawal == null &&
                        //     lastSubscription == null) {
                        //   return Center(
                        //     child: Text(
                        //       'No recent transactions',
                        //       style: TextStyle(
                        //         color: Colors.white70,
                        //         fontSize: 14.sp,
                        //       ),
                        //     ),
                        //   );
                        // }

                        return Column(
                          children: [
                            if (lastDeposit != null)
                              _buildTransactionItem(
                                'Deposit',
                                '+\$${lastDeposit.amount}',
                                timeago.format(lastDeposit.createdAt),
                                Icons.arrow_downward,
                                AppColor.brandPrimary,
                              )
                            else
                              _buildEmptyTransactionItem(
                                'No Recent Deposits',
                                Icons.arrow_downward,
                                AppColor.brandPrimary.withOpacity(0.5),
                              ),
                            if (lastWithdrawal != null)
                              _buildTransactionItem(
                                'Withdraw',
                                '-\$${lastWithdrawal.amount}',
                                timeago.format(lastWithdrawal.createdAt),
                                Icons.arrow_upward,
                                AppColor.brandHighlight,
                              )
                            else
                              _buildEmptyTransactionItem(
                                'No Recent Withdrawals',
                                Icons.arrow_upward,
                                AppColor.brandHighlight.withOpacity(0.5),
                              ),
                            if (lastSubscription != null)
                              _buildTransactionItem(
                                lastPlanDetails?.plan.name ?? 'Investment',
                                '-\$${lastPlanDetails?.plan.price}',
                                timeago.format(lastSubscription.createdAt),
                                Icons.account_balance,
                                AppColor.brandAccent,
                              )
                            else
                              _buildEmptyTransactionItem(
                                'No Active Investments',
                                Icons.account_balance,
                                AppColor.brandAccent.withOpacity(0.5),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.8),
              color.withOpacity(0.4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 24.sp),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
    String title,
    String amount,
    String status,
    IconData icon,
    Color color,
  ) {
    return CustomContainer(
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.8),
                color.withOpacity(0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          status,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.sp,
          ),
        ),
        trailing: Text(
          amount,
          style: TextStyle(
            color:
                amount.startsWith('+') ? AppColor.brandPrimary : Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyTransactionItem(
      String title,
      IconData icon,
      Color color,
    ) {
      return CustomContainer(
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.3),
                  color.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: Colors.white.withOpacity(0.5)),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
}
