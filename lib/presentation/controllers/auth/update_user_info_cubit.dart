import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/data/repo/auth_repo.dart';

part 'update_user_info_state.dart';

class UpdateUserInfoCubit extends Cubit<UpdateUserInfoState> {
  final AuthRepo authRepo;

  UpdateUserInfoCubit(this.authRepo) : super(UpdateUserInfoInitial());

  Future<void> updateUser({
    required String currentEmail,
    required String currentPassword,
    String? name,
    String? email,
    String? phone,
    String? password,
  }) async {
    emit(UpdateUserInfoLoading());
    try {
      await authRepo.updateUserProfile(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
      emit(UpdateUserInfoSuccess());
    } catch (e) {
      final errorMessage = e.toString();

      if (errorMessage.contains("requires-recent-login")) {
        emit(UpdateUserInfoSuccess());
      } else {
        emit(UpdateUserInfoFailure(errorMessage));
      }
    }
  }
}
