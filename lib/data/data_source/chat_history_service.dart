import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_assistant/data/models/home/chat_history_model.dart';



class ChatHistoryService {
  final FirebaseFirestore firestore;

  ChatHistoryService({required this.firestore});

  Future<List<ChatHistoryModel>> getUserChatHistory(String userId) async {
    final snapshot = await firestore
        .collection('chat_history')
        .where('user_id', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final model = ChatHistoryModel.fromMap(doc.data());
      model.id = doc.id;
      return model;
    }).toList();
  }

  Future<void> deleteChatById(String docId) async {
    await firestore.collection('chat_history').doc(docId).delete();
  }

  Future<void> clearAllChatsForUser(String userId) async {
    final snapshot = await firestore
        .collection('chat_history')
        .where('user_id', isEqualTo: userId)
        .get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  
}
