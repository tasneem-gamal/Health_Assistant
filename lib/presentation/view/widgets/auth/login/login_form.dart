import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/app_regex.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final GlobalKey<FormState> loginFormKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isObsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login to Your Account',
            style: CustomTextStyles.font14WhiteBold(context).copyWith(color: Colors.black),
          ),
          verticalSpace(context, 20),
          CustomTextFormField(
            validator: emailValidate, 
            controller: emailController,
            hintText: 'Email'
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
            child: Icon(isObsecureText ? Icons.visibility_off : Icons.visibility,)
          ),
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
            onPressed: (){
              validateThenDologin(context);
            },
          ),
          verticalSpace(context, 30),
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

  void validateThenDologin(BuildContext context){
    if(loginFormKey.currentState!.validate()){
      
    }
  }
}