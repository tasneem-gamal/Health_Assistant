import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_curved_container.dart';
import 'package:health_assistant/data/models/assessments/assessment_model.dart';
import 'package:health_assistant/data/models/home/assessment_question_model.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_request_model.dart';
import 'package:health_assistant/presentation/controllers/assessment/assessment_cubit.dart';
import 'package:health_assistant/presentation/controllers/mental_health_chat/mental_health_chat_cubit.dart';
import 'package:health_assistant/presentation/view/widgets/home/assessment_card.dart';


class AdjustmentAssessmentBlocBuilder extends StatefulWidget {
  final InMemoryChatController chatController;
  final VoidCallback onFinish;
  final MentalHealthChatCubit mentalHealthChatCubit;
  final String? sessionId;

  const AdjustmentAssessmentBlocBuilder({super.key, required this.chatController, required this.onFinish, required this.mentalHealthChatCubit, this.sessionId});

  @override
  State<AdjustmentAssessmentBlocBuilder> createState() => _AdjustmentAssessmentBlocBuilderState();
}

class _AdjustmentAssessmentBlocBuilderState extends State<AdjustmentAssessmentBlocBuilder> {
  int currentIndex = 0;
  List<int?> selectedAnswers = [];
  AssessmentModel? moodAssessment;
  List<QuestionModel> questions = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentCubit, AssessmentState>(
      builder: (context, state) {
        if (state is AssessmentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AssessmentSuccess) {

          final anxietyAssessments = state.assessments
              .where((e) => e.assessmentTitle
                  .contains("Adjustment Assessment"))
              .toList();

          if (anxietyAssessments.isEmpty) {
            return const Center(child: Text("Adjustment Assessment not found"));
          }

          if (moodAssessment == null) {
            moodAssessment = anxietyAssessments.first;
            questions = moodAssessment!.questions;
            selectedAnswers = List<int?>.filled(questions.length, null);
          }

          return Column(
            children: [
              CustomCurvedContainer(
                text: moodAssessment!.assessmentTitle,
                style: _customTextStyle(context),
              ),
              verticalSpace(context, 30),
              AssessmentCard(
                assessmentQuestionModel: AssessmentQuestionModel(
                  question: questions[currentIndex].text,
                  title1: moodAssessment!.scoring.scale[0].label,
                  title2: moodAssessment!.scoring.scale[1].label,
                  title3: moodAssessment!.scoring.scale[2].label,
                  title4: moodAssessment!.scoring.scale[3].label,
                ),
                selectedAnswer: selectedAnswers[currentIndex],
                onSelectAnswer: (index) {
                  setState(() {
                    selectedAnswers[currentIndex] = index;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentIndex > 0)
                      CustomAppButton(
                        onPressed: () {
                          setState(() => currentIndex--);
                        },
                        buttonWidth: 100,
                        btnText: 'Previous',
                      )
                    else
                      horizontalSpace(context, 50),
                    CustomAppButton(
                      onPressed: () {
                        if (selectedAnswers[currentIndex] == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please answer the question before continuing.')),
                          );
                          return;
                        }

                        if (currentIndex == questions.length - 1) {
                          _sendAnswersToChat();
                        } else {
                          setState(() => currentIndex++);
                        }
                      },
                      buttonWidth: 90,
                      btnText: currentIndex == questions.length - 1 ? 'Finish' : 'Next',
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is AssessmentFailure) {
          return Center(child: Text("Error: ${state.errMessage}"));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void _sendAnswersToChat() {
    final List<String> messageLines = [];

    for (int i = 0; i < questions.length; i++) {
      final answerIndex = selectedAnswers[i];
      if (answerIndex != null) {
        final answer = moodAssessment!.scoring.scale[answerIndex].label;
        messageLines.add("Q: ${questions[i].text}\nA: $answer");
      }
    }

    final message = TextMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorId: 'user1',
      createdAt: DateTime.now().toUtc(),
      text: messageLines.join('\n\n'),
    );

    widget.chatController.insertMessage(message);

    final history = widget.chatController.messages.map((msg) {
      return {
        msg.authorId == 'user1' ? 'user' : 'assistant': msg.authorId,
      };
    }).toList();

    final request = MentalHealthRequestModel(
      message: message.text,
      sessionId: widget.sessionId ?? '',
      history: history,
      fromAssessment: true,
      userId: FirebaseAuth.instance.currentUser!.uid,
    );

    widget.mentalHealthChatCubit.mentalHealthChat(request);


    widget.onFinish();

    context.pop();
  }


  TextStyle _customTextStyle(BuildContext context) {
    return CustomTextStyles.font24WhiteMedium(context).copyWith(
      foreground: Paint()
        ..shader = const LinearGradient(
          colors: <Color>[Colors.white, ColorsManager.mainColorLight],
        ).createShader(const Rect.fromLTWH(200.0, 0.0, 50.0, 0.0)),
    );
  }
}
