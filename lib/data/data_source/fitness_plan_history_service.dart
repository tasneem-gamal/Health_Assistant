import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_assistant/data/models/home/fitness_plan_history_model.dart';

class FitnessPlanHistoryService {
  final FirebaseFirestore firestore;

  FitnessPlanHistoryService({required this.firestore});

  Future<List<FitnessPlanHistoryModel>> getUserFitnessPlanHistory(String userId) async {
    final snapshot = await firestore
        .collection('fitness_plan')
        .where('user_id', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final model = FitnessPlanHistoryModel.fromMap(doc.data());
      model.id = doc.id;
      return model;
    }).toList();
  }

  Future<void> deleteFitnessChatById(String docId) async {
    await firestore.collection('fitness_plan').doc(docId).delete();
  }

  Future<void> clearAllFitnessChatsForUser(String userId) async {
    final snapshot = await firestore
        .collection('fitness_plan')
        .where('user_id', isEqualTo: userId)
        .get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}