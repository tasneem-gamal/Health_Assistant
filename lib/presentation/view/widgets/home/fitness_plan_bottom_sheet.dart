import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/data/models/generate_fitness_plan/generate_fitness_plan_request_model.dart';
import 'package:health_assistant/presentation/controllers/generate_fitness_plan/generate_fitness_plan_cubit.dart';
import 'package:health_assistant/presentation/view/widgets/home/custom_drop_down_with_title.dart';
import 'package:health_assistant/presentation/view/widgets/home/text_field_with_title.dart';


class FitnessPlanBottomSheet extends StatefulWidget {
  const FitnessPlanBottomSheet({super.key, required this.onActionDone, required this.chatController});
  final VoidCallback onActionDone;
  final InMemoryChatController chatController;

  @override
  State<FitnessPlanBottomSheet> createState() => _FitnessPlanBottomSheetState();
}

class _FitnessPlanBottomSheetState extends State<FitnessPlanBottomSheet> {
  int currentStep = 1;
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final fitnessLevelController = TextEditingController();
  final sessionsPerWeekController = TextEditingController();
  final sessionDurationController = TextEditingController();
  final equipmentController = TextEditingController();
  final fitnessGoalController = TextEditingController();
  final limitationsController = TextEditingController();

  final _step1FormKey = GlobalKey<FormState>();
  final _step2FormKey = GlobalKey<FormState>();


  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    genderController.dispose();
    fitnessLevelController.dispose();
    sessionsPerWeekController.dispose();
    sessionDurationController.dispose();
    equipmentController.dispose();
    fitnessGoalController.dispose();
    limitationsController.dispose();
    super.dispose();
  }

  void generatePlan() {
    final model = GenerateFitnessPlanRequestModel(
      height: int.tryParse(heightController.text) ?? 0,
      weight: int.tryParse(weightController.text) ?? 0,
      age: int.tryParse(ageController.text) ?? 0,
      gender: genderController.text,
      fitnessLevel: fitnessLevelController.text,
      fitnessGoal: fitnessGoalController.text,
      sessionsPerWeek: int.tryParse(sessionsPerWeekController.text) ?? 0,
      sessionDuration: int.tryParse(sessionDurationController.text) ?? 0,
      limitations: limitationsController.text,
      equipment: equipmentController.text
          .split(',')
          .map((e) => e.trim())
          .toList(),
      medicalConditions: [], 
    );
    final userMessage =
        """
        Height: ${model.height}
        Weight: ${model.weight}
        Age: ${model.age}
        Gender: ${model.gender}
        fitnessLevel: ${model.fitnessLevel}
        fitnessGoal: ${model.fitnessGoal}
        sessionsPerWeek: ${model.sessionsPerWeek}
        sessionDuration: ${model.sessionDuration}
        limitations: ${model.limitations}
        equipment: ${model.equipment}
        """;
    widget.chatController.insertMessage(
      TextMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        authorId: 'user1',
        createdAt: DateTime.now().toUtc(),
        text: userMessage,
      ),
    );
    context.read<GenerateFitnessPlanCubit>().generateFitnessPlan(model);
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
                  ageController: ageController,
                  genderController: genderController,
                  fitnessLevelController: fitnessLevelController,
                ),
              ] else if (currentStep == 2) ...[
                GenerateStep(
                  formKey: _step2FormKey,
                  onGenerate: () {
                    if(_step2FormKey.currentState!.validate()){
                      generatePlan();
                    }
                    
                  },
                  sessionsPerWeekController: sessionsPerWeekController,
                  sessionDurationController: sessionDurationController,
                  equipmentController: equipmentController,
                  fitnessGoalController: fitnessGoalController,
                  limitationsController: limitationsController,
                ),
              ] 
            ],
          ),
        ),
      ),
    );
  }
}

class NextStep extends StatefulWidget {
  const NextStep({
    super.key, 
    required this.onNext, 
    required this.heightController, 
    required this.weightController, 
    required this.ageController, 
    required this.genderController, 
    required this.fitnessLevelController, required this.formKey
  });

  final Function() onNext;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController ageController;
  final TextEditingController genderController;
  final TextEditingController fitnessLevelController;
  final GlobalKey<FormState> formKey;

  @override
  State<NextStep> createState() => _NextStepState();
}

class _NextStepState extends State<NextStep> {

  String? selectedGender;
  String? selectedFitnessLevel;

  final List<String> genderOptions = ['Male', 'Female'];
  final List<String> fitnessLevelOptions = ['Beginner', 'Intermediate', 'Advanced'];

    @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Row(
              children: [
                TextFieldWithTitle(
                  title: 'Height (cm)',
                  hintText: 'e.g 175',
                  controller: widget.heightController,
                  keyboardType: TextInputType.number,
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
                  keyboardType: TextInputType.number,
                  controller: widget.weightController,
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
                  keyboardType: TextInputType.number,
                  controller: widget.ageController,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                horizontalSpace(context, 12),
                Expanded(
                  child: CustomDropdownWithTitle(
                    title: 'Gender',
                    items: genderOptions,
                    value: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                        widget.genderController.text = value ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
                horizontalSpace(context, 12),
                Expanded(
                  child: CustomDropdownWithTitle(
                    title: 'Fitness Level',
                    items: fitnessLevelOptions,
                    value: selectedFitnessLevel,
                    onChanged: (value) {
                      setState(() {
                        selectedFitnessLevel = value;
                        widget.fitnessLevelController.text = value ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            verticalSpace(context, 12),
            CustomAppButton(
              onPressed: widget.onNext,
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
    required this.sessionsPerWeekController, 
    required this.sessionDurationController, 
    required this.equipmentController, 
    required this.fitnessGoalController, 
    required this.limitationsController, required this.formKey
  });

  final Function() onGenerate;
  final TextEditingController sessionsPerWeekController;
  final TextEditingController sessionDurationController;
  final TextEditingController equipmentController;
  final TextEditingController fitnessGoalController;
  final TextEditingController limitationsController;
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
                  title: 'Sessions per Week',
                  hintText: 'e.g 3',
                  controller: sessionsPerWeekController,
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                horizontalSpace(context, 12),
                TextFieldWithTitle(
                  title: 'Session Duration (min)',
                  hintText: 'e.g 20min',
                  controller: sessionDurationController,
                  keyboardType: TextInputType.number,
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
                  title: 'Equipments',
                  hintText: 'e.g resistance bands, bodyweight ...',
                  controller: equipmentController,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                horizontalSpace(context, 12),
                TextFieldWithTitle(
                  title: 'Fitness Goal',
                  hintText: 'e.g weight loss',
                  controller: fitnessGoalController,
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
              title: 'Physical Limitations/Injuries',
              hintText: '',
              controller: limitationsController,
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
