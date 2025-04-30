import 'package:country_picker/country_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/bloc_observer.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/core/common/cubit/app_user/app_user_state.dart';
import 'package:transcation_app/core/di/di.dart';
import 'package:transcation_app/core/helpers/notification_helper.dart';
import 'package:transcation_app/core/routes/router_genrator.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/app_theme.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:transcation_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    print('Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    configureDependencies();
    Bloc.observer = SimpleBlocObserver();
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    
    print('start');
    
    // Add await here and error handling
    await NotificationHelper.init();
    
    print('Notifications initialized');

    runApp(BlocProvider(
      create: (context) => getIt<AppUserCubit>()..checkLogin(),
      child: const MyApp(),
    ));
  } catch (e) {
    print('Error during initialization: $e');
    // You might want to handle the error appropriately or rethrow
    rethrow;
  }
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
                        CountryLocalizations.delegate,

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
