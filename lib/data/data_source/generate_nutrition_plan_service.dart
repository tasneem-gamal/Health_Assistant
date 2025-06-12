import 'package:dio/dio.dart';
import 'package:health_assistant/core/networking/api_constants.dart';
import 'package:health_assistant/core/networking/dio_factory.dart';
import 'package:health_assistant/data/models/generate_nutrition_plan/generate_nutrition_plan_request_model.dart';
import 'package:health_assistant/data/models/generate_nutrition_plan/generate_nutrition_plan_response_model.dart';

class GenerateNutritionPlanService {
  late Dio dio;

  GenerateNutritionPlanService(){
    dio = DioFactory.getDio();
  }

  Future<GenerateNutritionPlanResponseModel> generateNutritionPlanService(
    GenerateNutritionPlanRequestModel generateNutritionPlanRequestModel) async{
    final response = await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.generateNutritionPlan}',
      data: generateNutritionPlanRequestModel.toJson()
    );
    return GenerateNutritionPlanResponseModel.fromJson(response.data);
  }
}