import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';

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
    return Column(
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
    );
  }
}