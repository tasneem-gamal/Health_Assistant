part of 'generate_nutrition_plan_cubit.dart';

class GenerateNutritionPlanState {}

class GenerateNutritionPlanInitial extends GenerateNutritionPlanState {}
class GenerateNutritionPlanLoading extends GenerateNutritionPlanState {}
class GenerateNutritionPlanSuccess extends GenerateNutritionPlanState {
  final GenerateNutritionPlanResponseModel generateNutritionPlanResponseModel;

  GenerateNutritionPlanSuccess(this.generateNutritionPlanResponseModel);
}
class GenerateNutritionPlanFailure extends GenerateNutritionPlanState {
  final String errMessage;

  GenerateNutritionPlanFailure(this.errMessage);
}
