import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/presentation/controllers/onboarding/onboarding_controller.dart';
import 'package:health_assistant/presentation/view/widgets/onboarding/onboarding_next_button.dart';
import 'package:health_assistant/presentation/view/widgets/onboarding/onboarding_page.dart';
import 'package:health_assistant/presentation/view/widgets/onboarding/onboarding_skip_button.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Padding(
      padding: Constants.appPadding,
      child: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              OnboardingPage(
                image: 'assets/images/boarding_1.png',
                title: 'Welcome to ',
                subTitle: 'Health Assistant',
                description: 'Your personal health companion for a healthier body and mind.',
                subTitleStyle: CustomTextStyles.font32BlackBold(context).copyWith(
                      foreground: Paint()
                        ..shader = const LinearGradient(
                            colors: <Color>[ColorsManager.mainColor, ColorsManager.mainColorLight],
                          ).createShader(const Rect.fromLTWH(200.0, 0.0, 50.0, 0.0)),
                    ),
              ),
              const OnboardingPage(
                image: 'assets/images/boarding_2.png',
                title: 'Empower Your Health',
                dash: [
                  'Analyze: Your Symptoms To Gain Health Insights.',
                  'Upload: Lab Results For Early Disease Detection.',
                  'Receive: Personalized Fitness And Nutrition Plans.',
                ],
              ),
              const OnboardingPage(
                image: 'assets/images/boarding_3.png',
                title: 'Prioritize Your Mental Wellness',
                dash: [
                  'Chat: with a virtual mental health coach.',
                  'Track: your mood and receive therapeutic advice',
                  'Learn: stress-management techniques tailored to you.',
                ],
              ),
              const OnboardingPage(
                image: 'assets/images/boarding_4.png',
                title: 'Your Data, Your Control',
                dash: [
                  ': Your health data is secure and private.',
                  ': Personalized recommendations tailored just for you.',
                ],
              )
            ],
          ),
          const OnboardingSkipButton(),
          const OnboardingNextButton()
        ],
      ),
    );
  }
}




