part of 'chat_history_cubit.dart';

abstract class ChatHistoryState {}

class ChatHistoryInitial extends ChatHistoryState {}

class ChatHistoryLoading extends ChatHistoryState {}

class ChatHistoryLoaded extends ChatHistoryState {
  final List<ChatHsitoryModel> chatList;
  ChatHistoryLoaded(this.chatList);
}

class ChatHistoryError extends ChatHistoryState {
  final String message;
  ChatHistoryError(this.message);
}