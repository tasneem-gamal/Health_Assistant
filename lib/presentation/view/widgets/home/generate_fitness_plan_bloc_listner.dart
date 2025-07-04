import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/presentation/controllers/generate_fitness_plan/generate_fitness_plan_cubit.dart';

class GenerateFitnessPlanBlocListner extends StatelessWidget {
  const GenerateFitnessPlanBlocListner({super.key, required this.chatController});

  final InMemoryChatController chatController;
  

  @override
  Widget build(BuildContext context) {
    return BlocListener<GenerateFitnessPlanCubit, GenerateFitnessPlanState>(
      listener: (context, state) {
        if (state is GenerateFitnessPlanLoading) {
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
        if (state is GenerateFitnessPlanSuccess) {
          final response = state.generateFitnessPlanResponseModel.response;
          final now = DateTime.now().toUtc();
          final botTextMessage = TextMessage(
            id: now.millisecondsSinceEpoch.toString(),
            authorId: 'HealthAssistant',
            createdAt: now,
            text: response,
          );
          chatController.insertMessage(botTextMessage);
        }
        if (state is GenerateFitnessPlanFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errMessage}')),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}