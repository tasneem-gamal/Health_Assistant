class AnalyzeSymptomsResponseModel {
  final String response;
  final String status;

  AnalyzeSymptomsResponseModel({
    required this.response,
    required this.status,
  });

  factory AnalyzeSymptomsResponseModel.fromJson(Map<String, dynamic> json) {
    return AnalyzeSymptomsResponseModel(
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
