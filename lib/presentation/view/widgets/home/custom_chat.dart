import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class CustomChat extends StatefulWidget {
  const CustomChat({super.key});

  @override
  State<CustomChat> createState() => _CustomChatState();
}

class _CustomChatState extends State<CustomChat> {
  final _chatController = InMemoryChatController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Chat(
        currentUserId: 'user1',
        chatController: _chatController,
        resolveUser: (id) async => User(id: id, name: 'Health Assistant'),
        builders: Builders(
          emptyChatListBuilder: (context) => const SizedBox.shrink(),
        ),
        onMessageSend: (text) {
          _chatController.insertMessage(
            TextMessage(
              id: '${Random().nextInt(1000)}',
              authorId: 'user1',
              createdAt: DateTime.now().toUtc(),
              text: text,
            ),
          );
        },
      );
  }
}