
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/presentation/controllers/assessment/assessment_cubit.dart';
import 'package:health_assistant/presentation/controllers/mental_health_chat/mental_health_chat_cubit.dart';
import 'package:health_assistant/presentation/view/widgets/home/anxiety_assessment_bloc_builder.dart';

class AnxietyAssessment extends StatelessWidget {
  final InMemoryChatController chatController;
  final VoidCallback onFinish;
  final MentalHealthChatCubit mentalHealthChatCubit;

  const AnxietyAssessment(
      {super.key,
      required this.chatController,
      required this.onFinish,
      required this.mentalHealthChatCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AssessmentCubit>()..fetchAssessments(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsManager.mainColor,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: AnxietyAssessmentBlocBuilder(
            chatController: chatController,
            onFinish: onFinish,
            mentalHealthChatCubit: mentalHealthChatCubit,
          )),
    );
  }
}
