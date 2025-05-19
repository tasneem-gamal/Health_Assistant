import 'package:flutter/material.dart';
import 'package:health_assistant/presentation/view/widgets/onboarding/onboarding_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: OnboardingViewBody()),
    );
  }
}