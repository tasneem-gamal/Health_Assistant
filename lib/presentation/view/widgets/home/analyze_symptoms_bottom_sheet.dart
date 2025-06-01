import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';


class AnalyzeSymptomsBottomSheet extends StatelessWidget {
  const AnalyzeSymptomsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/stethoscope.png', height: 24),
                horizontalSpace(context, 12),
                Text(
                  'Advanced Symptoms Checker',
                  style: CustomTextStyles.font12BlackMedium(context).copyWith(
                    color: ColorsManager.lightGray,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            verticalSpace(context, 12),
            const Divider(thickness: 1, color: ColorsManager.mainColor),
            verticalSpace(context, 16),
            CustomTextFormField(
              validator: (value) {},
              hintText: 'cough',
            ),
            verticalSpace(context, 12),
            CustomTextFormField(
              validator: (value) {},
              hintText: 'Mild(1-3)',
            ),
            verticalSpace(context, 12),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.white, size: 20),
                ),
              ),
            ),
            verticalSpace(context, 24),
            CustomAppButton(
              onPressed: () {},
              buttonHeight: 60,
              btnText: 'Add Symptom',
            ),
            verticalSpace(context, 12),
            CustomAppButton(
              onPressed: () {},
              buttonHeight: 60,
              btnText: 'Analyze Symptoms',
            ),
          ],
        ),
      ),
    );
  }
}