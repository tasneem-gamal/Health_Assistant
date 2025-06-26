import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:health_assistant/data/data_source/analyze_symptoms_service.dart';
import 'package:health_assistant/data/data_source/assessment_service.dart';
import 'package:health_assistant/data/data_source/auth_service.dart';
import 'package:health_assistant/data/data_source/chat_history_service.dart';
import 'package:health_assistant/data/data_source/general_chat_service.dart';
import 'package:health_assistant/data/data_source/generate_fitness_plan_service.dart';
import 'package:health_assistant/data/data_source/generate_nutrition_plan_service.dart';
import 'package:health_assistant/data/data_source/mental_health_chat_service.dart';
import 'package:health_assistant/data/repo/analyze_symptoms_repo.dart';
import 'package:health_assistant/data/repo/assessment_repo.dart';
import 'package:health_assistant/data/repo/auth_repo.dart';
import 'package:health_assistant/data/repo/chat_history_repo.dart';
import 'package:health_assistant/data/repo/general_chat_repo.dart';
import 'package:health_assistant/data/repo/generate_fitness_plan_repo.dart';
import 'package:health_assistant/data/repo/generate_nutrition_plan_repo.dart';
import 'package:health_assistant/data/repo/mental_health_chat_repo.dart';
import 'package:health_assistant/presentation/controllers/analyze_symptoms/analyze_symptoms_cubit.dart';
import 'package:health_assistant/presentation/controllers/assessment/assessment_cubit.dart';
import 'package:health_assistant/presentation/controllers/auth/auth_cubit.dart';
import 'package:health_assistant/presentation/controllers/auth/update_user_info_cubit.dart';
import 'package:health_assistant/presentation/controllers/chat_history/chat_history_cubit.dart';
import 'package:health_assistant/presentation/controllers/general_chat/general_chat_cubit.dart';
import 'package:health_assistant/presentation/controllers/generate_fitness_plan/generate_fitness_plan_cubit.dart';
import 'package:health_assistant/presentation/controllers/generate_nutrition_plan/generate_nutrition_plan_cubit.dart';
import 'package:health_assistant/presentation/controllers/mental_health_chat/mental_health_chat_cubit.dart';

final getIt = GetIt.instance;
void setUpGetIt(){
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<AuthRepo>(AuthRepo(getIt.get<AuthService>()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
  getIt.registerFactory<UpdateUserInfoCubit>(() => UpdateUserInfoCubit(getIt()));



  //analyze symptoms
  getIt.registerSingleton<AnalyzeSymptomsService>(AnalyzeSymptomsService());
  getIt.registerSingleton<AnalyzeSymptomsRepo>(AnalyzeSymptomsRepo(getIt.get<AnalyzeSymptomsService>()));
  getIt.registerFactory<AnalyzeSymptomsCubit>(() => AnalyzeSymptomsCubit(getIt()));

  //generate fitness plan
  getIt.registerSingleton<GenerateFitnessPlanService>(GenerateFitnessPlanService());
  getIt.registerSingleton<GenerateFitnessPlanRepo>(GenerateFitnessPlanRepo(getIt.get<GenerateFitnessPlanService>()));
  getIt.registerFactory<GenerateFitnessPlanCubit>(() => GenerateFitnessPlanCubit(getIt()));

  //generate nutrition plan 
  getIt.registerSingleton<GenerateNutritionPlanService>(GenerateNutritionPlanService());
  getIt.registerSingleton<GenerateNutritionPlanRepo>(GenerateNutritionPlanRepo(getIt.get<GenerateNutritionPlanService>()));
  getIt.registerFactory<GenerateNutritionPlanCubit>(() => GenerateNutritionPlanCubit(getIt()));

  //general chat
  getIt.registerSingleton<GeneralChatService>(GeneralChatService());
  getIt.registerSingleton<GeneralChatRepo>(GeneralChatRepo(getIt.get<GeneralChatService>()));
  getIt.registerFactory<GeneralChatCubit>(() => GeneralChatCubit(getIt()));

  //mental health chat
  getIt.registerSingleton<MentalHealthChatService>(MentalHealthChatService());
  getIt.registerSingleton<MentalHealthChatRepo>(MentalHealthChatRepo(getIt.get<MentalHealthChatService>()));
  getIt.registerFactory<MentalHealthChatCubit>(() => MentalHealthChatCubit(getIt()));

  
  
  //assessments
  final secondaryApp = Firebase.app('secondaryApp');



  getIt.registerSingleton<AssessmentService>(
    AssessmentService(secondaryApp: secondaryApp),
  );
  getIt.registerSingleton<AssessmentRepo>(
    AssessmentRepo(assessmentService: getIt<AssessmentService>()),
  );
  getIt.registerFactory<AssessmentCubit>(
    () => AssessmentCubit(assessmentRepo: getIt<AssessmentRepo>()),
  );

  //chat history
  final secondaryFirestore = FirebaseFirestore.instanceFor(app: Firebase.app('secondaryApp'));

  getIt.registerSingleton<ChatHistoryService>(ChatHistoryService(firestore: secondaryFirestore));
  getIt.registerSingleton<ChatHistoryRepo>(ChatHistoryRepo(getIt.get<ChatHistoryService>()));
  getIt.registerFactory<ChatHistoryCubit>(() => ChatHistoryCubit(getIt()));
}