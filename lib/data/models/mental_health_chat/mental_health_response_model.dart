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
      emotionData: EmotionData.fromJson(json['emotionData']),
      response: json['response'],
      status: json['status'],
    );
  }
}

class EmotionData {
  final Emotions emotions;
  final double sentiment;
  final String urgency;

  EmotionData({
    required this.emotions,
    required this.sentiment,
    required this.urgency,
  });

  factory EmotionData.fromJson(Map<String, dynamic> json) {
    return EmotionData(
      emotions: Emotions.fromJson(json['emotions']),
      sentiment: (json['sentiment'] as num).toDouble(),
      urgency: json['urgency'],
    );
  }
}

class Emotions {
  final double joy;
  final double sadness;

  Emotions({
    required this.joy,
    required this.sadness,
  });

  factory Emotions.fromJson(Map<String, dynamic> json) {
    return Emotions(
      joy: (json['joy'] as num).toDouble(),
      sadness: (json['sadness'] as num).toDouble(),
    );
  }
}
