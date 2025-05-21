
import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorsManager.mainColor,
      ),
    );
  }
}