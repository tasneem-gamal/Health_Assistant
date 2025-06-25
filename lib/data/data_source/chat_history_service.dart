import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_assistant/data/models/home/chat_hsitory_model.dart';


class ChatHistoryService {
  final FirebaseFirestore firestore;

  ChatHistoryService({required this.firestore});

  Future<List<ChatHsitoryModel>> getUserChatHistory(String userId) async {
    final snapshot = await firestore
        .collection('chat_history')
        .where('user_id', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => ChatHsitoryModel.fromMap(doc.data())).toList();
  }
}