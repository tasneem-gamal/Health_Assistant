class GeneralChatResponseModel {
  final String response;
  final String status;

  GeneralChatResponseModel({
    required this.response,
    required this.status,
  });

  factory GeneralChatResponseModel.fromJson(Map<String, dynamic> json) {
    return GeneralChatResponseModel(
      response: json['response'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response': response,
      'status': status,
    };
  }
}
