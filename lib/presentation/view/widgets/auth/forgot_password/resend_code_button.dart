import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Didn’t get your code?',
          style: CustomTextStyles.font16LightGrayBold(context),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'Resend',
              style: CustomTextStyles.font14MainColorRegular(context),
            ))
      ],
    );
  }
}
