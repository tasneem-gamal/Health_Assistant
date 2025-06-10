import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/data/models/analyze_symptoms.dart/analyze_symptoms_request_model.dart';
import 'package:health_assistant/data/models/analyze_symptoms.dart/analyze_symptoms_response_model.dart';
import 'package:health_assistant/data/repo/analyze_symptoms/analyze_symptoms_repo.dart';

part 'analyze_symptoms_state.dart';

class AnalyzeSymptomsCubit extends Cubit<AnalyzeSymptomsState> {
  AnalyzeSymptomsCubit(this.analyzeSymptomsRepo) : super(AnalyzeSymptomsInitial());

  final AnalyzeSymptomsRepo analyzeSymptomsRepo;

  void analyzeSymptoms(AnalyzeSymptomsRequestModel analyzeSymptomsRequestModel) async {
    emit(AnalyzeSymptomsLoading());

    final response = await analyzeSymptomsRepo.analyzeSymptomsRepo(analyzeSymptomsRequestModel);

    response.fold(
      (failure) {
        emit(AnalyzeSymptomsFailure(failure.errMessage));
      },
      (chatSuccess) {
        emit(AnalyzeSymptomsSuccess(chatSuccess));
      },
    );
  }
}
