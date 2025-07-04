import 'package:flutter/material.dart';
import 'package:health_assistant/core/widgets/custom_circle_item.dart';

class ChatOptionsMenu extends StatelessWidget {
  final VoidCallback optionOne;
  final VoidCallback optionTwo;
  final VoidCallback optionThree;
  final String optionOneImage, optionOneTitle, optionTwoImage, optionTwoTitle, optionThreeImage, optionThreeTitle;

  const ChatOptionsMenu({
    super.key, 
    required this.optionOne, 
    required this.optionTwo, 
    required this.optionThree, 
    required this.optionOneImage, 
    required this.optionOneTitle, 
    required this.optionTwoImage, 
    required this.optionTwoTitle, 
    required this.optionThreeImage, 
    required this.optionThreeTitle,
  });
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      onSelected: (value) {
        if (value == 'option_one') {
          optionOne();
        } else if (value == 'option_two') {
          optionTwo();
        } else{
          optionThree();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'option_one',
          child: ListTile(
            dense: true,
            leading: Image.asset(optionOneImage),
            title: Text(optionOneTitle),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'option_two',
          child: ListTile(
            dense: true,
            leading: Image.asset(optionTwoImage),
            title: Text(optionTwoTitle),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'option_three',
          child: ListTile(
            dense: true,
            leading: Image.asset(optionThreeImage),
            title: Text(optionThreeTitle),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
      child: const CustomCircleItem(
        icon: Icon(Icons.more_horiz),
      ),
    );
  }
}