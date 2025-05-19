import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/presentation/view/widgets/auth/login/login_form.dart';

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
            const LoginForm(),
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

