
import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_curved_container.dart';
import 'package:health_assistant/data/models/home/assessment_question_model.dart';
import 'package:health_assistant/presentation/view/widgets/home/assessment_card.dart';

class AdjustmentAssessment extends StatelessWidget {
  const AdjustmentAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsManager.mainColor,
        iconTheme: const IconThemeData(
          color: Colors.white
        )
      ),
      body: const AdjustmentAssessmentBody() ,
    );
  }
}

class AdjustmentAssessmentBody extends StatefulWidget {
  const AdjustmentAssessmentBody({super.key});

  @override
  State<AdjustmentAssessmentBody> createState() => _AdjustmentAssessmentBodyState();
}

class _AdjustmentAssessmentBodyState extends State<AdjustmentAssessmentBody> {
  int currentIndex = 0;

  final List<AssessmentQuestionModel> questions = [
    AssessmentQuestionModel(
      question: 'how well are you coping with recent life changes?',
      title1: 'Coping well',
      image1: 'assets/images/everyday.png',
      title2: 'Mild difficulty',
      image2: 'assets/images/not_at_all.png',
      title3: 'Moderate difficulty',
      title4: 'Severe difficulty',
      image4: 'assets/images/slight.png',
    )
  ];
  List<int?> selectedAnswers = List.filled(4, null);

  void selectAnswer(int index) {
    setState(() {
      selectedAnswers[currentIndex] = index;
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCurvedContainer(
          text: 'Adjustment Assessment',
          style: customTextStyle(context),
        ),
        verticalSpace(context, 30),
        AssessmentCard(
          assessmentQuestionModel: questions[currentIndex],
          selectedAnswer: selectedAnswers[currentIndex],
          onSelectAnswer: selectAnswer,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentIndex > 0)
                CustomAppButton(
                  onPressed: previousQuestion,
                  buttonWidth: 90,
                  btnText: 'Previous',
                )
              else
              horizontalSpace(context, 50),
              CustomAppButton(
                onPressed: nextQuestion,
                buttonWidth: 90,
                btnText: currentIndex == questions.length - 1 ? 'Finish' : 'Next',
              ),
            ],
          ),
        )],
    );
  }
  
  TextStyle customTextStyle(BuildContext context) {
    return CustomTextStyles.font24WhiteMedium(context).copyWith(
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: <Color>[
                  Colors.white,
                  ColorsManager.mainColorLight
                ],
              ).createShader(const Rect.fromLTWH(200.0, 0.0, 50.0, 0.0)),
          );
  }
}