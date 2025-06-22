import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/data/models/assessments/assessment_model.dart';
import 'package:health_assistant/data/repo/assessment_repo.dart';

part 'assessment_state.dart';

class AssessmentCubit extends Cubit<AssessmentState> {
  final AssessmentRepo assessmentRepo;

  AssessmentCubit({required this.assessmentRepo}) : super(AssessmentInitial());

  Future<void> fetchAssessments() async {
    emit(AssessmentLoading());
    try {
      final assessments = await assessmentRepo.getAssessments();
      emit(AssessmentSuccess(assessments));
    } catch (e) {
      emit(AssessmentFailure(e.toString()));
    }
  }
}