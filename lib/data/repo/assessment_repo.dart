import 'package:health_assistant/data/data_source/assessment_service.dart';
import 'package:health_assistant/data/models/assessments/assessment_model.dart';

class AssessmentRepo {
  final AssessmentService assessmentService;

  AssessmentRepo({required this.assessmentService});

  Future<List<AssessmentModel>> getAssessments() async {
    try {
      return await assessmentService.fetchAssessments();
    } catch (e) {
      throw Exception("Failed to load assessments: $e");
    }
  }
}