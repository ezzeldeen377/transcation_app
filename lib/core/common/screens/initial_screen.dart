import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_state.dart';
import 'package:transcation_app/core/helpers/navigator.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/home/presentation/pages/deposit_page.dart';
import 'package:transcation_app/features/home/presentation/pages/home_page.dart';
import 'package:transcation_app/features/home/presentation/pages/plans_page.dart';
import 'package:transcation_app/features/home/presentation/pages/withdraw_page.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    const HomePage(),
    const DepositPage(),
    const WithdrawPage(),
    const PlansPage(),
  ];
  
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
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: AppColor.darkGray,
        //   title: Text(
        //     'Home',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   actions: [
        //     IconButton(
        //       icon: Icon(Icons.logout, color: Colors.white),
        //       onPressed: () => context
        //           .read<AppUserCubit>()
        //           .onLogout(context.read<AppUserCubit>().state.accessToken!),
        //     ),
        //   ],
        // ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
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
          ],
        ),
      ),
    );
  }
}
