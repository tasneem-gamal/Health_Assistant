class MentalHealthRequestModel {
  final String message;
  final String userId;
  final String sessionId;
  final List<Map<String, String>> history;
  final bool fromAssessment;
  final String? historyId;

  MentalHealthRequestModel({
    required this.userId,
    required this.message,
    required this.sessionId,
    required this.history,
    this.fromAssessment = false,
    this.historyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sessionId': sessionId,
      'history': history,
      'user_id': userId,
    };
  }
}
