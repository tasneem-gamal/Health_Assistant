import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/data/models/generate_fitness_plan/generate_fitness_plan_request_model.dart';
import 'package:health_assistant/data/models/generate_fitness_plan/generate_fitness_plan_response_model.dart';
import 'package:health_assistant/data/repo/generate_fitness_plan_repo.dart';

part 'generate_fitness_plan_state.dart';

class GenerateFitnessPlanCubit extends Cubit<GenerateFitnessPlanState> {
  GenerateFitnessPlanCubit(this.generateFitnessPlanRepo) : super(GenerateFitnessPlanInitial());

  final GenerateFitnessPlanRepo generateFitnessPlanRepo;

  void generateFitnessPlan(GenerateFitnessPlanRequestModel generateFitnessPlanRequestModel) async {
    emit(GenerateFitnessPlanLoading());

    final response = await generateFitnessPlanRepo.generateFitnessPlanRepo(generateFitnessPlanRequestModel);

    response.fold(
      (failure) {
        emit(GenerateFitnessPlanFailure(failure.errMessage));
      },
      (chatSuccess) {
        emit(GenerateFitnessPlanSuccess(chatSuccess));
      },
    );
  }
}
