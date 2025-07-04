part of 'analyze_symptoms_cubit.dart';

class AnalyzeSymptomsState {}

class AnalyzeSymptomsInitial extends AnalyzeSymptomsState {}
class AnalyzeSymptomsLoading extends AnalyzeSymptomsState {}
class AnalyzeSymptomsSuccess extends AnalyzeSymptomsState {
  final AnalyzeSymptomsResponseModel analyzeSymptomsResponseModel;

  AnalyzeSymptomsSuccess(this.analyzeSymptomsResponseModel);
}
class AnalyzeSymptomsFailure extends AnalyzeSymptomsState {
  final String errMessage;

  AnalyzeSymptomsFailure(this.errMessage);
}

