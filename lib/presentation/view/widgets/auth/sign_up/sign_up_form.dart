import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';
import 'package:health_assistant/presentation/view/widgets/auth/sign_up/privacy_policy_check_box.dart';
import 'package:health_assistant/core/theming/styles.dart';


class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.isChecked,
  });

  final RxBool isChecked;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: GlobalKey(),
      child: Column(
        children: [
          Text(
            'Create Your Account',
            style: CustomTextStyles.font14WhiteBold(context)
                .copyWith(color: Colors.black),
          ),
          verticalSpace(context, 20),
          CustomTextFormField(
              validator: (validator) {}, 
              hintText: 'Email'
            ),
          verticalSpace(context, 20),
          CustomTextFormField(
            validator: (validator) {},
            hintText: 'Phone Number',
          ),
          verticalSpace(context, 20),
          CustomTextFormField(
            validator: (validator) {},
            hintText: 'Password',
            suffixIcon: const Icon(Icons.visibility_off),
          ),
          verticalSpace(context, 20),
          CustomTextFormField(
            validator: (validator) {},
            hintText: 'Confirm Password',
            suffixIcon: const Icon(Icons.visibility_off),
          ),
          verticalSpace(context, 20),
          PrivacyPolicyCheckBox(isChecked: isChecked),
          verticalSpace(context, 24),
          CustomAppButton(
            btnText: 'Sign Up',
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}