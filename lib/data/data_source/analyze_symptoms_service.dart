import 'package:dio/dio.dart';
import 'package:health_assistant/core/networking/api_constants.dart';
import 'package:health_assistant/core/networking/dio_factory.dart';
import 'package:health_assistant/data/models/analyze_symptoms/analyze_symptoms_request_model.dart';
import 'package:health_assistant/data/models/analyze_symptoms/analyze_symptoms_response_model.dart';

class AnalyzeSymptomsService {
  late Dio dio;

  AnalyzeSymptomsService() {
    dio = DioFactory.getDio();
  }

  Future<AnalyzeSymptomsResponseModel> analyzeSymptomsService(
      AnalyzeSymptomsRequestModel analyzeSymptomsRequestModel) async {
    final baseUrl = await ApiConstants.baseUrl;
    final response =
        await dio.post('$baseUrl${ApiConstants.analyzeSymptoms}', data: analyzeSymptomsRequestModel.toJson());
    return AnalyzeSymptomsResponseModel.fromJson(response.data);
  }
}
