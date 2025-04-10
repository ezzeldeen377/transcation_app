import 'package:flutter/material.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/theme/text_styles.dart';

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
              "OK",
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
