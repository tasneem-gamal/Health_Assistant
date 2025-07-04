import 'package:health_assistant/data/data_source/chat_history_service.dart';
import 'package:health_assistant/data/models/home/chat_history_model.dart';


class ChatHistoryRepo {
  final ChatHistoryService service;

  ChatHistoryRepo(this.service);

  Future<List<ChatHistoryModel>> getChatHistory(String userId) {
    return service.getUserChatHistory(userId);
  }

  Future<void> deleteChat(String docId) {
    return service.deleteChatById(docId);
  }

  Future<void> clearAllChats(String userId) {
    return service.clearAllChatsForUser(userId);
  }

}
