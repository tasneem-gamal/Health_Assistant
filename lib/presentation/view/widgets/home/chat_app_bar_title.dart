import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';

class ChatAppBarTitle extends StatelessWidget {
  const ChatAppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: const Color.fromARGB(255, 172, 202, 246),
          child: Image.asset('assets/images/ai.png')
        ),
        horizontalSpace(context, 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Health assistant',
              style: CustomTextStyles.font16LightGrayBold(context).copyWith(color: Colors.black),
            ),
            verticalSpace(context, 5),
            Row(
              children: [
                const CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.green,
                ),
                horizontalSpace(context, 8),
                Text(
                  'Always Active',
                  style: CustomTextStyles.font12BlackMedium(context),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}