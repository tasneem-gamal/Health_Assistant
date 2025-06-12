import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/presentation/controllers/generate_nutrition_plan/generate_nutrition_plan_cubit.dart';

class NutritionPlanBlocListner extends StatelessWidget {
  const NutritionPlanBlocListner({super.key, required this.chatController});

  final InMemoryChatController chatController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GenerateNutritionPlanCubit, GenerateNutritionPlanState>(
      listener: (context, state) {
        if (state is GenerateNutritionPlanLoading) {
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
        if (state is GenerateNutritionPlanSuccess) {
          final response = state.generateNutritionPlanResponseModel.response;
          final now = DateTime.now().toUtc();
          final botTextMessage = TextMessage(
            id: now.millisecondsSinceEpoch.toString(),
            authorId: 'HealthAssistant',
            createdAt: now,
            text: response,
          );
          chatController.insertMessage(botTextMessage);
        }
        if (state is GenerateNutritionPlanFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errMessage}')),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}