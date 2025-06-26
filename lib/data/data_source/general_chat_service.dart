import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:health_assistant/core/networking/api_constants.dart';
import 'package:health_assistant/core/networking/dio_factory.dart';
import 'package:health_assistant/data/models/general_chat/general_chat_request_model.dart';
import 'package:health_assistant/data/models/general_chat/general_chat_response_model.dart';
import 'package:health_assistant/firebase_database.dart';

class GeneralChatService {
  late Dio dio;

  GeneralChatService() {
    dio = DioFactory.getDio();
  }

  Future<GeneralChatResponseModel> generalChatService(
      GeneralChatRequestModel generalChatRequestModel) async {
    final response = await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.generalChat}',
      data: generalChatRequestModel.toJson(),
    );

    final reply = GeneralChatResponseModel.fromJson(response.data);

    await FirebaseFirestore.instanceFor(app: secondaryApp)
        .collection('chat_history')
        .add({
      'user_id': generalChatRequestModel.userId,
      'message': generalChatRequestModel.message, 
      'timestamp': FieldValue.serverTimestamp(),
    });

    return reply;
  }
}