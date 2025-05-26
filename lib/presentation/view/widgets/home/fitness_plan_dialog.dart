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
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: currentStep == 1
            ? MediaQuery.of(context).size.height * 0.4
            : currentStep == 2
                ? MediaQuery.of(context).size.height * 0.53
                : MediaQuery.of(context).size.height,
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
              if (currentStep == 1) ...[
                NextStep(
                  onNext: () {
                        setState(() {
                          currentStep = 2;
                        });
                      }
                ),
              ] else if (currentStep == 2) ...[
                GenerateStep(
                  onGenerate: () {
                        setState(() {
                          currentStep = 3;
                        });
                      }),
              ] else if (currentStep == 3) ...[
                const FinalPlan()
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class FinalPlan extends StatelessWidget {
  const FinalPlan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            '🎉 Your fitness plan is ready!',
          ),
          verticalSpace(context, 24),
          CustomAppButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            btnText: 'Close',
          ),
        ],
      ),
    );
  }
}

class NextStep extends StatelessWidget {
  const NextStep({super.key, required this.onNext});
  final Function() onNext;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
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
            onPressed: onNext,
            btnText: 'Next',
          ),
        ],
      ),
    );
  }
}

class GenerateStep extends StatelessWidget {
  const GenerateStep({super.key, required this.onGenerate});

  final Function() onGenerate;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
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
            onPressed: onGenerate,
            btnText: 'Generate Plan',
          ),
        ],
      ),
    );
  }
}
