import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:health_assistant/core/networking/api_constants.dart';
import 'package:health_assistant/core/networking/dio_factory.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_request_model.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_response_model.dart';
import 'package:health_assistant/firebase_database.dart';

class MentalHealthChatService {
  late Dio dio;

  MentalHealthChatService() {
    dio = DioFactory.getDio();
  }

  Future<MentalHealthResponseModel> mentalHealthChatService(
      MentalHealthRequestModel mentalHealthRequestModel) async {
    final response = await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.mentalHealthChat}',
      data: mentalHealthRequestModel.toJson(),
    );

    final reply = MentalHealthResponseModel.fromJson(response.data);

    await FirebaseFirestore.instanceFor(app: secondaryApp)
        .collection('chat_history')
        .add({
      'user_id': mentalHealthRequestModel.userId,
      'message': mentalHealthRequestModel.message, 
      'timestamp': FieldValue.serverTimestamp(),
    });

    return reply;
  }
}