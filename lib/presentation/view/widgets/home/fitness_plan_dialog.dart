import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/presentation/view/widgets/home/text_field_with_title.dart';


class FitnessPlanDialog extends StatefulWidget {
  const FitnessPlanDialog({super.key});

  @override
  State<FitnessPlanDialog> createState() => _FitnessPlanDialogState();
}

class _FitnessPlanDialogState extends State<FitnessPlanDialog> {
  bool showSecondStep = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: showSecondStep 
        ? MediaQuery.of(context).size.height * 0.53 
        : MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/exercise_running.png'),
                  horizontalSpace(context, 12),
                  Text(
                    'Fitness Plan Generator',
                    style: CustomTextStyles.font12BlackMedium(context).copyWith(
                      color: ColorsManager.lightGray,
                    ),
                  ),
                ],
              ),
              verticalSpace(context, 8),
              const Divider(
                thickness: 1,
                color: ColorsManager.mainColor,
              ),
              verticalSpace(context, 8),
              if (!showSecondStep) ...[
                const Row(
                  children: [
                    TextFieldWithTitle(title: 'Height (cm)'),
                    SizedBox(width: 12),
                    TextFieldWithTitle(title: 'Weight(kg)'),
                  ],
                ),
                verticalSpace(context, 12),
                const Row(
                  children: [
                    TextFieldWithTitle(title: 'Age'),
                    SizedBox(width: 12),
                    TextFieldWithTitle(title: 'Gender'),
                    SizedBox(width: 12),
                    TextFieldWithTitle(title: 'Activity Level'),
                  ],
                ),
                verticalSpace(context, 12),
                CustomAppButton(
                  onPressed: () {
                    setState(() {
                      showSecondStep = true;
                    });
                  },
                  btnText: 'Next',
                ),
              ] else ...[
                const Row(
                  children: [
                    TextFieldWithTitle(title: 'Current Fitness Level'),
                    SizedBox(width: 12),
                    TextFieldWithTitle(title: 'Sessions per Week'),
                  ],
                ),
                verticalSpace(context, 12),
                const Row(
                  children: [
                    TextFieldWithTitle(title: 'Session Duration (min)'),
                    SizedBox(width: 12),
                    TextFieldWithTitle(title: 'Fitness Goal'),
                  ],
                ),
                verticalSpace(context, 12),
                const TextFieldWithTitle(title: 'Physical Limitations/Injuries'),
                verticalSpace(context, 12),
                CustomAppButton(
                  onPressed: () {},
                  btnText: 'Generate Plan',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

