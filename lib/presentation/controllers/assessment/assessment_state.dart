part of 'assessment_cubit.dart';

abstract class AssessmentState {}

class AssessmentInitial extends AssessmentState {}

class AssessmentLoading extends AssessmentState {}

class AssessmentSuccess extends AssessmentState {
  final List<AssessmentModel> assessments;

  AssessmentSuccess(this.assessments);
}

class AssessmentFailure extends AssessmentState {
  final String errMessage;

  AssessmentFailure(this.errMessage);
}