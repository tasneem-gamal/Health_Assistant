class GenerateNutritionPlanRequestModel {
  final int height;
  final int weight;
  final int age;
  final String gender;
  final String activityLevel;
  final String goal;
  final List<String> dietaryRestrictions;
  final List<String> allergies;
  final List<String> mealPreferences;
  final List<String> supplements;
  final List<String>? medicalConditions; 

  GenerateNutritionPlanRequestModel({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.activityLevel,
    required this.goal,
    required this.dietaryRestrictions,
    required this.allergies,
    required this.mealPreferences,
    required this.supplements,
    this.medicalConditions,
  });

  factory GenerateNutritionPlanRequestModel.fromJson(Map<String, dynamic> json) {
    return GenerateNutritionPlanRequestModel(
      height: json['height'],
      weight: json['weight'],
      age: json['age'],
      gender: json['gender'],
      activityLevel: json['activityLevel'],
      goal: json['goal'],
      dietaryRestrictions: List<String>.from(json['dietary_restrictions']),
      allergies: List<String>.from(json['allergies']),
      mealPreferences: List<String>.from(json['meal_preferences']),
      supplements: List<String>.from(json['supplements']),
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
      'activityLevel': activityLevel,
      'goal': goal,
      'dietary_restrictions': dietaryRestrictions,
      'allergies': allergies,
      'meal_preferences': mealPreferences,
      'supplements': supplements,
      if (medicalConditions != null)
        'medical_conditions': medicalConditions,
    };
  }
}
