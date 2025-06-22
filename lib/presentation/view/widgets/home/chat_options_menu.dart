import 'package:flutter/material.dart';
import 'package:health_assistant/core/widgets/custom_circle_item.dart';

class ChatOptionsMenu extends StatelessWidget {
  final VoidCallback onAnalyze;
  final VoidCallback onFitnessPlan;
  final VoidCallback onNutritionPlan;

  const ChatOptionsMenu({
    super.key, 
    required this.onAnalyze, 
    required this.onFitnessPlan, 
    required this.onNutritionPlan,
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
        if (value == 'analyze') {
          onAnalyze();
        } else if (value == 'fitness') {
          onFitnessPlan();
        } else{
          onNutritionPlan();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'analyze',
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/symptom.png'),
            title: const Text('Analyze symptoms'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'fitness',
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/exercise_running.png'),
            title: const Text('Fitness Plan'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'nutrition',
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/nutrition.png'),
            title: const Text('Fitness Plan'),
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