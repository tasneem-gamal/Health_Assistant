import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: GlobalKey(),
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login to Your Account',
            style: CustomTextStyles.font14WhiteBold(context).copyWith(color: Colors.black),
          ),
          verticalSpace(context, 20),
          CustomTextFormField(
            validator: (validator){}, 
            hintText: 'Username or email'
          ),
          verticalSpace(context, 20),
          CustomTextFormField(
            validator: (validator){}, 
            hintText: 'Password',
            suffixIcon: const Icon(Icons.visibility_off),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: CustomTextStyles.font12BlackMedium(context),
            )),
          ),
          verticalSpace(context, 24),
          CustomAppButton(
            btnText: 'Login',
            onPressed: (){},
          ),
          verticalSpace(context, 30),
        ],
      ),
    );
  }
}