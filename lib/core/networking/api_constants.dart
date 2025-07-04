import 'package:health_assistant/core/utils/shared_preference_helper.dart';

class ApiConstants {
  //static const String baseUrl = "https://potential-space-sniffle-r445q66q564jcpr5g-5002.app.github.dev/";
  static const String _defaultBaseUrl = "http://127.0.0.1:5002/";

  static Future<String> get baseUrl async {
    final savedBaseUrl = await SharedPreferenceHelper.getBaseUrl();
    return savedBaseUrl ?? _defaultBaseUrl;
  }

  static const String analyzeSymptoms = "analyze-symptoms";
  static const String generateFitnessPlan = "generate-fitness-plan";
  static const String generateNutritionPlan = "generate-nutrition-plan";
  static const String generalChat = "send-message";
  static const String mentalHealthChat = "send-mental-health-message";
}
