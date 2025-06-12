class GenerateNutritionPlanResponseModel {
  final String response;
  final String status;

  GenerateNutritionPlanResponseModel({
    required this.response,
    required this.status,
  });

  factory GenerateNutritionPlanResponseModel.fromJson(Map<String, dynamic> json) {
    return GenerateNutritionPlanResponseModel(
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