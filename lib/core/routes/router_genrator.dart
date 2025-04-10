
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcation_app/core/common/screens/initial_screen.dart';
import 'package:transcation_app/core/di/di.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:transcation_app/features/authentication/presentation/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:transcation_app/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:transcation_app/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:transcation_app/features/authentication/presentation/screens/verification_screen.dart';
import 'package:transcation_app/features/authentication/presentation/cubits/verification_cubit/verification_cubit.dart';

class TranscationRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      // Auth routes
  
      case RouteNames.signIn:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
            create: (context) => getIt<SignInCubit>(),
            child: const SignInScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
        );
      case RouteNames.signUp:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      case RouteNames.verification:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>BlocProvider(
            create: (context) => getIt<VerificationCubit>()..setEmail(settings.arguments as String),
          child: const VerificationScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
        );
        // home screen routes
              case RouteNames.initial:
        return MaterialPageRoute(builder: (context) => const InitialScreen());

      
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Route "${settings.name ?? ''}" not found'),
          ),
         ) );
    }
  }
}
