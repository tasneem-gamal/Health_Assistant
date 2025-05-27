import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: ColorsManager.mainColor
        ),
      ),
      body: const AccountViewBody(),
    );
  }
}

class AccountViewBody extends StatelessWidget {
  const AccountViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.appPadding,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  child: Image.asset('assets/images/doctor.png'),
                ),
                verticalSpace(context, 16),
                Text(
                  'Change profile picture',
                  style: CustomTextStyles.font16LightGrayBold(context)
                      .copyWith(color: ColorsManager.mainColor),
                ),
              ],
            ),
          ),
          verticalSpace(context, 32),
          Text(
            'Name',
            style: CustomTextStyles.font16LightGrayBold(context).copyWith(color: Colors.black),
          ),
          verticalSpace(context, 8),
          CustomTextFormField(
            validator: (validator) {},
            hintText: 'User Name',
            prefixIcon: const Icon(Icons.person),
            suffixIcon: const Icon(
              Icons.edit,
              color: ColorsManager.lightGray,
            ),
          ),
          verticalSpace(context, 12),
          Text(
            'Email',
            style: CustomTextStyles.font16LightGrayBold(context).copyWith(color: Colors.black),
          ),
          verticalSpace(context, 8),
          CustomTextFormField(
            validator: (validator) {},
            hintText: 'User@gmail.com',
            prefixIcon: const Icon(Icons.email),
            suffixIcon: const Icon(
              Icons.edit,
              color: ColorsManager.lightGray,
            ),
          ),
          verticalSpace(context, 12),
          Text(
            'Phone Number',
            style: CustomTextStyles.font16LightGrayBold(context).copyWith(color: Colors.black),
          ),
          verticalSpace(context, 8),
          CustomTextFormField(
            validator: (validator) {},
            hintText: '01010101010',
            prefixIcon: const Icon(Icons.phone),
            suffixIcon: const Icon(
              Icons.edit,
              color: ColorsManager.lightGray,
            ),
          ),
          verticalSpace(context, 12),
          Text(
            'password',
            style: CustomTextStyles.font16LightGrayBold(context).copyWith(color: Colors.black),
          ),
          verticalSpace(context, 8),
          CustomTextFormField(
            validator: (validator) {},
            hintText: '*******',
            prefixIcon: const Icon(Icons.password),
            suffixIcon: const Icon(
              Icons.edit,
              color: ColorsManager.lightGray,
            ),
          ),
          verticalSpace(context, 24),
          CustomAppButton(
            onPressed: (){},
            btnText: 'Save Changes'
          )
        ],
      )),
    );
  }
}
