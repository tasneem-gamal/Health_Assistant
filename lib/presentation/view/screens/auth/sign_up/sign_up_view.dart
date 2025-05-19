import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/presentation/view/widgets/auth/sign_up/sign_up_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: (){context.pop();},
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsManager.mainColor,
          ),
        ),
      ),
      body: const SignUpViewBody(),
    );
  }
}

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isChecked = false.obs;
    return Padding(
      padding: Constants.appPadding,
      child: SingleChildScrollView(
          child: Column(
        children: [
          verticalSpace(context, 24),
          Center(
              child: Image.asset(
            'assets/images/splash.png',
            width: 222,
            height: 63,
          )),
          verticalSpace(context, 80),
          SignUpForm(isChecked: isChecked),
        ],
      )),
    );
  }
}



