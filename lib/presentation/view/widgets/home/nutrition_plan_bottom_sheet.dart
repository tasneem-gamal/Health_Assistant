import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/data/models/generate_nutrition_plan/generate_nutrition_plan_request_model.dart';
import 'package:health_assistant/presentation/controllers/generate_nutrition_plan/generate_nutrition_plan_cubit.dart';
import 'package:health_assistant/presentation/view/widgets/home/text_field_with_title.dart';


class NutritionPlanBottomSheet extends StatefulWidget {
  const NutritionPlanBottomSheet({super.key, required this.chatController, required this.onActionDone});
  final InMemoryChatController chatController;
  final VoidCallback onActionDone;

  @override
  State<NutritionPlanBottomSheet> createState() => _NutritionPlanBottomSheetState();
}

class _NutritionPlanBottomSheetState extends State<NutritionPlanBottomSheet> {
  int currentStep = 1;
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final activityLevelController = TextEditingController();
  final dietaryRestrictionsController = TextEditingController();
  final allergiesController = TextEditingController();
  final mealPreferencesController = TextEditingController();
  final fitnessGoalController = TextEditingController();
  final supplementsController = TextEditingController();

  final _step1FormKey = GlobalKey<FormState>();
  final _step2FormKey = GlobalKey<FormState>();
  
  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    genderController.dispose();
    activityLevelController.dispose();
    dietaryRestrictionsController.dispose();
    allergiesController.dispose();
    mealPreferencesController.dispose();
    fitnessGoalController.dispose();
    supplementsController.dispose();
    super.dispose();
  }

  void generatePlan() {
    final model = GenerateNutritionPlanRequestModel(
      height: int.tryParse(heightController.text) ?? 0,
      weight: int.tryParse(weightController.text) ?? 0,
      age: int.tryParse(ageController.text) ?? 0,
      gender: genderController.text,
      activityLevel: activityLevelController.text,
      goal: fitnessGoalController.text,
      allergies:
          allergiesController.text.split(',').map((e) => e.trim()).toList(),
      mealPreferences: mealPreferencesController.text
          .split(',')
          .map((e) => e.trim())
          .toList(),
      supplements:
          supplementsController.text.split(',').map((e) => e.trim()).toList(),
      dietaryRestrictions: dietaryRestrictionsController.text
          .split(',')
          .map((e) => e.trim())
          .toList(),
      medicalConditions: [],
    );
    final userMessage = """
      Height: ${model.height}
      Weight: ${model.weight}
      Age: ${model.age}
      Gender: ${model.gender}
      Activity Level: ${model.activityLevel}
      Goal: ${model.goal}
      Dietary Restrictions: ${model.dietaryRestrictions.join(', ')}
      Allergies: ${model.allergies.join(', ')}
      Meal Preferences: ${model.mealPreferences.join(', ')}
      Supplements: ${model.supplements.join(', ')}
      Medical Conditions: ${model.medicalConditions?.join(', ') ?? 'None'}
    """;
    widget.chatController.insertMessage(
      TextMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        authorId: 'user1',
        createdAt: DateTime.now().toUtc(),
        text: userMessage,
      ),
    );
    context.read<GenerateNutritionPlanCubit>().generateNutritionPlan(model);
    widget.onActionDone();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, 
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          height: currentStep == 1
              ? MediaQuery.of(context).size.height * 0.38
              : MediaQuery.of(context).size.height * 0.52,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/exercise_running.png'),
                  horizontalSpace(context, 12),
                  Text(
                    'Fitness Plan Generator',
                    style: CustomTextStyles.font12BlackMedium(context).copyWith(
                      color: ColorsManager.lightGray,
                    ),
                  ),
                ],
              ),
              verticalSpace(context, 8),
              const Divider(
                thickness: 1,
                color: ColorsManager.mainColor,
              ),
              verticalSpace(context, 8),
              if (currentStep == 1) ...[
                NextStep(
                  formKey: _step1FormKey,
                  onNext: () {
                    if (_step1FormKey.currentState!.validate()){
                      setState(() {
                      currentStep = 2;
                    });
                    }
                    
                  },
                  heightController: heightController,
                  weightController: weightController,
                  goalController: fitnessGoalController,
                  ageController: ageController,
                  genderController: genderController,
                ),
              ] else if (currentStep == 2) ...[
                GenerateStep(
                  formKey: _step2FormKey,
                  onGenerate: () {
                    if(_step2FormKey.currentState!.validate()){
                      generatePlan();
                    }
                    
                  }, 
                      activityLevelController: activityLevelController,
                      allergiesController: allergiesController,
                      mealPreferencesController: mealPreferencesController,
                      supplementsController: supplementsController,
                      dietaryRestrictionsController: dietaryRestrictionsController,
                    ),
                  
              ],
            ],
          ),
        ),
      ),
    );
  }
}


