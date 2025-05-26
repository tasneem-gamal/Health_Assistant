import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/spacing.dart';

class CustomChat extends StatefulWidget {
  const CustomChat({super.key, this.onFocusChanged});
  final ValueChanged<bool>? onFocusChanged;

  @override
  State<CustomChat> createState() => _CustomChatState();
}

class _CustomChatState extends State<CustomChat> {
  final _chatController = InMemoryChatController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      widget.onFocusChanged?.call(_focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Chat(
      currentUserId: 'user1',
      chatController: _chatController,
      resolveUser: (id) async => User(id: id, name: 'Health Assistant'),
      builders: Builders(
          emptyChatListBuilder: (context) => const SizedBox.shrink(),
          composerBuilder: (context) {
            final controller = TextEditingController();
            return SendField(controller: controller, focusNode: _focusNode, chatController: _chatController);
          }),
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

class SendField extends StatelessWidget {
  const SendField({
    super.key,
    required this.controller,
    required FocusNode focusNode,
    required InMemoryChatController chatController,
  }) : _focusNode = focusNode, _chatController = chatController;

  final TextEditingController controller;
  final FocusNode _focusNode;
  final InMemoryChatController _chatController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  hintText: 'Type your message...',
                  prefixIcon: Icon(Icons.attach_file),
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(40)),
                      borderSide:
                          BorderSide(color: ColorsManager.grayShade)),
                ),
              ),
            ),
            horizontalSpace(context, 10),
            GestureDetector(
              onTap: () {
                final text = controller.text.trim();
                if (text.isNotEmpty) {
                  _chatController.insertMessage(
                    TextMessage(
                      id: '${Random().nextInt(1000)}',
                      authorId: 'user1',
                      createdAt: DateTime.now().toUtc(),
                      text: text,
                    ),
                  );
                  controller.clear();
                }
              },
              child: const CircleAvatar(
                radius: 24,
                backgroundColor: ColorsManager.mainColor,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
