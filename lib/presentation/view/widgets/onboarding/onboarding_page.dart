import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    this.subTitle,
    this.description,
    this.subTitleStyle,
    this.dash,
  });

  final String image, title;
  final String? description;
  final String? subTitle;
  final TextStyle? subTitleStyle;
  final List<String>? dash;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset(image)),
        verticalSpace(context, 50),
        RichText(
            text: TextSpan(
                text: title,
                style: CustomTextStyles.font32BlackBold(context),
                children: [
              TextSpan(
                  text: subTitle,
                  style: subTitleStyle ??
                      CustomTextStyles.font32BlackBold(context))
            ])),
        verticalSpace(context, 16),
        if (description != null)
          Text(
            description!,
            softWrap: true,
            style: CustomTextStyles.font16LightGreyRegular(context),
          )
        else if (dash != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: dash!.map((text) {
              final parts = text.split(':');
              final title = parts.first.trim();
              final body = parts.length > 1 ? parts[1].trim() : '';
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '- $title ',
                        style: CustomTextStyles.font16LightgreyBold(context),
                      ),
                      TextSpan(
                        text: body,
                        style: CustomTextStyles.font16LightGreyRegular(context),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )
      ],
    );
  }
}
