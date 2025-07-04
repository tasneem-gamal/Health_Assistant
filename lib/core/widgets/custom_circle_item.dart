import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';

class CustomCircleItem extends StatelessWidget {
  const CustomCircleItem({
    super.key, required this.icon, this.onTap,
  });

  final Widget icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorsManager.moreLightGray)
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: icon,
          ),
        ),
      ),
    );
  }
}