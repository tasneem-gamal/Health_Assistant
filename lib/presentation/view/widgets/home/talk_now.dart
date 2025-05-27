import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/presentation/view/screens/home/talk_now_chat.dart';


class TalkNow extends StatelessWidget {
  const TalkNow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
            border: Border.all(color: ColorsManager.mainColor),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mental Health Support',
                    style: CustomTextStyles.font14WhiteBold(context)
                        .copyWith(color: Colors.black),
                  ),
                  Image.asset('assets/images/agent.png')
                ],
              )),
              Text(
                'emotional support & counseling ',
                style: CustomTextStyles.font14WhiteBold(context)
                    .copyWith(color: Colors.black),
              ),
              verticalSpace(context, 8),
              Text(
                'real-time mood analysis',
                style: CustomTextStyles.font14WhiteBold(context)
                    .copyWith(color: Colors.black),
              ),
              verticalSpace(context, 8),
              Text(
                'personalized coping strategies',
                style: CustomTextStyles.font14WhiteBold(context)
                    .copyWith(color: Colors.black),
              ),
              verticalSpace(context, 8),
              Text(
                'crisis resources & support',
                style: CustomTextStyles.font14WhiteBold(context)
                    .copyWith(color: Colors.black),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomAppButton(
                    onPressed: () {
                      context.push(const TalkNowChat());
                    }, buttonWidth: 180, btnText: 'Talk Now'),
              )
            ],
          ),
        ),
      ),
    );
  }
}