import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';

class TextFieldWithTitle extends StatelessWidget {
  const TextFieldWithTitle({
    super.key, required this.title, this.validator, required this.hintText,
  });

  final String title;
  final String hintText;
  final Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyles.font12BlackMedium(context),
          ),
          verticalSpace(context, 10),
          CustomTextFormField(
            validator: (value){},
            hintText: hintText,
          )
        ],
      ),
    );
  }
}