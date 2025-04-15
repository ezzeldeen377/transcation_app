import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/bloc_observer.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_state.dart';
import 'package:transcation_app/core/di/di.dart';
import 'package:transcation_app/core/routes/router_genrator.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/app_theme.dart';
import 'package:transcation_app/core/utils/show_snack_bar.dart';
import 'package:transcation_app/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  Bloc.observer = SimpleBlocObserver();
  timeago.setLocaleMessages('ar', timeago.ArMessages());

  runApp(BlocProvider(
    create: (context) => getIt<AppUserCubit>()..checkLogin(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<AppUserCubit, AppUserState>(
          builder: (context, state) {
            if (state.state == AppUserStates.loading ||
                state.state == AppUserStates.initial) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColor.brandHighlight,
              ));
            }

            return MaterialApp(
              title: 'Ethraa',
              theme: AppTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              locale: const Locale('ar'), // Force Arabic
              supportedLocales: const [Locale('ar')], // Only Arabic supported
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              initialRoute:
                  state.isLoggedIn ? RouteNames.initial : RouteNames.signIn,
              onGenerateRoute: TranscationRouter.generateRoute,
            );
          },
        );
      },
    );
  }
}
