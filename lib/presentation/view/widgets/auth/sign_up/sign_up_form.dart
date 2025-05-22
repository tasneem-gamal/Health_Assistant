import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:health_assistant/core/utils/app_regex.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';
import 'package:health_assistant/presentation/controllers/auth/auth_cubit.dart';
import 'package:health_assistant/presentation/view/widgets/auth/sign_up/privacy_policy_check_box.dart';
import 'package:health_assistant/core/theming/styles.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.isChecked,
  });

  final RxBool isChecked;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final TextEditingController passwordConfirmController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> signUpFormKey = GlobalKey();
  bool isObsecureText = true;
  bool isPasswordConfirmationObscureText = true;
  RxBool isFormValid = false.obs;

  

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpFormKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Your Account',
            style: CustomTextStyles.font14WhiteBold(context)
                .copyWith(color: Colors.black),
          ),
          verticalSpace(context, 20),
          CustomTextFormField(
              validator: emailValidate,
              controller: emailController, 
              hintText: 'Email',
              onChanged: (_) => updateFormValidState(),
            ),
          verticalSpace(context, 20),
          CustomTextFormField(
            validator: phoneValidate,
            controller: phoneController,
            hintText: 'Phone Number',
            onChanged: (_) => updateFormValidState(),
          ),
          verticalSpace(context, 20),
          CustomTextFormField(
            validator: passwordValidate,
            controller: passwordController,
            isObsecureText: isObsecureText,
            onChanged: (_) => updateFormValidState(),
            hintText: 'Password',
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObsecureText = !isObsecureText;
                  });
                },
                child: Icon(
                  isObsecureText ? Icons.visibility_off : Icons.visibility,
                )),
          ),
          verticalSpace(context, 20),
          CustomTextFormField(
            validator: confirmPasswordValidate,
            controller: passwordConfirmController,
            isObsecureText: isPasswordConfirmationObscureText,
            onChanged: (_) => updateFormValidState(),
            hintText: 'Confirm Password',
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isPasswordConfirmationObscureText = !isPasswordConfirmationObscureText;
                  });
                },
                child: Icon(
                  isPasswordConfirmationObscureText ? Icons.visibility_off : Icons.visibility,
                )),
          ),
          verticalSpace(context, 20),
          PrivacyPolicyCheckBox(
            isChecked: widget.isChecked,
            onCheckedChanged: updateFormValidState,
          ),
          verticalSpace(context, 24),
          Obx(() => CustomAppButton(
                btnText: 'Sign Up',
                onPressed: isFormValid.value
                    ? () => validateThenSignUp(context)
                    : null,
              )),
        ],
      ),
    );
  }

    emailValidate(value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!AppRegex.isEmailValid(value)) {
      return 'Enter a valid email address';
    }
  }

  passwordValidate(value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (!AppRegex.hasLowerCase(value) &&
        !AppRegex.hasMinLength(value) &&
        !AppRegex.isPasswordValid(value) &&
        !AppRegex.hasSpecialCharacter(value)) {
      return "Enter a valid password: at least 8 characters,\nincluding one lowercase letter and one special char.";
    }
  }

      phoneValidate(value) {
    if (value == null || value.isEmpty) {
      return 'Phone cannot be empty';
    }
    if (!AppRegex.isPhoneNumberValid(value)) {
      return 'Enter a valid Phone Number';
    }
  }

    confirmPasswordValidate(value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void updateFormValidState() {
  isFormValid.value =
      emailController.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      passwordConfirmController.text == passwordController.text &&
      widget.isChecked.value;
}
    void validateThenSignUp(BuildContext context){
    if(signUpFormKey.currentState!.validate()){
      context.read<AuthCubit>().emitSignUpState(
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text
      );
    }
  }
}