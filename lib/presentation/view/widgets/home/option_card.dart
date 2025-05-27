import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';

class OptionCard extends StatelessWidget {
  final String image;
  final String title;
  final double? width;
  final VoidCallback onTap;
  final bool isSelected;

  const OptionCard({
    required this.image,
    required this.title,
    required this.onTap,
    super.key, this.width,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 140,
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 200, 216, 239) : ColorsManager.grayShade,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
            ),
            verticalSpace(context, 8),
            Text(
              title, 
              style: CustomTextStyles.font12BlackMedium(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}