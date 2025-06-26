import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/presentation/controllers/chat_history/chat_history_cubit.dart';
import 'package:health_assistant/presentation/view/screens/home/mental_health_chat.dart';

class AppDrawer extends StatelessWidget {
  final String userId;
  const AppDrawer({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocProvider(
        create: (context) =>
            getIt<ChatHistoryCubit>()..fetchChatHistory(userId),
        child: BlocBuilder<ChatHistoryCubit, ChatHistoryState>(
          builder: (context, state) {
            if (state is ChatHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatHistoryLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Chat List', style: CustomTextStyles.font16LightGrayBold(context)),
                    verticalSpace(context, 24),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.chatList.length,
                        itemBuilder: (context, index) {
                          final chat = state.chatList[index];
                          return ListTile(
                            onTap: (){
                              //context.push(MentalHealthChat(historyId: chat.id));
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
                            trailing: const Icon(Icons.delete),
                          );
                        },
                      ),
                    ),
                    CustomAppButton(
                      onPressed: () {},
                      backgroundColor: Colors.red,
                      btnText: 'Clear all',
                    ),
                  ],
                ),
              );
            } else if (state is ChatHistoryError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
