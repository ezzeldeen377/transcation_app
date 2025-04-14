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
import 'package:transcation_app/core/utils/web_view.dart';
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

  final String binancePayId = 'your_binance_pay_id';
  final String whatsappLink = "https://wa.me/message/66NFNOEP3S3LC1";
  final String telegramLink = "https://telegram.me/Ethraawalet";

  

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
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
            _buildDepositOption(
              'تيليجرام',
              SvgPicture.asset(
                'assets/icons/telegram.svg',
                color: AppColor.brandHighlight,
                width: 24.sp,
                height: 24.sp,
              ),
              'تواصل معنا على تيليجرام للإيداع',
              'تحدث مع فريق الدعم على تيليجرام لمعالجة إيداعك',
              'فتح تيليجرام',
              () => customelaunchUrl(telegramLink,context),
            ),
            SizedBox(height: 16.h),
            _buildDepositOption(
              'واتساب',
              SvgPicture.asset(
                'assets/icons/whatsapp.svg',
                color: AppColor.brandHighlight,
                width: 24.sp,
                height: 24.sp,
              ),
              'تواصل معنا على واتساب للإيداع',
              'راسلنا على واتساب لإتمام عملية الإيداع',
              'فتح واتساب',
              () => customelaunchUrl(whatsappLink,context),
            ),
            SizedBox(height: 16.h),
            _buildDepositOption3(
              'بينانس باي',
              Icon(Icons.currency_bitcoin,
                  color: AppColor.brandHighlight, size: 24.sp),
              'الدفع عبر بينانس باي',
              '''Tron (TRC20) 
TG8MRqNqWFi1tyqnyRmvV3FFouQhzvFSWa''', // Replace with your actual address
         
            ),
            // After the Binance Pay option, add:
            SizedBox(height: 16.h),
                _buildDepositOption2("بنك تركيا ", Icon(Icons.account_balance,
                  color: AppColor.brandHighlight, size: 24.sp),"ايداع عن طريق بنك تركيا",""),


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
   Widget _buildDepositOption2(
    String title,
    Widget icon,
    String subtitle,
    String details,
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
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'IBRAHIM EL DERVIŞ',
                    style: TextStyle(
                      color: AppColor.white.withOpacity(0.9),
                      fontSize: 14.sp,
                    ),
                  ),
            
                  trailing: IconButton(
                    icon: Icon(Icons.copy, color: AppColor.brandHighlight),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: 'IBRAHIM EL DERVIŞ',
                      )).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم نسخ العنوان إلى الحافظة'),
                            backgroundColor: AppColor.brandHighlight,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(16.sp),
                          ),
                        );
                      });
                    },
                  ),
                ),
                                SizedBox(height: 8.h),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'TR44 0082 9000 0949 2078 6745 37',
                    style: TextStyle(
                      color: AppColor.white.withOpacity(0.9),
                      fontSize: 14.sp,
                    ),
                  ),
            
                  trailing: IconButton(
                    icon: Icon(Icons.copy, color: AppColor.brandHighlight),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: 'TR44 0082 9000 0949 2078 6745 37',
                      )).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم نسخ العنوان إلى الحافظة'),
                            backgroundColor: AppColor.brandHighlight,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(16.sp),
                          ),
                        );
                      });
                    },
                  ),
                ),
              
              ],
            ),
          ),
        ],
      ),
    );
  }
   Widget _buildDepositOption3(
    String title,
    Widget icon,
    String subtitle,
    String details,
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
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Tron (TRC20)',
                    style: TextStyle(
                      color: AppColor.white.withOpacity(0.9),
                      fontSize: 14.sp,
                    ),
                  ),
            
                  trailing: IconButton(
                    icon: Icon(Icons.copy, color: AppColor.brandHighlight),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: 'TRC20',
                      )).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم نسخ العنوان إلى الحافظة'),
                            backgroundColor: AppColor.brandHighlight,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(16.sp),
                          ),
                        );
                      });
                    },
                  ),
                ),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'TG8MRqNqWFi1tyqnyRmvV3FFouQhzvFSWa',
                    style: TextStyle(
                      color: AppColor.white.withOpacity(0.9),
                      fontSize: 14.sp,
                    ),
                  ),
            
                  trailing: IconButton(
                    icon: Icon(Icons.copy, color: AppColor.brandHighlight),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: 'TG8MRqNqWFi1tyqnyRmvV3FFouQhzvFSWa',
                      )).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم نسخ العنوان إلى الحافظة'),
                            backgroundColor: AppColor.brandHighlight,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(16.sp),
                          ),
                        );
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'ID BINANCE : 836483841',
                    style: TextStyle(
                      color: AppColor.white.withOpacity(0.9),
                      fontSize: 14.sp,
                    ),
                  ),
            
                  trailing: IconButton(
                    icon: Icon(Icons.copy, color: AppColor.brandHighlight),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: '836483841',
                      )).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم نسخ العنوان إلى الحافظة'),
                            backgroundColor: AppColor.brandHighlight,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(16.sp),
                          ),
                        );
                      });
                    },
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
