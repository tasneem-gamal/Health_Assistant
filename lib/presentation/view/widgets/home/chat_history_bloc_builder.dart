import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/chat_history_shimmer.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/data/models/home/chat_hsitory_model.dart';
import 'package:health_assistant/presentation/controllers/chat_history/chat_history_cubit.dart';
import 'package:health_assistant/presentation/view/screens/home/health_check_chat.dart';
import 'package:health_assistant/presentation/view/screens/home/mental_health_chat.dart';

class ChatHistoryBlocBuilder extends StatelessWidget {
  final String userId;
  const ChatHistoryBlocBuilder({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatHistoryCubit>()..fetchChatHistory(userId),
      child: BlocBuilder<ChatHistoryCubit, ChatHistoryState>(
        builder: (context, state) {
          if (state is ChatHistoryLoading) {
            return const ChatHistoryShimmer();
          } else if (state is ChatHistoryLoaded) {
            return HistoryList(
              chats: state.chatList,
            );
          } else if (state is ChatHistoryError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({
    super.key,
    required this.chats,
  });
  final List<ChatHistoryModel> chats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Chat List', style: CustomTextStyles.font16LightGrayBold(context)),
          verticalSpace(context, 24),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  onTap: () {
                    context.pop();
                    if (chat.messageType == 'mental_health') {
                        context.push(MentalHealthChat(historyId: chat.id, hideOptionsAtStart: true));
                      } else if (chat.messageType == 'general') {
                        context.push(const HealthCheckChat());
                      }
                  },
                  title: Text(
                    chat.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.font12BlackMedium(context),
                  ),
                  subtitle: Text(
                    DateFormat('dd MMM').format(chat.timestamp),
                    style: CustomTextStyles.font12MainColorMedium(context),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context
                          .read<ChatHistoryCubit>()
                          .deleteChat(chat.id ?? '', chat.userId);
                    },
                  ),
                );
              },
            ),
          ),
          CustomAppButton(
            onPressed: chats.isEmpty
                ? null
                : () {
                    context
                        .read<ChatHistoryCubit>()
                        .clearAllChats(chats.first.userId);
                  },
            backgroundColor: Colors.red,
            btnText: 'Clear all',
          ),
        ],
      ),
    );
  }
}
