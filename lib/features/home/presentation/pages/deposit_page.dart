import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/helpers/notification_helper.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/web_view.dart';
import 'package:transcation_app/features/home/presentation/bloc/deposit/deposit_cubit.dart';
import 'package:transcation_app/features/home/presentation/widgets/home/user_balance.dart';
import 'package:url_launcher/url_launcher.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  final String binancePayId = 'your_binance_pay_id';
  final String whatsappLink = "https://wa.me/message/66NFNOEP3S3LC1";
  final String telegramLink = "https://telegram.me/Ethraawalet";

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $urlString: $e');
    }
  }

  Widget _buildDepositOption(
    String title,
    Widget icon,
    String subtitle,
    String details,
    List<Map<String, String>> copyItems,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.brandDark.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColor.brandSecondary.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            color: AppColor.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: icon,
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: AppColor.white.withOpacity(0.7),
            fontSize: 14.sp,
          ),
        ),
        backgroundColor: Colors.transparent,
        collapsedIconColor: AppColor.brandHighlight,
        iconColor: AppColor.brandHighlight,
        children: [
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...copyItems
                    .map((item) => Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                item['title'] ?? '',
                                style: TextStyle(
                                  color: AppColor.white.withOpacity(0.9),
                                  fontSize: 14.sp,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.copy,
                                    color: AppColor.brandHighlight),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                    text: item['value'] ?? '',
                                  )).then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('تم نسخ العنوان إلى الحافظة'),
                                        backgroundColor:
                                            AppColor.brandHighlight,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(16.sp),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ))
                    .toList(),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String text) {
      return Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          children: [
            Icon(Icons.circle, size: 8.sp, color: AppColor.brandHighlight),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                color: AppColor.white.withOpacity(0.9),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    }

  Widget _buildInstructionsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.sp),
      decoration: BoxDecoration(
        color: AppColor.brandDark.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColor.brandSecondary.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: AppColor.brandHighlight),
                SizedBox(width: 8.w),
                Text(
                  'تعليمات الشحن',
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildInstructionItem('قم بتحديد المبلغ المراد شحنه'),
            _buildInstructionItem('اختر طريقة الدفع المناسبة'),
            _buildInstructionItem('قم بتأكيد معلومات الدفع'),
            _buildInstructionItem('انتظر رسالة تأكيد العملية'),
            _buildInstructionItem('سيتم إضافة الرصيد تلقائياً لحسابك'),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: AppColor.brandHighlight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: AppColor.brandHighlight, size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'يتم تنفيذ عمليات الشحن خلال 10 دقائق',
                      style: TextStyle(
                        color: AppColor.white.withOpacity(0.9),
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGray,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'الإيداع',
          style: TextStyle(
            color: AppColor.brandHighlight,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.darkGray,
      ),
      body: RefreshIndicator(
        color: AppColor.brandHighlight,
        backgroundColor: AppColor.darkGray,
        onRefresh: () async {
          // Trigger balance refresh
          context.read<DepositCubit>().getBalance(token:context.read<AppUserCubit>().state.accessToken!);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
            child: Column(
              children: [
                BlocBuilder<DepositCubit, DepositState>(
                  builder: (context, state) {
                    return UserBalance(
                      balance: (state.balance ?? 0.0).toString(),
                    );
                  },
                ),
                verticalSpace(20),
                _buildInstructionsCard(),
               
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:  SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: ElevatedButton(
                      onPressed: () =>
                          // {
                          //   NotificationHelper.sendNotification(
                          //     'eMZNXJ-ZQx27APpX5jvnnw:APA91bEM99T79Ygl_PaoSlmQ4QhIFqr_UtPjchXp0umdcwjmLlQLhlRvDZq1z3xdNAARErJZHCom8mHrSBojpq379G_duRj-j-jXNR7Jx9k57Of1BYVMlio',
                          //     'تم إرسال طلب إيداع',
                          //     'تم إرسال طلب إيداع بنجاح',
                          //   );
                          // },
                          _launchUrl('https://ethraawalet.com/payment'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.brandHighlight,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.account_balance_wallet, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'اشحن الآن',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
