import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/widgets/custom_circle_item.dart';
import 'package:health_assistant/presentation/view/widgets/home/chat_app_bar_title.dart';
import 'package:health_assistant/presentation/view/widgets/home/custom_chat.dart';

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





class HealthCheckChatBody extends StatelessWidget {
  const HealthCheckChatBody({super.key});

  @override
Widget build(BuildContext context) {
  return Stack(
    children: [
      const CustomChat(),
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

class OptionCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const OptionCard({
    required this.image,
    required this.title,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: ColorsManager.grayShade,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
            ),
            const SizedBox(height: 8),
            Text(
              title, 
              style: const TextStyle(fontWeight: FontWeight.bold, color: ColorsManager.lightGray),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
