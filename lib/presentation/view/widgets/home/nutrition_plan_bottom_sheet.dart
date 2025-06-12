import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/presentation/view/widgets/home/text_field_with_title.dart';


class NutritionPlanBottomSheet extends StatefulWidget {
  const NutritionPlanBottomSheet({super.key});

  @override
  State<NutritionPlanBottomSheet> createState() => _NutritionPlanBottomSheetState();
}

class _NutritionPlanBottomSheetState extends State<NutritionPlanBottomSheet> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, 
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          height: currentStep == 1
              ? MediaQuery.of(context).size.height * 0.4
              : currentStep == 2
                  ? MediaQuery.of(context).size.height * 0.3
                  : MediaQuery.of(context).size.height *0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
          Row(
            children: [
              TextFieldWithTitle(
                title: 'Height (cm)',
                hintText: 'e.g 175',
                controller: TextEditingController(),
              ),
              horizontalSpace(context, 12),
              TextFieldWithTitle(
                title: 'Weight(kg)',
                hintText: 'e.g 70',
                controller: TextEditingController(),
              ),
            ],
          ),
          verticalSpace(context, 12),
          TextFieldWithTitle(
            title: 'Fitness Goal',
            hintText: 'e.g weight loss',
            controller: TextEditingController(),
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
          Row(
            children: [
              TextFieldWithTitle(
                title: 'Age',
                hintText: 'e.g 25',
                controller: TextEditingController(),
              ),
              horizontalSpace(context, 12),
              TextFieldWithTitle(
                title: 'Gender',
                hintText: 'Male',
                controller: TextEditingController(),
              ),
              horizontalSpace(context, 12),
              TextFieldWithTitle(
                title: 'Activity level',
                hintText: 'e.g beginner, intermediate..',
                controller: TextEditingController(),
              ),
            ],
          ),
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
