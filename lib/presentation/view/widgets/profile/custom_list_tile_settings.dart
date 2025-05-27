import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';

class CustomListTileSettings extends StatelessWidget {
  const CustomListTileSettings({
    super.key, required this.text, required this.leadingIcon,
  });

  final String text;
  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(leadingIcon, color: ColorsManager.mainColor,),
          title: Text(
            text,
            style: CustomTextStyles.font16LightGrayBold(context),
          ),
          trailing: IconButton(
            padding: EdgeInsets.zero,
            onPressed: (){}, 
            icon: const Icon(Icons.arrow_forward_ios, size: 18,)
          ),
        ),
        const Padding(
            padding: EdgeInsets.only(right: 24, top: 12),
            child: Divider(thickness: 1, color: ColorsManager.mainColor,),
          )
      ],
    );
  }
}