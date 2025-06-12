class GenerateFitnessPlanResponseModel {
  final String response;
  final String status;

  GenerateFitnessPlanResponseModel({
    required this.response,
    required this.status,
  });

  factory GenerateFitnessPlanResponseModel.fromJson(Map<String, dynamic> json) {
    return GenerateFitnessPlanResponseModel(
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
