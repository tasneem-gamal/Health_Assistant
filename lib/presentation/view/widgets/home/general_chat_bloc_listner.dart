import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/presentation/controllers/general_chat/general_chat_cubit.dart';

class GeneralChatBlocListner extends StatelessWidget {
  const GeneralChatBlocListner({super.key, required this.chatController});

  final InMemoryChatController chatController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GeneralChatCubit, GeneralChatState>(
      listener: (context, state) {
        if (state is GeneralChatLoading) {
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
        if (state is GeneralChatSuccess) {
          final response = state.generalChatResponseModel.response;
          final now = DateTime.now().toUtc();
          final botTextMessage = TextMessage(
            id: now.millisecondsSinceEpoch.toString(),
            authorId: 'HealthAssistant',
            createdAt: now,
            text: response,
          );
          chatController.insertMessage(botTextMessage);
        }
        if (state is GeneralChatFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errMessage}')),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}