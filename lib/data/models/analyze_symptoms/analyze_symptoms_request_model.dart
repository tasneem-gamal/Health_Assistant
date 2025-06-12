class AnalyzeSymptomsRequestModel {
  final List<String> symptoms;
  final String duration;
  final int painLevel;
  final String startDate;

  AnalyzeSymptomsRequestModel({
    required this.symptoms,
    required this.duration,
    required this.painLevel,
    required this.startDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'symptoms': symptoms,
      'duration': duration,
      'painLevel': painLevel,
      'startDate': startDate,
    };
  }

  factory AnalyzeSymptomsRequestModel.fromJson(Map<String, dynamic> json) {
    return AnalyzeSymptomsRequestModel(
      symptoms: json['symptoms'],
      duration: json['duration'],
      painLevel: json['painLevel'],
      startDate: json['startDate'],
    );
  }
}
