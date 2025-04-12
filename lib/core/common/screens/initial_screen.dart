import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_state.dart';
import 'package:transcation_app/core/di/di.dart';
import 'package:transcation_app/core/helpers/navigator.dart';
import 'package:transcation_app/core/helpers/secure_storage_helper.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/text_styles.dart';
import 'package:transcation_app/features/home/presentation/bloc/deposit/deposit_cubit.dart';
import 'package:transcation_app/features/home/presentation/bloc/home/home_cubit_cubit.dart';
import 'package:transcation_app/features/home/presentation/bloc/my_plans/my_plans_cubit.dart';
import 'package:transcation_app/features/home/presentation/bloc/offer/offer_cubit.dart';
import 'package:transcation_app/features/home/presentation/bloc/withdraw/withdraw_cubit.dart';
import 'package:transcation_app/features/home/presentation/pages/deposit_page.dart';
import 'package:transcation_app/features/home/presentation/pages/home_page.dart';
import 'package:transcation_app/features/home/presentation/pages/plans_page.dart';
import 'package:transcation_app/features/home/presentation/pages/withdraw_page.dart';
import 'package:transcation_app/features/home/presentation/pages/offer_page.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = _buildScreens();
  }

  List<Widget> _buildScreens() {
    return [
      BlocProvider(
        create: (context) => getIt<HomeCubit>()
          ..getUserProfile(
              token: context.read<AppUserCubit>().state.accessToken!)
          ..getAllPlans()
          ..getUserActivePlan(context.read<AppUserCubit>().state.accessToken!)
          ..checkPlans(context.read<AppUserCubit>().state.accessToken!)
          ..getTransactionHistory(
              context.read<AppUserCubit>().state.accessToken!),
        child: HomePage(
          controller: _pageController,
        ),
      ),
      BlocProvider(
        create: (context) => getIt<DepositCubit>()
          ..getBalance(token: context.read<AppUserCubit>().state.accessToken!),
        child: const DepositPage(),
      ),
      BlocProvider(
        create: (context) => getIt<WithdrawCubit>()
          ..getBalance(token: context.read<AppUserCubit>().state.accessToken!),
        child: const WithdrawPage(),
      ),
      BlocProvider(
        create: (context) => getIt<MyPlansCubit>()
          ..getUserActivePlan(context.read<AppUserCubit>().state.accessToken!),
        child: const PlansPage(),
      ),
      BlocProvider(
        create: (context) => getIt<OfferCubit>()
          ..getOffers()
          ..getUserActivePlan(context.read<AppUserCubit>().state.accessToken!),
        child: const OfferPage(),
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Add this method to show the exit dialog
  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColor.darkGray,
            title: Text(
              'Exit App',
              style: TextStyles.fontCircularSpotify16BlackMedium.copyWith(
                color: AppColor.brandPrimary,
              ),
            ),
            content: Text(
              'Are you sure you want to exit?',
              style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
                color: AppColor.white,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
                    color: AppColor.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'Yes',
                  style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
                    color: AppColor.brandHighlight,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppUserCubit, AppUserState>(
      listener: (context, state) {
        if (state.isClearUserData) {
          context.pushNamedAndRemoveAll(RouteNames.signIn);
        }
        if (state.isSignOut) {
          context.read<AppUserCubit>().clearUserData();
        }
      },
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.darkGray,
            selectedItemColor: AppColor.brandHighlight,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_downward),
                label: 'Deposit',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_upward),
                label: 'Withdraw',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart),
                label: 'Plans',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_offer),
                label: 'Offers',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
