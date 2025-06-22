part of 'update_user_info_cubit.dart';

abstract class UpdateUserInfoState {}

class UpdateUserInfoInitial extends UpdateUserInfoState {}

class UpdateUserInfoLoading extends UpdateUserInfoState {}

class UpdateUserInfoSuccess extends UpdateUserInfoState {}

class UpdateUserInfoFailure extends UpdateUserInfoState {
  final String errMessage;
  UpdateUserInfoFailure(this.errMessage);
}
