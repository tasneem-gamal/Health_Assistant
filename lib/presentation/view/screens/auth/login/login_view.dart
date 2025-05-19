import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginViewBody(),
    );
  }
}

class LoginViewBody extends StatelessWidget {
  const LoginViewBody ({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.appPadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(context, 70),
            Center(child: Image.asset('assets/images/splash.png')),
            verticalSpace(context, 80),
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
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
              'Doesn’t have an account? ',
              style: CustomTextStyles.font12BlackMedium(context),
            ),
            GestureDetector(
              onTap: (){},
              child: Text(
                'Sign Up',
                style: CustomTextStyles.font12MainColorMedium(context)
              ),
            ),
            ],
            )
          ],
        ),
      ),
    );
  }
}