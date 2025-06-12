import 'package:get_it/get_it.dart';
import 'package:health_assistant/data/data_source/analyze_symptoms_service.dart';
import 'package:health_assistant/data/data_source/auth_service.dart';
import 'package:health_assistant/data/data_source/generate_fitness_plan_service.dart';
import 'package:health_assistant/data/repo/analyze_symptoms_repo.dart';
import 'package:health_assistant/data/repo/auth_repo.dart';
import 'package:health_assistant/data/repo/generate_fitness_plan_repo.dart';
import 'package:health_assistant/presentation/controllers/analyze_symptoms/analyze_symptoms_cubit.dart';
import 'package:health_assistant/presentation/controllers/auth/auth_cubit.dart';
import 'package:health_assistant/presentation/controllers/generate_fitness_plan/generate_fitness_plan_cubit.dart';

final getIt = GetIt.instance;
void setUpGetIt(){
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<AuthRepo>(AuthRepo(getIt.get<AuthService>()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));


  //analyze symptoms
  getIt.registerSingleton<AnalyzeSymptomsService>(AnalyzeSymptomsService());
  getIt.registerSingleton<AnalyzeSymptomsRepo>(AnalyzeSymptomsRepo(getIt.get<AnalyzeSymptomsService>()));
  getIt.registerFactory<AnalyzeSymptomsCubit>(() => AnalyzeSymptomsCubit(getIt()));

  //generate fitness plan
  getIt.registerSingleton<GenerateFitnessPlanService>(GenerateFitnessPlanService());
  getIt.registerSingleton<GenerateFitnessPlanRepo>(GenerateFitnessPlanRepo(getIt.get<GenerateFitnessPlanService>()));
  getIt.registerFactory<GenerateFitnessPlanCubit>(() => GenerateFitnessPlanCubit(getIt()));
}