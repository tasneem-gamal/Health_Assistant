import 'package:dio/dio.dart';
import 'package:health_assistant/core/networking/api_constants.dart';
import 'package:health_assistant/core/networking/dio_factory.dart';
import 'package:health_assistant/data/models/generate_fitness_plan/generate_fitness_plan_request_model.dart';
import 'package:health_assistant/data/models/generate_fitness_plan/generate_fitness_plan_response_model.dart';

class GenerateFitnessPlanService {
  late Dio dio;

  GenerateFitnessPlanService() {
    dio = DioFactory.getDio();
  }

  Future<GenerateFitnessPlanResponseModel> generateFitnessPlanService(
      GenerateFitnessPlanRequestModel generateFitnessPlanRequestModel) async {
    final baseUrl = await ApiConstants.baseUrl;
    final response =
        await dio.post('$baseUrl${ApiConstants.generateFitnessPlan}', data: generateFitnessPlanRequestModel.toJson());
    return GenerateFitnessPlanResponseModel.fromJson(response.data);
  }
}
