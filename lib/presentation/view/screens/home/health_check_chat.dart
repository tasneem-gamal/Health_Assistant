import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/widgets/custom_circle_item.dart';
import 'package:health_assistant/presentation/view/widgets/home/chat_app_bar_title.dart';
import 'package:health_assistant/presentation/view/widgets/home/custom_chat.dart';
import 'package:health_assistant/presentation/view/widgets/home/option_card.dart';

class HealthCheckChat extends StatelessWidget {
  const HealthCheckChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: CustomCircleItem(
          onTap:() {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back, color: ColorsManager.lightGray,),
        ),
        centerTitle: true,
        titleSpacing: 40.0,
        title: const ChatAppBarTitle(),
        actions: [
          CustomCircleItem(
            icon: const Icon(Icons.more_horiz, color: ColorsManager.lightGray,), 
            onTap: (){}
          )
        ],
      ),
      body: const SafeArea(child: HealthCheckChatBody()),
    );
  }
}





class HealthCheckChatBody extends StatefulWidget {
  const HealthCheckChatBody({super.key});

  @override
  State<HealthCheckChatBody> createState() => _HealthCheckChatBodyState();
}

class _HealthCheckChatBodyState extends State<HealthCheckChatBody> {
  bool showOptions = true;

  void handleFocusChanged(bool hasFocus) {
    if (hasFocus && showOptions) {
      setState(() {
        showOptions = false;
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Stack(
    children: [
      CustomChat(onFocusChanged: handleFocusChanged),
      if (showOptions)
      Positioned(
        top: MediaQuery.of(context).size.height * 0.3,
        left: 0,
        right: 0,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionCard(
                  image: 'assets/images/symptom.png',
                  title: 'Analyze Symptoms',
                  onTap: (){},
                ),
                const SizedBox(width: 12),
                OptionCard(
                  image: 'assets/images/exercise_running.png',
                  title: 'Fitness Plan',
                  onTap: (){}
                ),
              ],
            ),
            const SizedBox(height: 12),
            OptionCard(
              image: 'assets/images/nutrition.png',
              title: 'Nutrition Plan',
              onTap: (){},
            ),
          ],
        ),
      ),
    ],
  );
}
}


