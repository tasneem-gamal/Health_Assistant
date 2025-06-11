import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: ColorsManager.mainColor
        ),
      ),
      body: const ContactUsViewBody(),
    );
  }
}

class ContactUsViewBody extends StatelessWidget {
  const ContactUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.appPadding,
      child: SingleChildScrollView(
          child: Column(
        children: [
          verticalSpace(context, 16),
          Text(
            'Welcome to help center ',
            style: CustomTextStyles.font16LightGrayBold(context)
                .copyWith(color: ColorsManager.mainColor),
          ),
          Text(
            'Please describe the problem, attach file if needed',
            textAlign: TextAlign.center,
            style: CustomTextStyles.font16LightGrayBold(context)
          ),
          verticalSpace(context, 32),
          CustomTextFormField(
            validator: (validator) {},
            hintText: 'Contact mail',
            prefixIcon: const Icon(Icons.email),
          ),
          verticalSpace(context, 24),
          CustomTextFormField(
            validator: (validator) {},
            hintText: 'Subject',
          ),
          verticalSpace(context, 24),
          CustomTextFormField(
            validator: (validator) {},
            hintText: 'Message',
            maxLines: 4,
          ),
          verticalSpace(context, 24),
          CustomTextFormField(
            validator: (validator) {},
            hintText: 'attach file',
            prefixIcon: const Icon(Icons.upload),
          ),
          verticalSpace(context, 24),
          CustomAppButton(
            onPressed: (){},
            btnText: 'Send'
          )
        ],
      )),
    );
  }
}
