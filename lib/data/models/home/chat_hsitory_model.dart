import 'package:cloud_firestore/cloud_firestore.dart';
class ChatHsitoryModel {
  String? id;
  final String message;
  final String response;
  final String sessionId;
  final DateTime timestamp;

  ChatHsitoryModel({
    this.id,
    required this.message,
    required this.response,
    required this.sessionId,
    required this.timestamp,
  });

  factory ChatHsitoryModel.fromMap(Map<String, dynamic> map) {
    return ChatHsitoryModel(
      message: map['message'] ?? '',
      response: map['response'] ?? '', 
      sessionId: map['session_id'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'response': response, 
      'session_id': sessionId,
      'timestamp': timestamp,
    };
  }
}
