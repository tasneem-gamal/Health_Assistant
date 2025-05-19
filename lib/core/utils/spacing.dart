import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

SizedBox verticalSpace(BuildContext context, double defaultHeight) {
  final height = ResponsiveValue<double>(
    context,
    defaultValue: defaultHeight,
    conditionalValues: [
      Condition.smallerThan(name: MOBILE, value: defaultHeight * 0.5),
      Condition.largerThan(name: TABLET, value: defaultHeight * 1.5),
    ],
  ).value;

  return SizedBox(height: height);
}

SizedBox horizontalSpace(BuildContext context, double defaultWidth) {
  final width = ResponsiveValue<double>(
    context,
    defaultValue: defaultWidth,
    conditionalValues: [
      Condition.smallerThan(name: MOBILE, value: defaultWidth * 0.5),
      Condition.largerThan(name: TABLET, value: defaultWidth * 1.5),
    ],
  ).value;

  return SizedBox(width: width);
}
