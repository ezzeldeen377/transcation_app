import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/custom_button.dart';
import 'package:transcation_app/core/utils/custom_text_form_field.dart';
import 'package:transcation_app/features/home/presentation/bloc/withdraw/withdraw_cubit.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final TextEditingController _amountController = TextEditingController();
  // Replace PayPal controller with Western Union controllers
  final TextEditingController _westernUnionNameController =
      TextEditingController();
  final TextEditingController _westernUnionPhoneController =
      TextEditingController();
  final TextEditingController _swiftController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();

  final TextEditingController _cardNumberController = TextEditingController();

  final TextEditingController _paypalEmailController = TextEditingController();
  final TextEditingController _walletAddressController =
      TextEditingController();
  String _selectedPaymentMethod = '';

  @override
  void dispose() {
    _amountController.dispose();
    // Update disposal
    _westernUnionNameController.dispose();
    _westernUnionPhoneController.dispose();
    // Dispose new controllers
    _swiftController.dispose();
    _accountNumberController.dispose();
    _bankNameController.dispose();
    _cardNumberController.dispose();

    _paypalEmailController.dispose();
    _walletAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WithdrawCubit, WithdrawState>(
      listener: (context, state) {
        if (state.isSuccess) {
          // Replace the SnackBar in BlocListener with this AlertDialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppColor.darkGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  side: BorderSide(
                    color: AppColor.brandHighlight,
                    width: 1,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColor.brandHighlight,
                      size: 50.sp,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'تم السحب بنجاح',
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'تم معالجة طلب السحب الخاص بك بنجاح',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.white.withOpacity(0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomButton(
                      onTapButton: () {
                        Navigator.of(context).popAndPushNamed(RouteNames.historyPage);
                      },
                      buttonContent: Text("تم"),
                      animationIndex: 1,
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'سحب',
            style: TextStyle(
              color: AppColor.brandHighlight,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColor.darkGray,
          automaticallyImplyLeading: false,
          actions: [
            Container(
                margin: EdgeInsets.only(right: 20),
                child: BlocBuilder<WithdrawCubit, WithdrawState>(
                  builder: (context, state) {
                    return Row(
                      spacing: 10,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/balance.svg',
                          color: AppColor.brandHighlight,
                        ),
                        Text(
                          '\$${state.balance ?? 0}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    );
                  },
                )),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10),
                _buildWithdrawForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWithdrawForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مبلغ السحب',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.brandHighlight,
          ),
        ),
        SizedBox(height: 16.h),
        CustomTextFormField(
          controller: _amountController,
          hint: 'أدخل المبلغ',
          keyboardType: TextInputType.number,
          prefixIcon: Icon(
            Icons.attach_money,
            color: AppColor.brandHighlight,
          ),
        ),
        SizedBox(height: 24.h),
        _buildPaymentMethod(
          'تحويل بنكي',
          Icons.account_balance,
          'تحويل بنكي مباشر',
        ),
        _buildPaymentMethod(
          'دفع محلي',
          Icons.credit_card,
          'دفع المحافظ الالكترونية',
        ),
        _buildPaymentMethod(
          'ويسترن يونيون',
          Icons.account_balance_wallet,
          'إرسال الأموال في جميع أنحاء العالم',
        ),
        _buildPaymentMethod(
          'عملات رقمية',
          Icons.currency_bitcoin,
          'بيتكوين، إيثريوم، تيثر',
        ),
        SizedBox(height: 32.h),
        CustomButton(
          onTapButton: () {
            // Implement withdraw logic
            _handleWithdraw();
          },
          buttonContent: Text("سحب"),
          animationIndex: 1,
        ),
      ],
    );
  }

  Widget _buildPaymentMethod(String title, IconData icon, String subtitle) {
    bool isSelected = _selectedPaymentMethod == title;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: isSelected ? AppColor.brandHighlight : AppColor.brandSecondary,
          width: isSelected ? 2 : 0.3,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPaymentMethod = isSelected ? '' : title;
              });
            },
            child: Container(
              padding: EdgeInsets.all(16.sp),
              child: Row(
                children: [
                  Icon(icon, color: AppColor.brandHighlight, size: 24.sp),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: AppColor.white.withOpacity(0.7),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isSelected
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColor.brandHighlight,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),
          // Update the form fields in _buildPaymentMethod
          if (isSelected) ...[
            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: AppColor.brandHighlight.withOpacity(0.05),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                ),
              ),
              child: Column(
                children: [
                  // Update the Western Union section in _buildPaymentMethod
                  if (title == 'ويسترن يونيون') ...[
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      controller: _westernUnionNameController,
                      hint: 'الاسم الكامل (كما في الهوية/جواز السفر)',
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      controller: _westernUnionPhoneController,
                      hint: 'رقم الهاتف',
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                  // Update the _getHintText method

                  if (title == 'تحويل بنكي') ...[
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      controller: _accountNumberController,
                      hint: 'رقم الحساب',
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      controller: _bankNameController,
                      hint: 'اسم البنك',
                    ),
                  ] else if (title == 'دفع محلي') ...[
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      controller: _cardNumberController,
                      hint: 'اترك رقم حساب المحفظة الالكترونية',
                    ),
                    SizedBox(height: 12.h),
                  ] else if (title == 'عملات رقمية') ...[
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      controller: _walletAddressController,
                      hint: 'عنوان المحفظة',
                    ),
                  ],
                ],
              ),
            ),
          ],
          // Add this helper method
        ],
      ),
    );
  }

  // Add this method to handle withdraw submission
  void _handleWithdraw() {
    if (_selectedPaymentMethod.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('يرجى اختيار طريقة الدفع'),
          backgroundColor: AppColor.errorColor,
        ),
      );
      return;
    }

    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('يرجى إدخال المبلغ'
),
          backgroundColor: AppColor.errorColor,
        ),
      );
      return;
    }

    Map<String, dynamic> withdrawData = {
      'amount': _amountController.text,
      'token': context.read<AppUserCubit>().state.accessToken,
    };
    switch (_selectedPaymentMethod) {
      case 'Western Union':
        if (_westernUnionNameController.text.isEmpty ||
            _westernUnionPhoneController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('يرجى ملء جميع حقول ويسترن يونيون'),
              backgroundColor: AppColor.errorColor,
            ),
          );
          return;
        }
        withdrawData.addAll({
          'western':
              "${_westernUnionNameController.text} - ${_westernUnionPhoneController.text}",
        });
        break;

      case 'Bank Transfer':
        if (_accountNumberController.text.isEmpty ||
            _bankNameController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('يرجى ملء جميع حقول التحويل البنكي'),
              backgroundColor: AppColor.errorColor,
            ),
          );
          return;
        }
        withdrawData.addAll({
          'bank':
              "${_accountNumberController.text} - ${_bankNameController.text}",
        });
        break;

      case 'Credit Card':
        if (_cardNumberController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('يرجى ملء معلومات الحساب البنكي'),
              backgroundColor: AppColor.errorColor,
            ),
          );
          return;
        }
        withdrawData.addAll({
          'money_office': _cardNumberController.text,
        });
        break;

      case 'Crypto':
        if (_walletAddressController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('يرجى إدخال عنوان المحفظة'),
              backgroundColor: AppColor.errorColor,
            ),
          );
          return;
        }
        withdrawData.addAll({
          'usdt': _walletAddressController.text,
        });
        break;
    }

    // Call the withdraw cubit
    context.read<WithdrawCubit>().withdraw(withdrawData);
  }

  // Update the CustomButton in _buildWithdrawForm
}
