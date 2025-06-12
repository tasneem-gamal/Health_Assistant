class GenerateFitnessPlanRequestModel {
  final int height;
  final int weight;
  final int age;
  final String gender;
  final String fitnessLevel;
  final String fitnessGoal;
  final int sessionsPerWeek;
  final int sessionDuration;
  final String limitations;
  final List<String>? equipment; 
  final List<String>? medicalConditions;

  GenerateFitnessPlanRequestModel({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.fitnessLevel,
    required this.fitnessGoal,
    required this.sessionsPerWeek,
    required this.sessionDuration,
    required this.limitations,
    this.equipment, 
    this.medicalConditions,
  });

  factory GenerateFitnessPlanRequestModel.fromJson(Map<String, dynamic> json) {
    return GenerateFitnessPlanRequestModel(
      height: json['height'],
      weight: json['weight'],
      age: json['age'],
      gender: json['gender'],
      fitnessLevel: json['fitnessLevel'],
      fitnessGoal: json['fitnessGoal'],
      sessionsPerWeek: json['sessionsPerWeek'],
      sessionDuration: json['sessionDuration'],
      limitations: json['limitations'],
      equipment: json['equipment'] != null
          ? List<String>.from(json['equipment'])
          : null, 
      medicalConditions: json['medical_conditions'] != null
          ? List<String>.from(json['medical_conditions'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender,
      'fitnessLevel': fitnessLevel,
      'fitnessGoal': fitnessGoal,
      'sessionsPerWeek': sessionsPerWeek,
      'sessionDuration': sessionDuration,
      'limitations': limitations,
      if (equipment != null) 'equipment': equipment, 
      if (medicalConditions != null)
        'medical_conditions': medicalConditions,
    };
  }
}
