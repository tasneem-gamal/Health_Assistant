import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHsitoryModel {
  final String id;
  final String message;
  final String response;
  final String messageType;
  final String sessionId;
  final DateTime timestamp;
  final String userId;
  final EmotionData emotionData;

  ChatHsitoryModel({
    required this.id,
    required this.message,
    required this.response,
    required this.messageType,
    required this.sessionId,
    required this.timestamp,
    required this.userId,
    required this.emotionData,
  });

  factory ChatHsitoryModel.fromMap(Map<String, dynamic> map) {
    return ChatHsitoryModel(
      id: map['id'] ?? '',
      message: map['message'] ?? '',
      response: map['response'] ?? '',
      messageType: map['message_type'] ?? '',
      sessionId: map['session_id'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      userId: map['user_id'] ?? '',
      emotionData: EmotionData.fromMap(map['emotion_data'] ?? {}),
    );
  }
}

class EmotionData {
  final Emotions emotions;
  final String urgency;

  EmotionData({
    required this.emotions,
    required this.urgency,
  });

  factory EmotionData.fromMap(Map<String, dynamic> map) {
    return EmotionData(
      emotions: Emotions.fromMap(map['emotions'] ?? {}),
      urgency: map['urgency'] ?? '',
    );
  }
}

class Emotions {
  final double joy;
  final double sadness;
  final double sentiment;

  Emotions({
    required this.joy,
    required this.sadness,
    required this.sentiment,
  });

  factory Emotions.fromMap(Map<String, dynamic> map) {
    return Emotions(
      joy: (map['joy'] ?? 0).toDouble(),
      sadness: (map['sadness'] ?? 0).toDouble(),
      sentiment: (map['sentiment'] ?? 0).toDouble(),
    );
  }
}
