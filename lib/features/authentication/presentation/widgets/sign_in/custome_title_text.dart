
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:transcation_app/core/theme/text_styles.dart';

class CustomeTitleText extends StatelessWidget {
  final String title;
  final String animatedText;
  final EdgeInsetsGeometry padding;


  const CustomeTitleText({
    super.key,
    required this.title,
    required this.animatedText,
    this.padding = const EdgeInsets.all(35),

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyles.fontCircularSpotify20WhiteSemiBold,
          ),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                animatedText,
                textStyle: TextStyles.fontCircularSpotify14WhiteMedium,
                speed: const Duration(milliseconds: 100),
              ),
            ],
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ],
      ),
    );
  }
}
