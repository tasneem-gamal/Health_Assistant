import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:health_assistant/core/theming/colors.dart';

class PrivacyPolicyCheckBox extends StatelessWidget {
  const PrivacyPolicyCheckBox({
    super.key,
    required this.isChecked,
  });

  final RxBool isChecked;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            Checkbox(
              activeColor: Colors.green,
              value: isChecked.value,
              onChanged: (newValue) {
                isChecked.value = newValue!;
              },
            ),
            const Text(
              'I agree with and Accept ',
              style: TextStyle(
                fontSize: 11
              ),
            ),
            TextButton(
              onPressed: (){}, 
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero
              ),
              child: const Text(
                'Privacy and Policy',
                style: TextStyle(
                fontSize: 11,
                color: ColorsManager.mainColor
              ),
              )
            )
          ],
        ));
  }
}