import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';


class MoodProgress extends StatelessWidget {
  const MoodProgress({
    super.key,
    required this.progress,
    required this.mood,
    required this.onCancel,
  });

  final double progress;
  final String mood;
  final VoidCallback onCancel; 

  Color _getColorByProgress(double value) {
  if (value < 0.2) return const Color(0xffd32f2f);
  if (value < 0.4) return const Color(0xffff7043); 
  if (value < 0.6) return const Color(0xffffca28);
  if (value < 0.8) return const Color(0xff66bb6a);
  return const Color(0xff2e7d32); 
}


  @override
  Widget build(BuildContext context) {
    final progressColor = _getColorByProgress(progress);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.moreLightGray,
            blurRadius: 2,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onCancel,
              child: const Icon(Icons.close, color: Colors.grey),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              Icon(Icons.sentiment_very_dissatisfied, size: 40),
              Icon(Icons.sentiment_very_satisfied, size: 40),
            ],
          ),
          verticalSpace(context, 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
          verticalSpace(context, 20),
          const Divider(thickness: 1),
          verticalSpace(context, 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'session mood',
                    style: CustomTextStyles.font12MainColorMedium(context),
                  ),
                  Text(
                    mood,
                    style: CustomTextStyles.font16LightGrayBold(context)
                        .copyWith(color: ColorsManager.mainColor),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'progress',
                    style: CustomTextStyles.font12MainColorMedium(context),
                  ),
                  Text(
                    '${(progress * 100).toStringAsFixed(1)}%',
                    style: CustomTextStyles.font16LightGrayBold(context)
                        .copyWith(color: ColorsManager.mainColor),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
