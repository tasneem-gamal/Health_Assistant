import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';


class MoodProgress extends StatelessWidget {
  const MoodProgress({
    super.key, required this.progress, required this.mood,
  });

  final double progress;
  final String mood;

  Color _getColorByProgress(double value) {
    if (value < 0.4) {
      return Colors.red;
    } else if (value < 0.7) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressColor = _getColorByProgress(progress);
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.moreLightGray,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 1), 
          )
        ] 
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.sentiment_very_dissatisfied, size: 40),
                Icon(Icons.sentiment_very_satisfied, size: 40,),
              ],
            ),
            verticalSpace(context, 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress, 
                minHeight: 10,
                backgroundColor: Colors.grey.shade300,
                valueColor:
                    AlwaysStoppedAnimation<Color>(progressColor),
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
                      style: CustomTextStyles.font16LightGrayBold(context).copyWith(
                        color: ColorsManager.mainColor
                      ),
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
                      '0.2%',
                      style: CustomTextStyles.font16LightGrayBold(context).copyWith(
                        color: ColorsManager.mainColor
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}