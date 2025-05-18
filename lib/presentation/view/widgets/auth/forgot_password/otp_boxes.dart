import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:pinput/pinput.dart';

class OtpBoxes extends StatelessWidget {
  const OtpBoxes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Pinput(
      separatorBuilder: (index) => horizontalSpace(context, 16),
      length: 4,
      controller: TextEditingController(),
      pinAnimationType: PinAnimationType.fade,
      onCompleted: (value) {},
      defaultPinTheme: PinTheme(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: ColorsManager.moreLightGray))),
                    ),
    );
  }
}