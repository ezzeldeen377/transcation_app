
import 'package:flutter/material.dart';
import '../../core/theme/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? buttonText;
  
  const CustomAppBar({super.key, required this.title, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: Text('Edit Doctor',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColor.white)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.brandAccent,
                  AppColor.brandAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 4,
          actions: [
           if (buttonText != null) IconButton(
              icon: Text(
                buttonText!,
                style: const TextStyle(
                  color: AppColor.brandDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            ),
          ],
        );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}