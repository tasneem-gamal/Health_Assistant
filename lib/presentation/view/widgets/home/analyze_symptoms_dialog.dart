import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';


class AnalyzeSymtomsDialog extends StatelessWidget {
  const AnalyzeSymtomsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height *0.25,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/stethoscope.png'),
                  horizontalSpace(context, 12),
                  Text(
                    'Advanced Symptoms Checker',
                    style: CustomTextStyles.font12BlackMedium(context).copyWith(
                      color: ColorsManager.lightGray
                    ),
                  )
                ],
              ),
              verticalSpace(context, 8),
              const Divider(
                thickness: 1,
                color: ColorsManager.mainColor,
              ),
              verticalSpace(context, 8),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorsManager.mainColor),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          validator: (validator){}, 
                          hintText: 'cough'
                        ),
                      ),
                      Expanded(
                        child: CustomTextFormField(
                          validator: (validator){}, 
                          hintText: 'Mild(1-3)'
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          onPressed: (){}, 
                          icon: const Icon(Icons.delete, color: Colors.white, size: 20,)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(context, 12),
              Row(
                children: [
                  Expanded(
                    child: CustomAppButton(
                        onPressed: () {},
                        buttonHeight: 70,
                        btnText: 'Add \nSymptoms'
                      ),
                  ),
                  horizontalSpace(context, 12),
                  Expanded(
                    child: CustomAppButton(
                        onPressed: () {},
                        buttonHeight: 70,
                        btnText: 'Analyze \nSymptoms'
                      ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}