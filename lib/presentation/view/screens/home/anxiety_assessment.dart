
import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_curved_container.dart';
import 'package:health_assistant/data/models/home/assessment_question_model.dart';
import 'package:health_assistant/presentation/view/widgets/home/assessment_card.dart';

class AnxietyAssessment extends StatelessWidget {
  const AnxietyAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsManager.mainColor,
      ),
      body: const AnxietyAssessmentBody() ,
    );
  }
}

class AnxietyAssessmentBody extends StatefulWidget {
  const AnxietyAssessmentBody({super.key});

  @override
  State<AnxietyAssessmentBody> createState() => _AnxietyAssessmentBodyState();
}

class _AnxietyAssessmentBodyState extends State<AnxietyAssessmentBody> {
  int currentIndex = 0;

  final List<AssessmentQuestionModel> questions = [
    AssessmentQuestionModel(
      question: 'Do you feel nervous or anxious frequently?',
      title1: 'Never',
      title2: 'Occasionally',
      title3: 'Often',
      title4: 'Almost constantly'
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
          text: 'Anxiety Assessment',
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