import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';

class OnboardingGetStartedView extends StatelessWidget {
  const OnboardingGetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/images/get_started.png')),
            verticalSpace(context, 40),
            Text(
              'Let’s Begin!',
              style: CustomTextStyles.font32BlackBold(context),
            ),
            verticalSpace(context, 12),
            Text(
              'Get started on your journey to  better health and wellness.',
              textAlign: TextAlign.center,
              style: CustomTextStyles.font16LightGreyRegular(context),
            ),
            verticalSpace(context, 24),
            CustomAppButton(
              btnText: 'Started',
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}