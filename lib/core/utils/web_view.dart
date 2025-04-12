import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> customelaunchUrl(String url,BuildContext context) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode:LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error launching URL: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }