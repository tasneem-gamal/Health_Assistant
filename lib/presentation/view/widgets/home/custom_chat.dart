import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/data/models/general_chat/general_chat_request_model.dart';
import 'package:health_assistant/presentation/controllers/general_chat/general_chat_cubit.dart';
import 'package:health_assistant/presentation/view/widgets/home/simple_markdown_text_message.dart';

class CustomChat extends StatefulWidget {
  const CustomChat({
    super.key,
    this.onFocusChanged,
    required this.chatController,
  });

  final ValueChanged<bool>? onFocusChanged;
  final InMemoryChatController chatController;

  @override
  State<CustomChat> createState() => _CustomChatState();
}

class _CustomChatState extends State<CustomChat> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  late GeneralChatCubit chatCubit;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      widget.onFocusChanged?.call(_focusNode.hasFocus);
    });
    chatCubit = context.read<GeneralChatCubit>();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final userMessage = TextMessage(
      id: '${Random().nextInt(1000)}',
      authorId: 'user1',
      createdAt: DateTime.now().toUtc(),
      text: text,
    );
    widget.chatController.insertMessage(userMessage);
    _controller.clear();

    final history = widget.chatController.messages
        .where((msg) =>
            msg is TextMessage &&
            (msg.authorId == 'user1' || msg.authorId == 'HealthAssistant'))
        .map((msg) {
      final textMsg = msg as TextMessage;
      return [
        textMsg.authorId == 'user1' ? 'user' : 'assistant',
        textMsg.text,
      ];
    }).toList();

    final requestModel = GeneralChatRequestModel(
      message: text,
      history: history,
    );

    chatCubit.generalChat(requestModel);
  }

  @override
  Widget build(BuildContext context) {
    return Chat(
      currentUserId: 'user1',
      chatController: widget.chatController,
      resolveUser: (id) async => User(id: id, name: 'Health Assistant'),
      builders: Builders(
        textMessageBuilder: (context, message, index) {
          final isBot = message.authorId == 'HealthAssistant';
          if (isBot) {
            return CustomMarkdownTextMessage(message: message);
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: ColorsManager.mainColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          );
        },
        emptyChatListBuilder: (context) => const SizedBox.shrink(),
        composerBuilder: (context) {
          return SendField(
            controller: _controller,
            focusNode: _focusNode,
            onSendPressed: _sendMessage,
          );
        },
      ),
    );
  }
}

class SendField extends StatefulWidget {
  const SendField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSendPressed,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSendPressed;

  @override
  State<SendField> createState() => _SendFieldState();
}

class _SendFieldState extends State<SendField> {
  OverlayEntry? _overlayEntry;

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
                controller: widget.controller,
                focusNode: widget.focusNode,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Type your message...',
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {
                      if (_overlayEntry == null) {
                        _showOverlay();
                      } else {
                        _removeOverlay();
                      }
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(color: ColorsManager.grayShade),
                  ),
                ),
              ),
            ),
            horizontalSpace(context, 10),
            GestureDetector(
              onTap: widget.onSendPressed,
              child: const CircleAvatar(
                radius: 24,
                backgroundColor: ColorsManager.mainColor,
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _removeOverlay,
        child: Stack(
          children: [
            Positioned(
              left: offset.dx + 24,
              top: offset.dy + MediaQuery.of(context).size.height * 0.68,
              width: 200,
              child: Material(
                color: ColorsManager.grayShade,
                elevation: 1,
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.photo_camera),
                      title: const Text('Scan Photo'),
                      onTap: _removeOverlay,
                    ),
                    const Divider(
                      thickness: 1,
                      color: ColorsManager.moreLightGray,
                    ),
                    ListTile(
                      leading: const Icon(Icons.upload),
                      title: const Text('Attach File'),
                      onTap: _removeOverlay,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
