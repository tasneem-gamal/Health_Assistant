import 'package:flutter/material.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';

class StartHealthCheck extends StatelessWidget {
  const StartHealthCheck({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: ColorsManager.mainColor),
          borderRadius: BorderRadius.circular(20)
        ),
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
                      'Your Physical Health Partner',
                      style: CustomTextStyles.font14WhiteBold(context).copyWith(color: Colors.black),
                    ),
                    Image.asset(
                      'assets/images/doctor.png'
                    )
                  ],
                )
              ),
              Text(
                'Analyze symptoms :',
                style: CustomTextStyles.font14WhiteBold(context).copyWith(color: Colors.black),
              ),
              Text(
                'symptoms checker',
                style: CustomTextStyles.font14WhiteBold(context).copyWith(color: ColorsManager.lightGray),
              ),
              verticalSpace(context, 8),
              Text(
                'fitness plan :',
                style: CustomTextStyles.font14WhiteBold(context).copyWith(color: Colors.black),
              ),
              Text(
                'Personalized workout',
                style: CustomTextStyles.font14WhiteBold(context).copyWith(color: ColorsManager.lightGray),
              ),
              verticalSpace(context, 8),
              Text(
                'Nutrition plan :',
                style: CustomTextStyles.font14WhiteBold(context).copyWith(color: Colors.black),
              ),
              Text(
                'dietary guidance',
                style: CustomTextStyles.font14WhiteBold(context).copyWith(color: ColorsManager.lightGray),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomAppButton(
                  onPressed: (){},
                  buttonWidth: 180,
                  btnText: 'Start Health Check'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}