part of 'mental_health_chat_cubit.dart';

class MentalHealthChatState {}
class MentalHealthChatInitial extends MentalHealthChatState {}
class MentalHealthChatLoading extends MentalHealthChatState {}
class MentalHealthChatSuccess extends MentalHealthChatState {
  final MentalHealthResponseModel mentalHealthResponseModel;

  MentalHealthChatSuccess(this.mentalHealthResponseModel);
}
class MentalHealthChatFailure extends MentalHealthChatState {
  final String errMessage;

  MentalHealthChatFailure(this.errMessage);
}
