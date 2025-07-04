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
    MentalHealthRequestModel mentalHealthRequestModel,
  ) async {
    final response = await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.mentalHealthChat}',
      data: mentalHealthRequestModel.toJson(),
    );

    final reply = MentalHealthResponseModel.fromJson(response.data);

    final chatCollection = FirebaseFirestore.instanceFor(app: secondaryApp)
        .collection('chat_history');

    if (mentalHealthRequestModel.historyId != null) {
      await chatCollection.doc(mentalHealthRequestModel.historyId!).update({
        'message': mentalHealthRequestModel.message,
        'response': reply.response,
        'timestamp': FieldValue.serverTimestamp(),
        'emotion_data': reply.emotionData.toMap(),
        'history': [
          ...mentalHealthRequestModel.history,
          {'assistant': reply.response},
        ],
      });

    } else {
      await chatCollection.add({
        'user_id': mentalHealthRequestModel.userId,
        'message': mentalHealthRequestModel.message,
        'response': reply.response,
        'session_id': mentalHealthRequestModel.sessionId,
        'message_type': 'mental_health',
        'emotion_data': reply.emotionData.toMap(),
        'timestamp': FieldValue.serverTimestamp(),
        'history': [
          {'user': mentalHealthRequestModel.message},
          {'assistant': reply.response},
        ],
      });
    }

    return reply;
  }
}