class NextStep extends StatelessWidget {
  const NextStep({
    super.key, 
    required this.onNext, 
    required this.heightController, 
    required this.weightController, 
    required this.goalController, 
    required this.ageController, 
    required this.genderController, required this.formKey, 
  });

  final Function() onNext;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController goalController;
  final TextEditingController ageController;
  final TextEditingController genderController;
  final GlobalKey<FormState> formKey;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                TextFieldWithTitle(
                  title: 'Height (cm)',
                  hintText: 'e.g 175',
                  controller: heightController,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                horizontalSpace(context, 12),
                TextFieldWithTitle(
                  title: 'Weight(kg)',
                  hintText: 'e.g 70',
                  controller: weightController,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
            verticalSpace(context, 12),
            Row(
              children: [
                TextFieldWithTitle(
                  title: 'Age',
                  hintText: 'e.g 25',
                  controller: ageController,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                horizontalSpace(context, 12),
                TextFieldWithTitle(
                  title: 'Gender',
                  hintText: 'Male',
                  controller: genderController,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                horizontalSpace(context, 12),
                TextFieldWithTitle(
                  title: 'Goal',
                  hintText: 'weight loss',
                  controller: goalController,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
            verticalSpace(context, 12),
            CustomAppButton(
              onPressed: onNext,
              btnText: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}

class GenerateStep extends StatelessWidget {
  const GenerateStep({
    super.key, 
    required this.onGenerate, 
    required this.activityLevelController, 
    required this.dietaryRestrictionsController, 
    required this.allergiesController, 
    required this.mealPreferencesController,
    required this.supplementsController, required this.formKey});

  final Function() onGenerate;
  final TextEditingController activityLevelController;
  final TextEditingController dietaryRestrictionsController;
  final TextEditingController allergiesController;
  final TextEditingController mealPreferencesController;
  final TextEditingController supplementsController;
  final GlobalKey<FormState> formKey;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                TextFieldWithTitle(
                  title: 'Activity Level',
                  hintText: 'e.g moderate',
                  controller: activityLevelController,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                horizontalSpace(context, 12),
                TextFieldWithTitle(
                  title: 'Dietary Restrictions',
                  hintText: 'e.g vegetarian',
                  controller: dietaryRestrictionsController,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
            verticalSpace(context, 12),
            Row(
              children: [
                TextFieldWithTitle(
                  title: 'Allergies',
                  hintText: 'e.g nuts',
                  controller: allergiesController,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                horizontalSpace(context, 12),
                TextFieldWithTitle(
                  title: 'Meal Preferences',
                  hintText: 'e.g Quick Meals, High Protein',
                  controller: mealPreferencesController,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
            verticalSpace(context, 12),
            TextFieldWithTitle(
              title: 'supplements',
              hintText: 'e.g Vitamin D',
              controller: supplementsController,
              validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
            ),
            verticalSpace(context, 12),
            CustomAppButton(
              onPressed: onGenerate,
              btnText: 'Generate Plan',
            ),
          ],
        ),
      ),
    );
  }
}
