import 'package:flutter/material.dart';
import 'package:health_assistant/presentation/view/screens/onboarding/onboarding_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HealthAssistant extends StatelessWidget {
  const HealthAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: child!
      ),
      theme: ThemeData(
        fontFamily: 'Montserrat'
      ),
      themeMode: ThemeMode.light,
      home: const OnboardingView(),
    );
  }
}