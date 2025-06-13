import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:health_assistant/core/networking/api_error_handler.dart';
import 'package:health_assistant/data/data_source/mental_health_chat_service.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_request_model.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_response_model.dart';

class MentalHealthChatRepo {
  final MentalHealthChatService mentalHealthChatService;

  MentalHealthChatRepo(this.mentalHealthChatService);

  Future<Either<Failure, MentalHealthResponseModel>> mentalHealthChatRepo(
      MentalHealthRequestModel mentalHealthRequestModel) async {
    try {
      final response = await mentalHealthChatService.mentalHealthChatService(mentalHealthRequestModel);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}