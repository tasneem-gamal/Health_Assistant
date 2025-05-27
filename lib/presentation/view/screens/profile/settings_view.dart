
import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/presentation/view/widgets/profile/custom_list_tile_settings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: ColorsManager.mainColor
        ),
      ),
      body: const SettingsViewBody(),
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
            'User',
            style: CustomTextStyles.font16LightGrayBold(context)
                .copyWith(color: ColorsManager.mainColor),
          ),
          Text(
            'User@gmail.com',
            style: CustomTextStyles.font16LightGrayRegular(context),
          ),
          verticalSpace(context, 20),
          CustomListTileSettings(
            text: 'Account',
            leadingIcon: Icons.account_circle_outlined,
            onPressed: (){},
          ),
          CustomListTileSettings(
            text: 'Contact Us',
            leadingIcon: Icons.chat_outlined,
            onPressed: (){},
          ),
          CustomListTileSettings(
            text: 'Privacy Policy',
            leadingIcon: Icons.privacy_tip,
            onPressed: (){},
          ),
          CustomListTileSettings(
            text: 'Logout',
            leadingIcon: Icons.logout,
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}

