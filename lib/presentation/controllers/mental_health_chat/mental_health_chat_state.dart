part of 'mental_health_chat_cubit.dart';

class MentalHealthChatState {}
class MentalHealthChatInitial extends MentalHealthChatState {}
class MentalHealthChatLoading extends MentalHealthChatState {}
class MentalHealthChatSuccess extends MentalHealthChatState {
  final MentalHealthResponseModel mentalHealthResponseModel;
  final bool fromAssessment;

  MentalHealthChatSuccess(this.mentalHealthResponseModel, {this.fromAssessment = false});
}
class MentalHealthChatFailure extends MentalHealthChatState {
  final String errMessage;

  MentalHealthChatFailure(this.errMessage);
}
