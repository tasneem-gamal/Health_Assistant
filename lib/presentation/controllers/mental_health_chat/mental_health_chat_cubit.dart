import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_request_model.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_response_model.dart';
import 'package:health_assistant/data/repo/mental_health_chat_repo.dart';

part 'mental_health_chat_state.dart';

class MentalHealthChatCubit extends Cubit<MentalHealthChatState> {
  MentalHealthChatCubit(this.mentalHealthChatRepo) : super(MentalHealthChatInitial());

  final MentalHealthChatRepo mentalHealthChatRepo;

  void mentalHealthChat(MentalHealthRequestModel mentalHealthRequestModel) async {
    emit(MentalHealthChatLoading());

    final response = await mentalHealthChatRepo.mentalHealthChatRepo(mentalHealthRequestModel);

    response.fold(
      (failure) {
        emit(MentalHealthChatFailure(failure.errMessage));
      },
      (chatSuccess) {
        emit(MentalHealthChatSuccess(chatSuccess, fromAssessment: mentalHealthRequestModel.fromAssessment));
      },
    );
  }
}
