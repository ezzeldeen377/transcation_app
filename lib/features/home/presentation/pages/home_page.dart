import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:flutter/services.dart';
import 'package:transcation_app/core/theme/text_styles.dart';
import 'package:transcation_app/core/utils/custom_container.dart';
import 'package:transcation_app/features/home/presentation/pages/notification_page.dart';
import 'package:transcation_app/features/home/presentation/screens/menu_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:transcation_app/features/home/presentation/widgets/profit_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String userId = "123456";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.darkGray,
          elevation: 4,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: AppColor.darkGray,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: userId));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('User ID copied to clipboard')),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColor.brandDark,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "ID: $userId",
                            style: TextStyles.fontCircularSpotify12GreyRegular,
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.copy, color: AppColor.brandHighlight),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications, color: AppColor.brandHighlight),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationPage(),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.menu, color: AppColor.brandHighlight),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfitCard(),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  side: BorderSide(color: AppColor.brandDark, width: 0.3),
                ),
                leading: SvgPicture.asset(
                  'assets/icons/balance.svg',
                  color: AppColor.brandHighlight,
                ),
                title: Text(
                  'Total Balance',
                  style: TextStyle(
                    color: AppColor.brandHighlight,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '\$10,250.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.add, color: AppColor.brandHighlight),
                  onPressed: () {},
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CarouselSlider(
              options: CarouselOptions(
                height: 240 .h,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.7,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              ),
              items: [
                _buildInvestmentCard(
                  'Conservative Plan',
                  'Low risk investment strategy',
                  '5-8%',
                  '\$1,000',
                  ['Capital preservation', 'Steady returns', 'Lower volatility'],
                  AppColor.brandPrimary,
                ),
                _buildInvestmentCard(
                  'Balanced Plan',
                  'Moderate risk investment strategy',
                  '8-12%',
                  '\$2,500',
                  ['Diversified portfolio', 'Growth potential', 'Regular income'],
                  AppColor.brandHighlight,
                ),
                _buildInvestmentCard(
                  'Aggressive Plan',
                  'High risk investment strategy',
                  '12-18%',
                  '\$5,000',
                  ['Maximum growth', 'Active management', 'High returns'],
                  AppColor.brandAccent,
                ),
              ],
            ),
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
                    () {},
                  ),
                  _buildActionButton(
                    'Withdraw',
                    Icons.arrow_upward,
                    AppColor.brandHighlight,
                    () {},
                  ),
                  _buildActionButton(
                    'History',
                    Icons.history,
                    AppColor.brandAccent,
                    () {},
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
                  _buildTransactionItem(
                    'Deposit',
                    '+\$500.00',
                    'Success',
                    Icons.arrow_downward,
                    AppColor.brandPrimary,
                  ),
                  _buildTransactionItem(
                    'Withdraw',
                    '-\$200.00',
                    'Pending',
                    Icons.arrow_upward,
                    AppColor.brandHighlight,
                  ),
                  _buildTransactionItem(
                    'Investment',
                    '-\$1000.00',
                    'Success',
                    Icons.account_balance,
                    AppColor.brandAccent,
                  ),
                ],
              ),
            ),
          ],
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
            color: amount.startsWith('+') ? AppColor.brandPrimary : Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInvestmentCard(
    String title,
    String description,
    String returns,
    String minInvestment,
    List<String> benefits,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.8),
            color.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expected Returns',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    returns,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Min Investment',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    minInvestment,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ...benefits.map((benefit) => Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      benefit,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
