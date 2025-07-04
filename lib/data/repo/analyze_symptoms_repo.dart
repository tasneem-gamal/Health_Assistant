import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:health_assistant/core/networking/api_error_handler.dart';
import 'package:health_assistant/data/data_source/analyze_symptoms_service.dart';
import 'package:health_assistant/data/models/analyze_symptoms/analyze_symptoms_request_model.dart';
import 'package:health_assistant/data/models/analyze_symptoms/analyze_symptoms_response_model.dart';

class AnalyzeSymptomsRepo {
  final AnalyzeSymptomsService analyzeSymptomsService;

  AnalyzeSymptomsRepo(this.analyzeSymptomsService);

  Future<Either<Failure, AnalyzeSymptomsResponseModel>> analyzeSymptomsRepo(
      AnalyzeSymptomsRequestModel analyzeSymptomsRequestModel) async {
    try {
      final response = await analyzeSymptomsService.analyzeSymptomsService(analyzeSymptomsRequestModel);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}