class GeneralChatRequestModel {
  final String userId; 
  final String message;
  final List<List<String>> history;

  GeneralChatRequestModel({
    required this.userId, 
    required this.message,
    required this.history,
  });

  factory GeneralChatRequestModel.fromJson(Map<String, dynamic> json) {
    return GeneralChatRequestModel(
      userId: json['user_id'], 
      message: json['message'],
      history: List<List<String>>.from(
        (json['history'] as List).map(
          (pair) => List<String>.from(pair),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId, 
      'message': message,
      'history': history,
    };
  }
}
