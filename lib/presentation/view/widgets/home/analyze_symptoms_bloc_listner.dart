import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/presentation/controllers/analyze_symptoms/analyze_symptoms_cubit.dart';

class AnalyzeSymptomsBlocListner extends StatelessWidget {
  final InMemoryChatController chatController;

  const AnalyzeSymptomsBlocListner({
    super.key,
    required this.chatController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnalyzeSymptomsCubit, AnalyzeSymptomsState>(
      listener: (context, state) {
        if (state is AnalyzeSymptomsLoading) {
          final thinkingMessage = TextMessage(
            id: 'thinking_message',
            authorId: 'HealthAssistant',
            createdAt: DateTime.now().toUtc(),
            text: 'Thinking...',
          );
          chatController.insertMessage(thinkingMessage);
        } else {
          chatController.removeMessageById('thinking_message');
        }
        if (state is AnalyzeSymptomsSuccess) {
          final response = state.analyzeSymptomsResponseModel.response;
          final now = DateTime.now().toUtc();
          final botTextMessage = TextMessage(
            id: now.millisecondsSinceEpoch.toString(),
            authorId: 'HealthAssistant',
            createdAt: now,
            text: response,
          );
          chatController.insertMessage(botTextMessage);
        }
        if (state is AnalyzeSymptomsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errMessage}')),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
