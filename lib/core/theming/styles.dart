import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/font_weight_helper.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomTextStyles {
  static TextStyle font32BlackBold(BuildContext context) => TextStyle(
        fontSize: ResponsiveValue<double>(
          context,
          defaultValue: 32.0,
          conditionalValues: [
            const Condition.smallerThan(name: MOBILE, value: 24.0),
            const Condition.largerThan(name: TABLET, value: 36.0),
          ],
        ).value,
        fontWeight: FontWeightHelper.bold,
        color: Colors.black,
      );

  static TextStyle font16LightGreyRegular(BuildContext context) => TextStyle(
        fontSize: ResponsiveValue<double>(
          context,
          defaultValue: 16.0,
          conditionalValues: [
            const Condition.smallerThan(name: MOBILE, value: 14.0),
            const Condition.largerThan(name: TABLET, value: 18.0),
          ],
        ).value,
        fontWeight: FontWeightHelper.regular,
        color: ColorsManager.lightGray
      );
}
