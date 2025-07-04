import 'package:flutter/material.dart';
import 'package:health_assistant/presentation/view/widgets/home/chat_history_bloc_builder.dart';

class AppDrawer extends StatelessWidget {
  final String userId;
  const AppDrawer({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ChatHistoryBlocBuilder(userId: userId),
    );
  }
}
