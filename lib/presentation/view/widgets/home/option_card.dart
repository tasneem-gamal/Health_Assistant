import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';

class OptionCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const OptionCard({
    required this.image,
    required this.title,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: ColorsManager.grayShade,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
            ),
            const SizedBox(height: 8),
            Text(
              title, 
              style: const TextStyle(fontWeight: FontWeight.bold, color: ColorsManager.lightGray),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}