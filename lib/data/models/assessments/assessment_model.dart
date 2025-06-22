class AssessmentModel {
  final String assessmentTitle;
  final String instructions;
  final List<QuestionModel> questions;
  final ScoringModel scoring;

  AssessmentModel({
    required this.assessmentTitle,
    required this.instructions,
    required this.questions,
    required this.scoring,
  });

  factory AssessmentModel.fromMap(Map<String, dynamic> map) {
  return AssessmentModel(
    assessmentTitle: map['assessmentTitle'] ?? '',
    instructions: map['instructions'] ?? '',
    questions: map['questions'] != null
        ? List<QuestionModel>.from(
            (map['questions'] as List).map(
              (q) => QuestionModel.fromMap(Map<String, dynamic>.from(q)),
            ),
          )
        : [],
    scoring: ScoringModel.fromMap(Map<String, dynamic>.from(map['scoring'] ?? {})),
  );
}

}

class QuestionModel {
  final String id;
  final String text;
  final bool isReverseScored;

  QuestionModel({
    required this.id,
    required this.text,
    required this.isReverseScored,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      isReverseScored: map['isReverseScored'] ?? false,
    );
  }
}

class ScoringModel {
  final List<InterpretationModel> interpretation;
  final List<ScaleModel> scale;
  final String? reverseScoringNote;

  ScoringModel({
    required this.interpretation,
    required this.scale,
    this.reverseScoringNote,
  });

  factory ScoringModel.fromMap(Map<String, dynamic> map) {
    return ScoringModel(
      interpretation: List<InterpretationModel>.from(
        (map['interpretation'] as List).map((e) => InterpretationModel.fromMap(e)),
      ),
      scale: List<ScaleModel>.from(
        (map['scale'] as List).map((e) => ScaleModel.fromMap(e)),
      ),
      reverseScoringNote: map['reverseScoringNote'],
    );
  }
}

class InterpretationModel {
  final String level;
  final String range;
  final String? recommendation;

  InterpretationModel({
    required this.level,
    required this.range,
    this.recommendation,
  });

  factory InterpretationModel.fromMap(Map<String, dynamic> map) {
    return InterpretationModel(
      level: map['level'] ?? '',
      range: map['range'] ?? '',
      recommendation: map['recommendation'],
    );
  }
}

class ScaleModel {
  final String label;
  final int value;

  ScaleModel({
    required this.label,
    required this.value,
  });

  factory ScaleModel.fromMap(Map<String, dynamic> map) {
    return ScaleModel(
      label: map['label'] ?? '',
      value: map['value'] ?? 0,
    );
  }
}
