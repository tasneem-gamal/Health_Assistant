import 'package:cloud_firestore/cloud_firestore.dart';

class FitnessPlanHistoryModel {
  String? id;
  final String planResult;
  final String planType;
  final ProfileData profileData;
  final String userId;
  final bool active;
  final DateTime createdAt;

  FitnessPlanHistoryModel({
    this.id,
    required this.planResult,
    required this.planType,
    required this.profileData,
    required this.userId,
    required this.active,
    required this.createdAt,
  });

  factory FitnessPlanHistoryModel.fromMap(Map<String, dynamic> map) {
    return FitnessPlanHistoryModel(
      id: map['id'] ?? '',
      planResult: map['plan_result'] ?? '',
      planType: map['plan_type'] ?? '',
      profileData: ProfileData.fromMap(Map<String, dynamic>.from(map['profile_data'] ?? {})),
      userId: map['user_id'] ?? '',
      active: map['active'] ?? false,
      createdAt: (map['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plan_result': planResult,
      'plan_type': planType,
      'profile_data': profileData.toMap(),
      'user_id': userId,
      'active': active,
      'created_at': createdAt,
    };
  }
}

class ProfileData {
  final int age;
  final List<String> equipmentAvailable;
  final String fitnessGoal;
  final String fitnessLevel;
  final String gender;
  final int height;
  final String limitations;
  final List<String> medicalConditions;
  final int sessionDuration;
  final int sessionsPerWeek;
  final int weight;
  final String type;

  ProfileData({
    required this.age,
    required this.equipmentAvailable,
    required this.fitnessGoal,
    required this.fitnessLevel,
    required this.gender,
    required this.height,
    required this.limitations,
    required this.medicalConditions,
    required this.sessionDuration,
    required this.sessionsPerWeek,
    required this.weight,
    required this.type,
  });

  factory ProfileData.fromMap(Map<String, dynamic> map) {
    return ProfileData(
      age: map['age'] ?? 0,
      equipmentAvailable: List<String>.from(map['equipment_available'] ?? []),
      fitnessGoal: map['fitness_goal'] ?? '',
      fitnessLevel: map['fitness_level'] ?? '',
      gender: map['gender'] ?? '',
      height: map['height'] ?? 0,
      limitations: map['limitations'] ?? '',
      medicalConditions: List<String>.from(map['medical_conditions'] ?? []),
      sessionDuration: map['session_duration'] ?? 0,
      sessionsPerWeek: map['sessions_per_week'] ?? 0,
      weight: map['weight'] ?? 0,
      type: map['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'equipment_available': equipmentAvailable,
      'fitness_goal': fitnessGoal,
      'fitness_level': fitnessLevel,
      'gender': gender,
      'height': height,
      'limitations': limitations,
      'medical_conditions': medicalConditions,
      'session_duration': sessionDuration,
      'sessions_per_week': sessionsPerWeek,
      'weight': weight,
      'type': type,
    };
  }
}
