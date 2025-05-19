import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/font_weight_helper.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/presentation/view/widgets/auth/forgot_password/otp_boxes.dart';
import 'package:health_assistant/presentation/view/widgets/auth/forgot_password/resend_code_button.dart';

class VerifyCodeView extends StatelessWidget {
  const VerifyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VerifyCodeViewBody(),
    );
  }
}

class VerifyCodeViewBody extends StatelessWidget {
  const VerifyCodeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.appPadding,
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
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
                  onPressed: (){}, 
                  child: Text(
                    'edit the number',
                    style: CustomTextStyles.font14MainColorRegular(context).copyWith(
                      fontWeight: FontWeightHelper.bold
                    ),
                  )
                ),
                verticalSpace(context, 16),
                const OtpBoxes(),
                verticalSpace(context, 16),
                const ResendCodeButton(),
                verticalSpace(context, 16),
                CustomAppButton(
                  onPressed: (){},
                  btnText: 'Next'
                )
            ],
          ),
        ),
      ),
    );
  }
}


