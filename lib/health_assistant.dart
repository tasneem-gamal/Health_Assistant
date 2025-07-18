import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/presentation/controllers/auth/auth_cubit.dart';
import 'package:health_assistant/presentation/view/screens/home/home_view.dart';
import 'package:health_assistant/presentation/view/screens/onboarding/onboarding_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HealthAssistant extends StatelessWidget {
  const HealthAssistant({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) =>
            ResponsiveBreakpoints.builder(breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ], child: child!),
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white, fontFamily: 'Montserrat'),
        themeMode: ThemeMode.light,
        home: isLoggedIn ? const HomeView() : const OnboardingView(),
      ),
    );
  }
}
