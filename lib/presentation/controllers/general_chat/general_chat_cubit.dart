import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/data/models/general_chat/general_chat_request_model.dart';
import 'package:health_assistant/data/models/general_chat/general_chat_response_model.dart';
import 'package:health_assistant/data/repo/general_chat_repo.dart';

part 'general_chat_state.dart';

class GeneralChatCubit extends Cubit<GeneralChatState> {
  GeneralChatCubit(this.generalChatRepo) : super(GeneralChatInitial());

  final GeneralChatRepo generalChatRepo;

  void generalChat(GeneralChatRequestModel generalChatRequestModel) async {
    emit(GeneralChatLoading());

    final response = await generalChatRepo.generalChatRepo(generalChatRequestModel);

    response.fold(
      (failure) {
        emit(GeneralChatFailure(failure.errMessage));
      },
      (chatSuccess) {
        emit(GeneralChatSuccess(chatSuccess));
      },
    );
  }
}
