import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';

class CustomListTileSettings extends StatelessWidget {
  const CustomListTileSettings({
    super.key, required this.text, required this.leadingIcon, required this.onPressed,
  });

  final String text;
  final IconData leadingIcon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPressed,
          leading: Icon(leadingIcon, color: ColorsManager.mainColor,),
          title: Text(
            text,
            style: CustomTextStyles.font16LightGrayBold(context),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18,)
        ),
        const Padding(
            padding: EdgeInsets.only(right: 24, top: 12),
            child: Divider(thickness: 1, color: ColorsManager.mainColor,),
          )
      ],
    );
  }
}