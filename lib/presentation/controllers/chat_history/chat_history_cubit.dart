import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/data/models/home/chat_hsitory_model.dart';
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
}