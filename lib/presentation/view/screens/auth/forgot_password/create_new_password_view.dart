import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';

class CreateNewPasswordView extends StatelessWidget {
  const CreateNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreateNewPasswordViewBody(),
    );
  }
}

class CreateNewPasswordViewBody extends StatefulWidget {
  const CreateNewPasswordViewBody({super.key});

  @override
  State<CreateNewPasswordViewBody> createState() =>
      _CreateNewPasswordViewBodyState();
}

class _CreateNewPasswordViewBodyState extends State<CreateNewPasswordViewBody> {
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObsecureText = true;
  bool isPasswordConfirmationObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.appPadding,
      child: SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'create password️',
                    style: CustomTextStyles.font32BlackBold(context),
                  ),
                  verticalSpace(context, 16),
                  Text(
                    'the password should have at least 6 characters.',
                    style: CustomTextStyles.font16LightGrayRegular(context),
                  ),
                  verticalSpace(context, 24),
                  CustomTextFormField(
                    validator: (validator) {},
                    hintText: 'New Password',
                    isObsecureText: isObsecureText,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isObsecureText = !isObsecureText;
                          });
                        },
                        child: Icon(
                          isObsecureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        )),
                  ),
                  verticalSpace(context, 16),
                  CustomTextFormField(
                      validator: (validator) {},
                      isObsecureText: isPasswordConfirmationObscureText,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordConfirmationObscureText =
                                  !isPasswordConfirmationObscureText;
                            });
                          },
                          child: Icon(
                            isPasswordConfirmationObscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          )),
                      hintText: 'Confirm password'),
                  verticalSpace(context, 24),
                  CustomAppButton(
                    onPressed: (){},
                    btnText: 'Confirm'
                  )
                ],
              ),
            )),
      ),
    );
  }
}
