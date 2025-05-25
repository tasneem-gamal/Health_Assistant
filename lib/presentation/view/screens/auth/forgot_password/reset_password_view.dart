import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/presentation/controllers/auth/auth_cubit.dart';
import 'package:health_assistant/presentation/view/screens/auth/forgot_password/verify_code_view.dart';
import 'package:health_assistant/presentation/view/widgets/auth/forgot_password/phone_number_field.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResetPasswordViewBody(),
    );
  }
}

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody ({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final TextEditingController phoneController = TextEditingController();
  String? fullPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.appPadding,
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reset Password 🔐',
                style: CustomTextStyles.font32BlackBold(context),
              ),
              verticalSpace(context, 16),
              Text(
                'please enter your phone number below to recovery your password.',
                style: CustomTextStyles.font16LightGrayRegular(context),
              ),
              verticalSpace(context, 24),
              PhoneNumberField(
                controller: phoneController,
                onChanged: (value) {
                  fullPhoneNumber = value;
                },
              ),
              verticalSpace(context, 24),
              CustomAppButton(
                onPressed: () {
                  if (fullPhoneNumber != null) {
                    context.read<AuthCubit>().sendOTP(
                      phone: fullPhoneNumber!,
                      onCodeSent: (verificationId) {
                        context.push(
                          VerifyCodeView(
                            verificationId: verificationId,
                            phoneNumber: fullPhoneNumber!,
                          ),
                        );
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter your phone number")),
                    );
                  }
                },
                btnText: 'Send',
              ),
            ],
          ),
        ),
      ),
    );
  }
}