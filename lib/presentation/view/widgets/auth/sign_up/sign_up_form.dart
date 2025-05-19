import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:health_assistant/core/utils/app_regex.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';
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
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpFormKey,
      autovalidateMode: autovalidateMode,
      child: Column(
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
              hintText: 'Email'
            ),
          verticalSpace(context, 20),
          CustomTextFormField(
            validator: phoneValidate,
            controller: phoneController,
            hintText: 'Phone Number',
          ),
          verticalSpace(context, 20),
          CustomTextFormField(
            validator: passwordValidate,
            controller: passwordController,
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
          PrivacyPolicyCheckBox(isChecked: widget.isChecked),
          verticalSpace(context, 24),
          CustomAppButton(
            btnText: 'Sign Up',
            onPressed: (){
              validateThenSignUp(context);
            },
          ),
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

    void validateThenSignUp(BuildContext context){
    if(signUpFormKey.currentState!.validate()){
      
    }
  }
}