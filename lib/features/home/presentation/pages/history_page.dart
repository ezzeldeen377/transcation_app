import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/home/data/models/transaction_history_response.dart';
import 'package:transcation_app/features/home/presentation/bloc/history/history_cubit.dart';
import 'package:transcation_app/features/home/presentation/bloc/history/history_state.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.darkGray,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'سجل المعاملات',
            style: TextStyle(
              color: AppColor.brandHighlight,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColor.darkGray,
          bottom: TabBar(
            indicatorColor: AppColor.brandHighlight,
            indicatorWeight: 3,
            labelColor: AppColor.brandHighlight,
            unselectedLabelColor: Colors.white60,
            labelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.arrow_upward_rounded),
                text: 'السحوبات',
              ),
              Tab(
                icon: Icon(Icons.arrow_downward_rounded),
                text: 'الإيداعات',
              ),
              Tab(
                icon: Icon(Icons.assignment_rounded),
                text: 'الخطط',
              ),
            ],
          ),
        ),
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.brandHighlight,
                ),
              );
            }
            
            return TabBarView(
              children: [
                _buildWithdrawalsList(state.history?.withdrawals ?? []),
                _buildDepositsList(state.history?.deposits ?? []),
                _buildSubscriptionsList(state.history?.subscriptions ?? []),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildWithdrawalsList(List<Withdrawal> withdrawals) {
    if (withdrawals.isEmpty) {
      return _buildEmptyState(
        'لا توجد سحوبات حتى الآن',
        Icons.arrow_upward_rounded,
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.sp),
      itemCount: withdrawals.length,
      itemBuilder: (context, index) {
        final withdrawal = withdrawals[index];
        String method = 'تحويل بنكي';
        String details = withdrawal.bank ?? '';
        
        if (withdrawal.western != null) {
          method = 'ويسترن يونيون';
          details = withdrawal.western!;
        } else if (withdrawal.moneyOffice != null) {
          method = 'مكتب الصرافة';
          details = withdrawal.moneyOffice!;
        } else if (withdrawal.usdt != null) {
          method = 'عملات رقمية';
          details = withdrawal.usdt!;
        }

        return _buildTransactionCard(
          amount: withdrawal.amount,
          date: withdrawal.createdAt,
          method: method,
          details: details,
          isWithdrawal: true,
        );
      },
    );
  }

  Widget _buildDepositsList(List<Deposit> deposits) {
    if (deposits.isEmpty) {
      return _buildEmptyState(
        'لا توجد إيداعات حتى الآن',
        Icons.arrow_downward_rounded,
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.sp),
      itemCount: deposits.length,
      itemBuilder: (context, index) {
        final deposit = deposits[index];
        return _buildTransactionCard(
          amount: deposit.amount,
          date: deposit.createdAt,
          method: 'إيداع',
          details: 'إيداع في الحساب',
          isWithdrawal: false,
        );
      },
    );
  }

  Widget _buildTransactionCard({
    required String amount,
    required DateTime date,
    required String method,
    required String details,
    required bool isWithdrawal,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.darkGray.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColor.brandHighlight.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.brandHighlight.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: (isWithdrawal ? Colors.red : Colors.green).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isWithdrawal ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isWithdrawal ? Colors.red : Colors.green,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              method,
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$$amount',
                              style: TextStyle(
                                color: isWithdrawal ? Colors.red : Colors.green,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        if (details.isNotEmpty)
                          Text(
                            details,
                            style: TextStyle(
                              color: AppColor.white.withOpacity(0.7),
                              fontSize: 14.sp,
                            ),
                          ),
                        SizedBox(height: 4.h),
                        Text(
                          _formatDate(date),
                          style: TextStyle(
                            color: AppColor.white.withOpacity(0.5),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    String formatNumber(int n) => n.toString()
        .replaceAll('0', '٠')
        .replaceAll('1', '١')
        .replaceAll('2', '٢')
        .replaceAll('3', '٣')
        .replaceAll('4', '٤')
        .replaceAll('5', '٥')
        .replaceAll('6', '٦')
        .replaceAll('7', '٧')
        .replaceAll('8', '٨')
        .replaceAll('9', '٩');

    return '${formatNumber(date.day)}/${formatNumber(date.month)}/${formatNumber(date.year)} ${formatNumber(date.hour)}:${formatNumber(date.minute).padLeft(2, '٠')}';
  }

  Widget _buildSubscriptionsList(List<Subscription> subscriptions) {
    if (subscriptions.isEmpty) {
      return _buildEmptyState(
        'لا توجد خطط نشطة',
        Icons.assignment_rounded,
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        final subscription = subscriptions[index];
        final planDetail = context.read<HistoryCubit>().state.planDetails[subscription.planId];

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColor.darkGray.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: AppColor.brandHighlight.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: AppColor.brandHighlight.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.assignment_rounded,
                    color: AppColor.brandHighlight,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              planDetail?.plan.name ?? 'Plan #${subscription.planId}',
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColor.brandHighlight.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '\$${planDetail?.plan.price ?? ''}',
                              style: TextStyle(
                                color: AppColor.brandHighlight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      if (planDetail != null) ...[
                        _buildSubscriptionDetail(
                          'هامش الربح',
                          planDetail.plan.profitMargin,
                        ),
                        SizedBox(height: 4.h),
                      ],
                      _buildSubscriptionDetail(
                        'تاريخ الانتهاء',
                        subscription.expiratoryDate.toString().split(' ')[0],
                      ),
                      SizedBox(height: 4.h),
                      _buildSubscriptionDetail(
                        'تاريخ الاشتراك',
                        subscription.createdAt.toString().split(' ')[0],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubscriptionDetail(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            color: AppColor.white.withOpacity(0.5),
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColor.white.withOpacity(0.7),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48.sp,
            color: AppColor.brandHighlight.withOpacity(0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}