import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';
import 'package:health_assistant/presentation/controllers/auth/update_user_info_cubit.dart';
import 'package:health_assistant/presentation/view/widgets/profile/update_user_info_bloc_listner.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UpdateUserInfoCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: ColorsManager.mainColor),
        ),
        body: const AccountViewBody(),
      ),
    );
  }
}

class AccountViewBody extends StatefulWidget {
  const AccountViewBody({super.key});

  @override
  State<AccountViewBody> createState() => _AccountViewBodyState();
}

class _AccountViewBodyState extends State<AccountViewBody> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final currentPasswordController = TextEditingController();


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void updateUserProfile() {
  final currentEmail = FirebaseAuth.instance.currentUser?.email ?? '';
  final currentPassword = currentPasswordController.text.trim();



  context.read<UpdateUserInfoCubit>().updateUser(
    currentEmail: currentEmail,
    currentPassword: currentPassword,
    name: nameController.text.trim(),
    email: emailController.text.trim(),
    phone: phoneController.text.trim(),
    password: passwordController.text.trim(),
  );
}


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
              style: CustomTextStyles.font16LightGrayBold(context)
                  .copyWith(color: Colors.black),
            ),
            verticalSpace(context, 8),
            CustomTextFormField(
              controller: nameController,
              validator: (_) {},
              hintText: 'User Name',
              prefixIcon: const Icon(Icons.person),
              suffixIcon: const Icon(Icons.edit, color: ColorsManager.lightGray),
            ),
            verticalSpace(context, 12),
            Text(
              'Email',
              style: CustomTextStyles.font16LightGrayBold(context)
                  .copyWith(color: Colors.black),
            ),
            verticalSpace(context, 8),
            CustomTextFormField(
              controller: emailController,
              validator: (_) {},
              hintText: 'User@gmail.com',
              prefixIcon: const Icon(Icons.email),
              suffixIcon: const Icon(Icons.edit, color: ColorsManager.lightGray),
            ),
            verticalSpace(context, 12),
            Text(
              'Phone Number',
              style: CustomTextStyles.font16LightGrayBold(context)
                  .copyWith(color: Colors.black),
            ),
            verticalSpace(context, 8),
            CustomTextFormField(
              controller: phoneController,
              validator: (_) {},
              hintText: '01010101010',
              prefixIcon: const Icon(Icons.phone),
              suffixIcon: const Icon(Icons.edit, color: ColorsManager.lightGray),
            ),
            verticalSpace(context, 12),
            Text(
              'Current password',
              style: CustomTextStyles.font16LightGrayBold(context)
                  .copyWith(color: Colors.black),
            ),
            verticalSpace(context, 8),
            CustomTextFormField(
              controller: currentPasswordController,
              validator: (v) {},
              hintText: '*******',
              prefixIcon: const Icon(Icons.password),
            ),
            verticalSpace(context, 12),
            Text(
              'New Password',
              style: CustomTextStyles.font16LightGrayBold(context)
                  .copyWith(color: Colors.black),
            ),
            verticalSpace(context, 8),
            CustomTextFormField(
              controller: passwordController,
              validator: (_) {},
              hintText: '*******',
              prefixIcon: const Icon(Icons.password),
              suffixIcon: const Icon(Icons.edit, color: ColorsManager.lightGray),
            ),
            verticalSpace(context, 24),
            CustomAppButton(
              onPressed: updateUserProfile,
              btnText: 'Save Changes',
            ),
            const UpdateUserInfoBlocListner(),
          ],
        ),
      ),
    );
  }
}
