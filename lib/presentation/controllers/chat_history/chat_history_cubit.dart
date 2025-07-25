import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/data/models/home/chat_history_model.dart';
import 'package:health_assistant/data/repo/chat_history_repo.dart';

part 'chat_history_state.dart';

class ChatHistoryCubit extends Cubit<ChatHistoryState> {
  final ChatHistoryRepo repository;

  ChatHistoryCubit(this.repository) : super(ChatHistoryInitial());

  Future<void> fetchChatHistory(String userId) async {
    emit(ChatHistoryLoading());
    try {
      final chatList = await repository.getChatHistory(userId);
      emit(ChatHistoryLoaded(chatList));
    } catch (e) {
      emit(ChatHistoryError(e.toString()));
    }
  }

  Future<void> deleteChat(String docId, String userId) async {
  emit(ChatHistoryLoading());
  await repository.deleteChat(docId);
  fetchChatHistory(userId);
}

Future<void> clearAllChats(String userId) async {
  emit(ChatHistoryLoading());
  await repository.clearAllChats(userId);
  fetchChatHistory(userId);
}

}
