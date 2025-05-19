import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/spacing.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        )
      ],
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, 
    required this.image,
    required this.title, 
    required this.subTitle, 
    required this.description, 
    this.subTitleStyle,
  });

  final String image, title, subTitle, description;
  final TextStyle? subTitleStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.appPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          verticalSpace(context, 50),
          RichText(
            text: TextSpan(
              text: title,
              style: CustomTextStyles.font32BlackBold(context),
              children: [
                TextSpan(
                  text: subTitle,
                  style: subTitleStyle ?? CustomTextStyles.font32BlackBold(context)
                )
              ]
            )
          ),
          verticalSpace(context, 16),
          Text(
            description,
            softWrap: true,
            style: CustomTextStyles.font16LightGreyRegular(context),
          )
        ],
      ),
    );
  }
}