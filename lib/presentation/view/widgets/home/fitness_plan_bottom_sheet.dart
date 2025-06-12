import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/presentation/view/widgets/home/text_field_with_title.dart';


class FitnessPlanBottomSheet extends StatefulWidget {
  const FitnessPlanBottomSheet({super.key});

  @override
  State<FitnessPlanBottomSheet> createState() => _FitnessPlanBottomSheetState();
}

class _FitnessPlanBottomSheetState extends State<FitnessPlanBottomSheet> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, 
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          height: currentStep == 1
            ? MediaQuery.of(context).size.height * 0.35
            : MediaQuery.of(context).size.height * 0.5,
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
                  },
                ),
              ] else if (currentStep == 2) ...[
                GenerateStep(
                  onGenerate: () {
                    setState(() {
                      currentStep = 3;
                    });
                  },
                ),
              ] 
            ],
          ),
        ),
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
              const TextFieldWithTitle(
                title: 'Height (cm)',
                hintText: 'e.g 175',
              ),
              horizontalSpace(context, 12),
              const TextFieldWithTitle(
                title: 'Weight(kg)',
                hintText: 'e.g 70',
              ),
            ],
          ),
          verticalSpace(context, 12),
          Row(
            children: [
              const TextFieldWithTitle(
                title: 'Age',
                hintText: 'e.g 25',
              ),
              horizontalSpace(context, 12),
              const TextFieldWithTitle(
                title: 'Gender',
                hintText: 'Male',
              ),
              horizontalSpace(context, 12),
              const TextFieldWithTitle(
                title: 'Fitness Level',
                hintText: 'e.g beginner, intermediate..',
              ),
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
          Row(
            children: [
              const TextFieldWithTitle(
                title: 'Sessions per Week',
                hintText: 'e.g 3',
              ),
              horizontalSpace(context, 12),
              const TextFieldWithTitle(
                title: 'Session Duration (min)',
                hintText: 'e.g 20min',
              ),
            ],
          ),
          verticalSpace(context, 12),
          Row(
            children: [
              const TextFieldWithTitle(
                title: 'Equipments',
                hintText: 'e.g resistance bands, bodyweight ...',
              ),
              horizontalSpace(context, 12),
              const TextFieldWithTitle(
                title: 'Fitness Goal',
                hintText: 'e.g weight loss',
              ),
            ],
          ),
          verticalSpace(context, 12),
          const TextFieldWithTitle(
            title: 'Physical Limitations/Injuries',
            hintText: '',
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
