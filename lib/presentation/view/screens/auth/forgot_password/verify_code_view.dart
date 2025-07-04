import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/font_weight_helper.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/presentation/view/screens/auth/forgot_password/create_new_password_view.dart';
import 'package:health_assistant/presentation/view/widgets/auth/forgot_password/otp_boxes.dart';
import 'package:health_assistant/presentation/view/widgets/auth/forgot_password/resend_code_button.dart';

class VerifyCodeView extends StatelessWidget {
  const VerifyCodeView({super.key, required this.verificationId, required this.phoneNumber});
  final String verificationId;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerifyCodeViewBody(
        verificationId: verificationId,
        phoneNumber: phoneNumber,
      ),
    );
  }
}

class VerifyCodeViewBody extends StatefulWidget {
  const VerifyCodeViewBody({super.key, required this.verificationId, required this.phoneNumber});
  final String verificationId;
  final String phoneNumber;

  @override
  State<VerifyCodeViewBody> createState() => _VerifyCodeViewBodyState();
}

class _VerifyCodeViewBodyState extends State<VerifyCodeViewBody> {
  final TextEditingController otpController = TextEditingController();
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
                  'Verify Code ⚡️',
                  style: CustomTextStyles.font32BlackBold(context),
                ),
                verticalSpace(context, 16),
                RichText(
                  text: TextSpan(
                    text: 'We just sent a 4-digit verification code to \n',
                    style: CustomTextStyles.font16LightGrayRegular(context),
                    children: [
                      TextSpan(
                        text: '+20 1018930494. ', 
                        style: CustomTextStyles.font16LightGrayBold(context)
                      ),
                      TextSpan(
                        text: 'Enter the code in the box below to continue.',
                        style: CustomTextStyles.font16LightGrayRegular(context),
                      )
                    ]
                  ),
                ),
                TextButton(
                  onPressed: (){
                    context.pop();
                  }, 
                  child: Text(
                    'edit the number',
                    style: CustomTextStyles.font14MainColorRegular(context).copyWith(
                      fontWeight: FontWeightHelper.bold
                    ),
                  )
                ),
                verticalSpace(context, 16),
                OtpBoxes(otpController: otpController,),
                verticalSpace(context, 16),
                const ResendCodeButton(),
                verticalSpace(context, 16),
                CustomAppButton(
                  onPressed: () {
                    final code = otpController.text.trim();
                    if (code.length != 4) return;
                    context.push(
                      CreateNewPasswordView(
                        verificationId: widget.verificationId,
                        otpCode: code,
                      ),
                    );
                  },
                  btnText: 'Next')
            ],
          ),
        ),
      ),
    );
  }
}


