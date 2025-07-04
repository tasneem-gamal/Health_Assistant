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

  Future<GeneralChatResponseModel> generalChatService(GeneralChatRequestModel generalChatRequestModel) async {
    final baseUrl = await ApiConstants.baseUrl;
    final response = await dio.post(
      '$baseUrl${ApiConstants.generalChat}',
      data: generalChatRequestModel.toJson(),
    );

    final reply = GeneralChatResponseModel.fromJson(response.data);

    final chatCollection = FirebaseFirestore.instanceFor(app: secondaryApp).collection('chat_history');

    if (generalChatRequestModel.historyId != null) {
      await chatCollection.doc(generalChatRequestModel.historyId!).update({
        'message': generalChatRequestModel.message,
        'response': reply.response,
        'timestamp': FieldValue.serverTimestamp(),
        'history': [
          ...generalChatRequestModel.history,
          {'assistant': reply.response},
        ],
      });
    } else {
      await chatCollection.add({
        'user_id': generalChatRequestModel.userId,
        'message': generalChatRequestModel.message,
        'response': reply.response,
        'message_type': 'mental_health',
        'timestamp': FieldValue.serverTimestamp(),
        'history': [
          {'user': generalChatRequestModel.message},
          {'assistant': reply.response},
        ],
      });
    }

    return reply;
  }
}
