class GeneralChatRequestModel {
  final String message;
  final List<List<String>> history;

  GeneralChatRequestModel({
    required this.message,
    required this.history,
  });

  factory GeneralChatRequestModel.fromJson(Map<String, dynamic> json) {
    return GeneralChatRequestModel(
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
      'message': message,
      'history': history,
    };
  }
}
