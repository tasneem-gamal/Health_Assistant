import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/presentation/controllers/mental_health_chat/mental_health_chat_cubit.dart';

class MentalHealthChatBlocListner extends StatelessWidget {
  const MentalHealthChatBlocListner({
    super.key,
    required this.chatController,
    required this.onMoodAnalyzed, required this.hideOverlays,
  });

  final InMemoryChatController chatController;
  final VoidCallback hideOverlays;
  final void Function(double sentiment, String mood) onMoodAnalyzed;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MentalHealthChatCubit, MentalHealthChatState>(
      listener: (context, state) {
        if (state is MentalHealthChatLoading) {
          hideOverlays();
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

        if (state is MentalHealthChatSuccess) {
          final response = state.mentalHealthResponseModel.response;

          final emotionData = state.mentalHealthResponseModel.emotionData;
          final sentiment = emotionData.sentiment;
          final mood = emotionData.urgency;


          if (state.fromAssessment) {
            onMoodAnalyzed(sentiment, mood); 
          }

          final now = DateTime.now().toUtc();
          final botTextMessage = TextMessage(
            id: now.millisecondsSinceEpoch.toString(),
            authorId: 'HealthAssistant',
            createdAt: now,
            text: response,
          );

          chatController.insertMessage(botTextMessage);
        }

        if (state is MentalHealthChatFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errMessage}')),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
