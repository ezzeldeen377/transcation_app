import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/custom_button.dart';
import 'package:transcation_app/core/utils/custom_text_form_field.dart';
import 'package:transcation_app/core/utils/custom_container.dart';
import 'package:transcation_app/features/home/presentation/bloc/deposit/deposit_cubit.dart';
import 'package:transcation_app/features/home/presentation/widgets/home/user_balance.dart';
import 'package:url_launcher/url_launcher.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({Key? key}) : super(key: key);

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedPaymentMethod = '';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  
  final String binancePayId = 'your_binance_pay_id' ;
  final String whatsappLink="https://wa.me/message/66NFNOEP3S3LC1";
  final String telegramLink="https://telegram.me/Ethraawalet";

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error launching URL: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGray,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Deposit',
          style: TextStyle(
            color: AppColor.brandHighlight,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.darkGray,
    
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            BlocBuilder<DepositCubit,DepositState>(
              builder: (context, state) {
                return UserBalance(
                  balance: (state.balance ?? 0.0).toString(),
                );
              },
            ),
            verticalSpace(20),
            _buildDepositOption(
              'Telegram',
               SvgPicture.asset(
                'assets/icons/telegram.svg',
                color: AppColor.brandHighlight,
                width: 24.sp,
                height: 24.sp,
              ),
              'Contact us on Telegram for deposit',
              'Chat with our support team on Telegram to process your deposit.',
              'Open Telegram',
              () => _launchUrl(telegramLink),
            ),
            SizedBox(height: 16.h),
            _buildDepositOption(
              'WhatsApp',
              SvgPicture.asset(
                'assets/icons/whatsapp.svg',
                color: AppColor.brandHighlight,
                width: 24.sp,
                height: 24.sp,
              ),
              'Contact us on WhatsApp for deposit',
              'Message us on WhatsApp to complete your deposit process.',
              'Open WhatsApp',
              () => _launchUrl(whatsappLink),
            ),
            SizedBox(height: 16.h),
            _buildDepositOption(
              'Binance Pay',
              Icon(Icons.currency_bitcoin, color: AppColor.brandHighlight, size: 24.sp),
              'Pay with Binance Pay',
              'TG8MRqNqWFi1tyqnyRmvV3FFouQhzvFSWa',  // Replace with your actual address
              'Copy Address',
              () {
                Clipboard.setData(ClipboardData(text: 'TG8MRqNqWFi1tyqnyRmvV3FFouQhzvFSWa'))
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Address copied to clipboard'),
                      backgroundColor: AppColor.brandHighlight,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(16.sp),
                    ),
                  );
                });
              },
            ),
            // After the Binance Pay option, add:
            SizedBox(height: 16.h),
           
              // For Telegram
              
              // For WhatsApp
            
            
          ],
        ),
      ),
    );
  }


  Widget _buildDepositOption(
    String title,
    Widget icon,
    String subtitle,
    String details,
    String buttonText,
    VoidCallback onPressed,
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
        leading:icon,
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
                Text(
                  "Tron (TRC20)",
                  style: TextStyle(
                    color: AppColor.white.withOpacity(0.9),
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  details,
                  style: TextStyle(
                    color: AppColor.white.withOpacity(0.9),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onPressed,
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
                        Icon(Icons.open_in_new, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          buttonText,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
