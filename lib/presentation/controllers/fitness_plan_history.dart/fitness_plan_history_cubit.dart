import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/data/models/home/fitness_plan_history_model.dart';
import 'package:health_assistant/data/repo/fitness_plan_history_repo.dart';

part 'fitness_plan_history_state.dart';

class FitnessPlanHistoryCubit extends Cubit<FitnessPlanHistoryState> {
  FitnessPlanHistoryCubit(this.repo) : super(FitnessPlanHistoryInitial());

  final FitnessPlanHistoryRepo repo;

  Future<void> fetchFitnessPlanHistory(String userId) async {
    emit(FitnessPlanHistoryLoading());
    try {
      final chatList = await repo.getFitnessPlanHistory(userId);
      emit(FitnessPlanHistorySuccess(chatList));
    } catch (e) {
      emit(FitnessPlanHistoryFailure(e.toString()));
    }
  }

  Future<void> deleteChat(String docId, String userId) async {
  emit(FitnessPlanHistoryLoading());
  await repo.deleteChat(docId);
  fetchFitnessPlanHistory(userId);
}

Future<void> clearAllChats(String userId) async {
  emit(FitnessPlanHistoryLoading());
  await repo.clearAllChats(userId);
  fetchFitnessPlanHistory(userId);
}

}
