import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';

class CustomDropdownWithTitle extends StatelessWidget {
  const CustomDropdownWithTitle({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  final String title;
  final List<String> items;
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        Text(
            title,
            style: CustomTextStyles.font12BlackMedium(context),
          ),
          verticalSpace(context, 10),
        DropdownButtonFormField<String>(
          borderRadius: BorderRadius.circular(12),
          dropdownColor: ColorsManager.fieldGray,
          elevation: 2,
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: ColorsManager.fieldGray,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none
                ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none
              ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none
              ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red)),
          ),
          value: value,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
