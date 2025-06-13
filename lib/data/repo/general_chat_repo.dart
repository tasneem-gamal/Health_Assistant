import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:health_assistant/core/networking/api_error_handler.dart';
import 'package:health_assistant/data/data_source/general_chat_service.dart';
import 'package:health_assistant/data/models/general_chat/general_chat_request_model.dart';
import 'package:health_assistant/data/models/general_chat/general_chat_response_model.dart';

class GeneralChatRepo {
  final GeneralChatService generalChatService;

  GeneralChatRepo(this.generalChatService);

  Future<Either<Failure, GeneralChatResponseModel>> generalChatRepo(
      GeneralChatRequestModel generalChatRequestModel) async {
    try {
      final response = await generalChatService.generalChatService(generalChatRequestModel);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}