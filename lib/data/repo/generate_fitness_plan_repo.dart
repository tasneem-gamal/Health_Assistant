import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:health_assistant/core/networking/api_error_handler.dart';
import 'package:health_assistant/data/data_source/generate_fitness_plan_service.dart';
import 'package:health_assistant/data/models/generate_fitness_plan/generate_fitness_plan_request_model.dart';
import 'package:health_assistant/data/models/generate_fitness_plan/generate_fitness_plan_response_model.dart';

class GenerateFitnessPlanRepo {
  final GenerateFitnessPlanService generateFitnessPlanService;

  GenerateFitnessPlanRepo(this.generateFitnessPlanService);

  Future<Either<Failure, GenerateFitnessPlanResponseModel>> generateFitnessPlanRepo(
      GenerateFitnessPlanRequestModel generateFitnessPlanRequestModel) async {
    try {
      final response = await generateFitnessPlanService.generateFitnessPlanService(generateFitnessPlanRequestModel);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}