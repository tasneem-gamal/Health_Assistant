import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/data/models/home/assessment_question_model.dart';
import 'package:health_assistant/presentation/view/widgets/home/option_card.dart';


class AssessmentCard extends StatelessWidget {
  const AssessmentCard({
    super.key,
    required this.selectedAnswer,
    required this.onSelectAnswer, required this.assessmentQuestionModel,
  });

  final AssessmentQuestionModel assessmentQuestionModel;
  final int? selectedAnswer;
  final Function(int) onSelectAnswer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          border: Border.all(color: ColorsManager.moreLightGray),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              Text(
                assessmentQuestionModel.question,
                textAlign: TextAlign.center,
                style: CustomTextStyles.font14WhiteBold(context).copyWith(color: Colors.black),
              ),
              verticalSpace(context, 24),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OptionCard(
                      image: assessmentQuestionModel.image1 ?? 'assets/images/not_at_all.png',
                      title: assessmentQuestionModel.title1 ?? 'Not at all',
                      onTap: () => onSelectAnswer(0),
                      isSelected: selectedAnswer == 0,
                    ),
                    OptionCard(
                      image: assessmentQuestionModel.image2 ??'assets/images/several.png',
                      title: assessmentQuestionModel.title2 ?? 'Several days',
                      onTap: () => onSelectAnswer(1),
                      isSelected: selectedAnswer == 1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OptionCard(
                      image: assessmentQuestionModel.image3 ?? 'assets/images/clock.png',
                      title: assessmentQuestionModel.title3 ?? 'More than half the days',
                      onTap: () => onSelectAnswer(2),
                      isSelected: selectedAnswer == 2,
                    ),
                    OptionCard(
                      image: assessmentQuestionModel.image4 ?? 'assets/images/everyday.png',
                      title: assessmentQuestionModel.title4 ?? 'Nearly everyday',
                      onTap: () => onSelectAnswer(3),
                      isSelected: selectedAnswer == 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
