import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/presentation/controllers/assessment/assessment_cubit.dart';
import 'package:health_assistant/presentation/controllers/mental_health_chat/mental_health_chat_cubit.dart';
import 'package:health_assistant/presentation/view/widgets/home/mood_assessment_bloc_builder.dart';

class MoodAssessment extends StatelessWidget {
  final InMemoryChatController chatController;
  final VoidCallback onFinish;
  final MentalHealthChatCubit mentalHealthChatCubit;
  final String? sessionId;

  const MoodAssessment(
      {super.key,
      required this.chatController,
      required this.onFinish,
      required this.mentalHealthChatCubit, this.sessionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AssessmentCubit>()..fetchAssessments(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsManager.mainColor,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: MoodAssessmentBlocBuilder(
            sessionId: sessionId,
            chatController: chatController,
            onFinish: onFinish,
            mentalHealthChatCubit: mentalHealthChatCubit,
          )),
    );
  }
}
