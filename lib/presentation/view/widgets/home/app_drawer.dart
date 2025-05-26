import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'History',
                  style: CustomTextStyles.font32BlackBold(context),
                ),
                verticalSpace(context, 24),
                CustomAppButton(onPressed: () {}, btnText: '+  New Chat'),
                verticalSpace(context, 24),
                Text(
                  'Chat List',
                  style: CustomTextStyles.font16LightGrayBold(context),
                ),
                verticalSpace(context, 24),
                const CustomListTile()
              ],
            ),
            CustomAppButton(
              onPressed: () {},
              backgroundColor: Colors.red,
              btnText: 'Clear all',
            ),
          ],
        ),
      ),
    );

  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.keyboard_arrow_down),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'i feel that i am sick today',
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 1,
            style: CustomTextStyles.font12BlackMedium(context),
          ),
          Text(
            '08 Apr',
            style: CustomTextStyles.font12MainColorMedium(context),
          )
        ],
      ),
      trailing: const Icon(Icons.delete)
    );
  }
}