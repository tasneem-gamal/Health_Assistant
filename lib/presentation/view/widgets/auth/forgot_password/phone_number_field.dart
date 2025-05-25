import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.moreLightGray),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          if (number.phoneNumber != null) {
            widget.onChanged(number.phoneNumber!);
          }
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DROPDOWN,
          showFlags: true,
          useEmoji: true,
        ),
        ignoreBlank: false,
        autoValidateMode: autovalidateMode,
        selectorTextStyle: const TextStyle(color: Colors.black),
        initialValue: number,
        textFieldController: widget.controller,
        formatInput: true,
        keyboardType: TextInputType.phone,
        inputDecoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Your number",
          hintStyle: TextStyle(color: ColorsManager.moreLightGray),
        ),
      ),
    );
  }
}