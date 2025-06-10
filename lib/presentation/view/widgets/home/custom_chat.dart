import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/spacing.dart';

class CustomChat extends StatefulWidget {
  const CustomChat({super.key, this.onFocusChanged, required this.chatController});
  final ValueChanged<bool>? onFocusChanged;
  final InMemoryChatController chatController;

  @override
  State<CustomChat> createState() => _CustomChatState();
}

class _CustomChatState extends State<CustomChat> {
  
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
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
      chatController: widget.chatController, 
      resolveUser: (id) async => User(id: id, name: 'Health Assistant'),
      builders: Builders(
          emptyChatListBuilder: (context) => const SizedBox.shrink(),
          composerBuilder: (context) {
            final controller = TextEditingController();
            return SendField(controller: controller, focusNode: _focusNode, chatController: widget.chatController);
          }),
      onMessageSend: (text) {
        widget.chatController.insertMessage(
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

class SendField extends StatefulWidget {
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
                focusNode: widget._focusNode,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  prefixIcon: IconButton(
                    onPressed: (){
                      if (_overlayEntry == null) {
                        _showOverlay();
                      } else {
                        _removeOverlay();
                      }
                    },
                    icon: const Icon(Icons.attach_file)
                  ),
                  border: const OutlineInputBorder(
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
                final text = widget.controller.text.trim();
                if (text.isNotEmpty) {
                  widget._chatController.insertMessage(
                    TextMessage(
                      id: '${Random().nextInt(1000)}',
                      authorId: 'user1',
                      createdAt: DateTime.now().toUtc(),
                      text: text,
                    ),
                  );
                  widget.controller.clear();
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

  void _showOverlay() {
    final overlay = Overlay.of(context);

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);

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
                      onTap: () {
                        _removeOverlay();
                      },
                    ),
                    const Divider(thickness: 1, color: ColorsManager.moreLightGray,),
                    ListTile(
                      leading: const Icon(Icons.upload),
                      title: const Text('Attach File'),
                      onTap: () {
                        _removeOverlay();
                      },
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
