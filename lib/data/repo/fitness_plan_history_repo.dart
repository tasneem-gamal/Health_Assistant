
import 'package:health_assistant/data/data_source/fitness_plan_history_service.dart';
import 'package:health_assistant/data/models/home/fitness_plan_history_model.dart';

class FitnessPlanHistoryRepo {
  final FitnessPlanHistoryService service;

  FitnessPlanHistoryRepo(this.service);

  Future<List<FitnessPlanHistoryModel>> getFitnessPlanHistory(String userId) {
    return service.getUserFitnessPlanHistory(userId);
  }

  Future<void> deleteChat(String docId) {
    return service.deleteFitnessChatById(docId);
  }

  Future<void> clearAllChats(String userId) {
    return service.clearAllFitnessChatsForUser(userId);
  }
}