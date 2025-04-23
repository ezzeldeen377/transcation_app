import 'package:flutter/material.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/text_styles.dart';
import 'dart:io';

showSnackBar(BuildContext context, String content) {
  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: AppColor.errorColor,
        content: Text(
          content,
          style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
            color: AppColor.white,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
}

showCustomDialog(
    BuildContext context, String content,String title, void Function() onPressed) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.brandDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          title,
          style: TextStyles.fontCircularSpotify16WhiteMedium,
        ),
        content: Text(
          content,
          style: TextStyles.fontCircularSpotify14WhiteMedium,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColor.brandPrimary,
            ),
            child: Text(
              "حسنا",
              style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
                color: AppColor.brandHighlight,
              ),
            ),
          ),
        ],
      );
    },
  );
}


Future<bool> onWillPop(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColor.darkGray,
            title: Text(
              'الخروج من التطبيق',
              style: TextStyles.fontCircularSpotify16BlackMedium.copyWith(
                color: AppColor.brandPrimary,
              ),
            ),
            content: Text(
              'هل أنت متأكد أنك تريد الخروج؟',
              style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
                color: AppColor.white,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'لا',
                  style: TextStyles.fontCircularSpotify14BlackMedium.copyWith(
                    color: AppColor.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => exit(0), // Exit the app completely
                child: Text(
                  'نعم',
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