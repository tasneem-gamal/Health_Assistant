import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_curved_container.dart';
import 'package:health_assistant/data/models/home/assessment_question_model.dart';
import 'package:health_assistant/presentation/view/widgets/home/assessment_card.dart';

class MoodAssessment extends StatelessWidget {
  const MoodAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsManager.mainColor,
      ),
      body: const MoodAssessmentBody(),
    );
  }
}

class MoodAssessmentBody extends StatefulWidget {
  const MoodAssessmentBody({super.key});

  @override
  State<MoodAssessmentBody> createState() => _MoodAssessmentBodyState();
}

class _MoodAssessmentBodyState extends State<MoodAssessmentBody> {
  int currentIndex = 0;

  final List<AssessmentQuestionModel> questions = [
    AssessmentQuestionModel(
      question: 'How often do you feel sad or down?',
    ),
    AssessmentQuestionModel(
      question: 'Have you lost interest in activities you used to enjoy?',
      image1: 'assets/images/nochange.png',
      title1: 'No change',
      image2: 'assets/images/slight.png',
      title2: 'Slight decrease',
      image3: 'assets/images/decrease.png',
      title3: 'Significant decrease',
      image4: 'assets/images/loss.png',
      title4: 'Complete loss of interest'
    ),
    AssessmentQuestionModel(
      question: 'Do you feel fatigued or have little energy?',
    ),
    AssessmentQuestionModel(
      question: 'Do you experience feelings of worthlessness or excessive guilt?',
    ),
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
          text: 'Mood Assessment',
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

