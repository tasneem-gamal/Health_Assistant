import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_response_model.dart';
class ChatHistoryModel {
  String? id;
  final String message;
  final String response;
  final String sessionId;
  final String messageType;
  final String userId;
  final DateTime timestamp;
  final EmotionData? emotionData;

  ChatHistoryModel({
    this.id,
    required this.message,
    required this.response,
    required this.sessionId,
    required this.messageType,
    required this.userId,
    required this.timestamp,
    this.emotionData,
  });

  factory ChatHistoryModel.fromMap(Map<String, dynamic> map) {
    return ChatHistoryModel(
      message: map['message'] ?? '',
      response: map['response'] ?? '',
      sessionId: map['session_id'] ?? '',
      messageType: map['message_type'] ?? '',
      userId: map['user_id'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      emotionData: map['emotion_data'] != null
          ? EmotionData.fromMap(map['emotion_data'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'response': response,
      'session_id': sessionId,
      'message_type': messageType,
      'user_id': userId,
      'timestamp': timestamp,
      'emotion_data': emotionData,
    };
  }
}
