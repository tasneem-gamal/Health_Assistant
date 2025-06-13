import 'package:dio/dio.dart';
import 'package:health_assistant/core/networking/api_constants.dart';
import 'package:health_assistant/core/networking/dio_factory.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_request_model.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_response_model.dart';

class MentalHealthChatService {
  late Dio dio;

  MentalHealthChatService(){
    dio = DioFactory.getDio();
  }

  Future<MentalHealthResponseModel> mentalHealthChatService(
    MentalHealthRequestModel mentalHealthRequestModel) async{
    final response = await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.mentalHealthChat}',
      data: mentalHealthRequestModel.toJson()
    );
    return MentalHealthResponseModel.fromJson(response.data);
  }
}