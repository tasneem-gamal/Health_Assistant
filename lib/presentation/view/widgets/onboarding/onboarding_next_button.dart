import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.01),
        child: const CircleAvatar(
          backgroundColor: ColorsManager.mainColor,
          radius: 35,
          child: Icon(
            Icons.arrow_forward_ios,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
