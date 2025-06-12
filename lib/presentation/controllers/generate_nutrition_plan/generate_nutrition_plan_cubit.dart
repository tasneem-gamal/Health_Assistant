import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/data/models/generate_nutrition_plan/generate_nutrition_plan_request_model.dart';
import 'package:health_assistant/data/models/generate_nutrition_plan/generate_nutrition_plan_response_model.dart';
import 'package:health_assistant/data/repo/generate_nutrition_plan_repo.dart';

part 'generate_nutrition_plan_state.dart';

class GenerateNutritionPlanCubit extends Cubit<GenerateNutritionPlanState> {
  GenerateNutritionPlanCubit(this.generateNutritionPlanRepo) : super(GenerateNutritionPlanInitial());

  final GenerateNutritionPlanRepo generateNutritionPlanRepo;

  void generateNutritionPlan(GenerateNutritionPlanRequestModel generateNutritionPlanRequestModel) async {
    emit(GenerateNutritionPlanLoading());

    final response = await generateNutritionPlanRepo.generateNutritionPlanRepo(generateNutritionPlanRequestModel);

    response.fold(
      (failure) {
        emit(GenerateNutritionPlanFailure(failure.errMessage));
      },
      (chatSuccess) {
        emit(GenerateNutritionPlanSuccess(chatSuccess));
      },
    );
  }
}
