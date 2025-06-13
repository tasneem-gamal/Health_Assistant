class MentalHealthRequestModel {
  final String message;
  final String sessionId;
  final List<Map<String, String>> history;

  MentalHealthRequestModel({
    required this.message,
    required this.sessionId,
    required this.history,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sessionId': sessionId,
      'history': history,
    };
  }
}
