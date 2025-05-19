import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';

class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: TextButton(
        onPressed: (){}, 
        child: Text(
          'Skip',
          style: CustomTextStyles.font14MainColorRegular(context),
        )
      ),
    );
  }
}