import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:health_assistant/data/models/assessments/assessment_model.dart';

class AssessmentService {
  final FirebaseApp secondaryApp;

  AssessmentService({required this.secondaryApp});

  Map<String, dynamic> convertToMapStringDynamic(Map map) {
  return map.map(
    (key, value) {
      if (value is Map) {
        return MapEntry(key.toString(), convertToMapStringDynamic(value));
      } else if (value is List) {
        return MapEntry(
          key.toString(),
          value.map((e) {
            if (e is Map) {
              return convertToMapStringDynamic(e);
            }
            return e;
          }).toList(),
        );
      } else {
        return MapEntry(key.toString(), value);
      }
    },
  );
}

Future<List<AssessmentModel>> fetchAssessments() async {
    try {
      final db = FirebaseDatabase.instanceFor(
        app: secondaryApp,
        databaseURL: 'https://health-agent-ffe26-default-rtdb.firebaseio.com',
      );
      final ref = db.ref('assessments');
      final snapshot = await ref.get();

      if (!snapshot.exists) return [];

      final value = snapshot.value;

      if (value is List) {
        return value.where((item) => item != null).map((item) {
          final rawMap = item as Map;
          final map = convertToMapStringDynamic(rawMap);
          return AssessmentModel.fromMap(map);
        }).toList();
      }

      if (value is Map) {
        return value.values.where((item) => item != null).map((item) {
          final rawMap = item as Map;
          final map = convertToMapStringDynamic(rawMap);
          return AssessmentModel.fromMap(map);
        }).toList();
      }

      throw Exception("Unsupported data format: ${value.runtimeType}");
    } catch (e) {
      
      rethrow;
    }
  }

  Future<void> saveAssessmentToChat({
    required String userId,
    required String sessionId,
    required String message,
    required String response,
    required Map<String, dynamic> assessmentData,
    String? historyId,
  }) async {
    final chatCollection = FirebaseFirestore.instanceFor(app: secondaryApp)
        .collection('chat_history');

    if (historyId != null) {
      await chatCollection.doc(historyId).update({
        'message': message,
        'response': response,
        'timestamp': FieldValue.serverTimestamp(),
        'assessment_data': assessmentData,
        'history': FieldValue.arrayUnion([
          {'assistant': response},
        ]),
      });
    } else {
      await chatCollection.add({
        'user_id': userId,
        'session_id': sessionId,
        'message': message,
        'response': response,
        'message_type': 'assessment',
        'assessment_data': assessmentData,
        'timestamp': FieldValue.serverTimestamp(),
        'history': [
          {'user': message},
          {'assistant': response},
        ],
      });
    }
  }



}