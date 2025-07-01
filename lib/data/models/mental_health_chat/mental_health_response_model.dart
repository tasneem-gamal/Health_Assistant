class MentalHealthResponseModel {
  final String contextSummary;
  final EmotionData emotionData;
  final String response;
  final String status;

  MentalHealthResponseModel({
    required this.contextSummary,
    required this.emotionData,
    required this.response,
    required this.status,
  });

  factory MentalHealthResponseModel.fromJson(Map<String, dynamic> json) {
    return MentalHealthResponseModel(
      contextSummary: json['contextSummary'],
      emotionData: EmotionData.fromMap(json['emotionData']),
      response: json['response'],
      status: json['status'],
    );
  }
}

class EmotionData {
  final double joy;
  final double sadness;
  final double sentiment;
  final String urgency;

  EmotionData({
    required this.joy,
    required this.sadness,
    required this.sentiment,
    required this.urgency,
  });

  factory EmotionData.fromMap(Map<String, dynamic> map) {
    return EmotionData(
      joy: map['emotions']['joy']?.toDouble() ?? 0.0,
      sadness: map['emotions']['sadness']?.toDouble() ?? 0.0,
      sentiment: map['emotions']['sentiment']?.toDouble() ?? 0.0,
      urgency: map['emotions']['urgency'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'emotions': {
        'joy': joy,
        'sadness': sadness,
        'sentiment': sentiment,
        'urgency': urgency,
      },
    };
  }
}