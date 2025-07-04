part of 'generate_fitness_plan_cubit.dart';

class GenerateFitnessPlanState {}

class GenerateFitnessPlanInitial extends GenerateFitnessPlanState {}
class GenerateFitnessPlanLoading extends GenerateFitnessPlanState {}
class GenerateFitnessPlanSuccess extends GenerateFitnessPlanState {
  final GenerateFitnessPlanResponseModel generateFitnessPlanResponseModel;

  GenerateFitnessPlanSuccess(this.generateFitnessPlanResponseModel);
}
class GenerateFitnessPlanFailure extends GenerateFitnessPlanState {
  final String errMessage;

  GenerateFitnessPlanFailure(this.errMessage);

}


