part of 'general_chat_cubit.dart';

class GeneralChatState {}

class GeneralChatInitial extends GeneralChatState {}
class GeneralChatLoading extends GeneralChatState {}
class GeneralChatSuccess extends GeneralChatState {
  final GeneralChatResponseModel generalChatResponseModel;

  GeneralChatSuccess(this.generalChatResponseModel);
}
class GeneralChatFailure extends GeneralChatState {
  final String errMessage;

  GeneralChatFailure(this.errMessage);
}
