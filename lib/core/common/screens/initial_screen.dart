import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_state.dart';
import 'package:transcation_app/core/di/di.dart';
import 'package:transcation_app/core/helpers/navigator.dart';
import 'package:transcation_app/core/helpers/notification_helper.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/show_snack_bar.dart';
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
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => InitialScreenState();
}

class InitialScreenState extends State<InitialScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  late final List<Widget> _screens;
static final GlobalKey<InitialScreenState> globalKey = GlobalKey<InitialScreenState>();
  @override
  void initState() {
    super.initState();
    _screens = _buildScreens();
    
    // Set up notification navigation
    NotificationHelper.navigateToIndex = (int index) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    };
  }
void navigateToDeposit() {
    _pageController.animateToPage(
      1, // Index of deposit page
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
        onWillPop:()=> onWillPop(context),
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
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_downward),
                label: 'إيداع',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_upward),
                label: 'سحب',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart),
                label: 'الخطط',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_offer),
                label: 'العروض',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
