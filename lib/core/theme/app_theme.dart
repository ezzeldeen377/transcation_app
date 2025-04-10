
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/font_weight_helper.dart';
import 'package:transcation_app/core/theme/text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColor.brandHighlight,
      scaffoldBackgroundColor: AppColor.darkGray,
      applyElevationOverlayColor: true,
      
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColor.white,
        scrimColor: AppColor.brandSecondary,
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColor.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      dialogBackgroundColor: AppColor.white,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColor.white),
      iconTheme: const IconThemeData(color: AppColor.white),
      snackBarTheme:  SnackBarThemeData(
          backgroundColor: AppColor.brandHighlight,
          contentTextStyle: TextStyles.fontCircularSpotify14BlackMedium.copyWith(color: AppColor.white) ),
      inputDecorationTheme: InputDecorationTheme(
        errorMaxLines: 2,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        hintStyle: TextStyles.fontCircularSpotify14WhiteMedium
            .copyWith(fontWeight: FontWeightHelper.regular),
        labelStyle: TextStyles.fontCircularSpotify14BlackMedium,
        filled: true,
        fillColor: AppColor.brandDark,
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.errorColor.withOpacity(.5),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.errorColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.brandAccent.withOpacity(.5),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.brandAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.brandAccent.withOpacity(.8),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 57,
              fontWeight: FontWeight.normal,
              color: Colors.white),
          displayMedium: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 45,
              fontWeight: FontWeight.normal,
              color: Colors.white),
          displaySmall: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 36,
              fontWeight: FontWeight.normal,
              color: Colors.white),
          headlineLarge: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white),
          headlineMedium: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white),
          headlineSmall: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white),
          titleLarge: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          titleMedium: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          titleSmall: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          bodyLarge: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.white),
          bodyMedium: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white),
          bodySmall: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.white),
          labelLarge: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white),
          labelMedium: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white),
          labelSmall: TextStyle(
              fontFamily: "CircularSpotify",
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white)),
    );
  }
}
//   static ThemeData get darkTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
//       primaryColor: AppColor.darkTeal,
//       colorScheme: const ColorScheme.dark(
//         primary: AppColor.darkTeal,
//         onPrimary: AppColor.offWhite,
//         primaryContainer: AppColor.teal,
//         secondary: AppColor.mintGreen,
//         onSecondary: AppColor.darkGray,
//         secondaryContainer: AppColor.tealNew,
//         surface: AppColor.darkGray,
//         onSurface: AppColor.offWhite,
//         background: AppColor.textFieldFill,
//         onBackground: AppColor.offWhite
//       ),
//       scaffoldBackgroundColor: AppColor.darkGray,
//       applyElevationOverlayColor: true,
//       drawerTheme: DrawerThemeData(
//         backgroundColor: AppColor.darkGray,
//         scrimColor: AppColor.blackColor.withOpacity(0.5),
//         elevation: 16,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       dialogTheme: DialogTheme(
//         backgroundColor: AppColor.darkGray,
//         elevation: 8,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       dialogBackgroundColor: AppColor.darkGray,
//       progressIndicatorTheme:
//           const ProgressIndicatorThemeData(color: AppColor.white),
//       snackBarTheme:  SnackBarThemeData(
//           backgroundColor: AppColor.tealNew,
//           contentTextStyle: TextStyles.fontCircularSpotify14BlackMedium.copyWith(color: AppColor.whiteColor) ),
//       iconTheme: const IconThemeData(color: AppColor.white),
//       inputDecorationTheme: InputDecorationTheme(
//         isDense: true,
//         errorMaxLines: 2,
//         contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
//         hintStyle: TextStyles.fontCircularSpotify14WhiteMedium
//             .copyWith(fontWeight: FontWeightHelper.regular),
//         labelStyle: TextStyles.fontCircularSpotify14WhiteMedium,
//         filled: true,
//         fillColor: AppColor.textFieldFill,
//         errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: AppColor.errorColor.withOpacity(.5),
//               width: 2,
//             ),
//             borderRadius: BorderRadius.circular(15)),
//         focusedErrorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: AppColor.errorColor,
//               width: 2,
//             ),
//             borderRadius: BorderRadius.circular(15)),
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: AppColor.textFieldBorder.withOpacity(.8),
//               width: 2,
//             ),
//             borderRadius: BorderRadius.circular(15)),
//         disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: AppColor.grayColor.withOpacity(.2),
//               width: 2,
//             ),
//             borderRadius: BorderRadius.circular(15)),
//         focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: AppColor.textFieldBorder,
//               width: 2,
//             ),
//             borderRadius: BorderRadius.circular(15)),
//       ),
//       textTheme: const TextTheme(
//           displayLarge: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 57,
//               fontWeight: FontWeight.normal,
//               color: AppColor.ofWhiteColor),
//           displayMedium: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 45,
//               fontWeight: FontWeight.normal,
//               color: AppColor.ofWhiteColor),
//           displaySmall: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 36,
//               fontWeight: FontWeight.normal,
//               color: AppColor.ofWhiteColor),
//           headlineLarge: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//               color: AppColor.ofWhiteColor),
//           headlineMedium: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: AppColor.ofWhiteColor),
//           headlineSmall: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: AppColor.ofWhiteColor),
//           titleLarge: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 22,
//               fontWeight: FontWeight.w600,
//               color: AppColor.ofWhiteColor),
//           titleMedium: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: AppColor.ofWhiteColor),
//           titleSmall: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: AppColor.ofWhiteColor),
//           bodyLarge: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 16,
//               fontWeight: FontWeight.normal,
//               color: AppColor.ofWhiteColor),
//           bodyMedium: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 14,
//               fontWeight: FontWeight.normal,
//               color: AppColor.ofWhiteColor),
//           bodySmall: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 12,
//               fontWeight: FontWeight.normal,
//               color: AppColor.ofWhiteColor),
//           labelLarge: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: AppColor.ofWhiteColor),
//           labelMedium: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: AppColor.ofWhiteColor),
//           labelSmall: TextStyle(
//               fontFamily: "CircularSpotify",
//               fontSize: 11,
//               fontWeight: FontWeight.w500,
//               color: AppColor.ofWhiteColor)),
//     );
//   }
// }
