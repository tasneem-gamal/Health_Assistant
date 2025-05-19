import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/presentation/view/widgets/on_boarding/on_boarding_next_button.dart';
import 'package:health_assistant/presentation/view/widgets/on_boarding/on_boarding_page.dart';
import 'package:health_assistant/presentation/view/widgets/on_boarding/on_boarding_skip_button.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.appPadding,
      child: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              OnBoardingPage(
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
              )
            ],
          ),
          const OnBoardingSkipButton(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}




