import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:health_assistant/core/networking/api_error_handler.dart';
import 'package:health_assistant/data/data_source/generate_nutrition_plan_service.dart';
import 'package:health_assistant/data/models/generate_nutrition_plan/generate_nutrition_plan_request_model.dart';
import 'package:health_assistant/data/models/generate_nutrition_plan/generate_nutrition_plan_response_model.dart';

class GenerateNutritionPlanRepo {
  final GenerateNutritionPlanService generateNutritionPlanService;

  GenerateNutritionPlanRepo(this.generateNutritionPlanService);

  Future<Either<Failure, GenerateNutritionPlanResponseModel>> generateNutritionPlanRepo(
      GenerateNutritionPlanRequestModel generateNutritionPlanRequestModel) async {
    try {
      final response = await generateNutritionPlanService.generateNutritionPlanService(generateNutritionPlanRequestModel);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}