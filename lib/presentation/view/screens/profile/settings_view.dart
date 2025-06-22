import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/presentation/controllers/auth/auth_cubit.dart';
import 'package:health_assistant/presentation/view/screens/auth/login/login_view.dart';
import 'package:health_assistant/presentation/view/screens/profile/account_view.dart';
import 'package:health_assistant/presentation/view/screens/profile/contact_us_view.dart';
import 'package:health_assistant/presentation/view/widgets/profile/custom_list_tile_settings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: ColorsManager.mainColor),
        ),
        body: const SettingsViewBody(),
      ),
    );
  }
}

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 24, right: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            child: Image.asset('assets/images/doctor.png'),
          ),
          verticalSpace(context, 16),
          Text(
            FirebaseAuth.instance.currentUser?.displayName ?? "Name",
            style: CustomTextStyles.font16LightGrayBold(context)
                .copyWith(color: ColorsManager.mainColor),
          ),
          Text(
            FirebaseAuth.instance.currentUser?.email ?? "No Email",
            style: CustomTextStyles.font16LightGrayRegular(context),
          ),
          verticalSpace(context, 20),
          CustomListTileSettings(
            text: 'Account',
            leadingIcon: Icons.account_circle_outlined,
            onPressed: () {
              context.push(const AccountView());
            },
          ),
          CustomListTileSettings(
            text: 'Contact Us',
            leadingIcon: Icons.chat_outlined,
            onPressed: () {
              context.push(const ContactUsView());
            },
          ),
          CustomListTileSettings(
            text: 'Privacy Policy',
            leadingIcon: Icons.security,
            onPressed: () {},
          ),
          CustomListTileSettings(
            text: 'Logout',
            leadingIcon: Icons.logout,
            onPressed: () {
              signOutAlertDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void signOutAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            content: Text(
                'Hold on! Are you sure you’re ready to Sign out? Make sure everything’s saved.',
                style: CustomTextStyles.font12BlackMedium(context)),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: ColorsManager.lightGray),
                ),
              ),
              TextButton(
                onPressed: () async{
                  context.pop();
                  await context.read<AuthCubit>().emitSignOut();
                  if (context.mounted){context.pushAndRemoveUntil(const LoginView());}
                  
                },
                child: Text('Sign Out',
                    style: CustomTextStyles.font12BlackMedium(context).copyWith(color: Colors.red)),
              ),
            ],
          );
        });
  }
}
