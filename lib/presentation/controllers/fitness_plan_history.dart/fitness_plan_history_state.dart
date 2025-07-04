part of 'fitness_plan_history_cubit.dart';

class FitnessPlanHistoryState {}
class FitnessPlanHistoryInitial extends FitnessPlanHistoryState {}
class FitnessPlanHistoryLoading extends FitnessPlanHistoryState {}
class FitnessPlanHistorySuccess extends FitnessPlanHistoryState {
  final List<FitnessPlanHistoryModel> chatList;
  FitnessPlanHistorySuccess(this.chatList);
}
class FitnessPlanHistoryFailure extends FitnessPlanHistoryState {
  final String errMessage;

  FitnessPlanHistoryFailure(this.errMessage);
}
