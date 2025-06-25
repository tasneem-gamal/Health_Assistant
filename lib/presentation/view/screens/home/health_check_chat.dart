import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_circle_item.dart';
import 'package:health_assistant/data/models/general_chat/general_chat_request_model.dart';
import 'package:health_assistant/presentation/controllers/analyze_symptoms/analyze_symptoms_cubit.dart';
import 'package:health_assistant/presentation/controllers/general_chat/general_chat_cubit.dart';
import 'package:health_assistant/presentation/controllers/generate_fitness_plan/generate_fitness_plan_cubit.dart';
import 'package:health_assistant/presentation/controllers/generate_nutrition_plan/generate_nutrition_plan_cubit.dart';
import 'package:health_assistant/presentation/view/widgets/home/analyze_symptoms_bloc_listner.dart';
import 'package:health_assistant/presentation/view/widgets/home/analyze_symptoms_bottom_sheet.dart';
import 'package:health_assistant/presentation/view/widgets/home/chat_app_bar_title.dart';
import 'package:health_assistant/presentation/view/widgets/home/chat_options_menu.dart';
import 'package:health_assistant/presentation/view/widgets/home/custom_chat.dart';
import 'package:health_assistant/presentation/view/widgets/home/fitness_plan_bottom_sheet.dart';
import 'package:health_assistant/presentation/view/widgets/home/general_chat_bloc_listner.dart';
import 'package:health_assistant/presentation/view/widgets/home/generate_fitness_plan_bloc_listner.dart';
import 'package:health_assistant/presentation/view/widgets/home/nutrition_plan_bloc_listner.dart';
import 'package:health_assistant/presentation/view/widgets/home/nutrition_plan_bottom_sheet.dart';
import 'package:health_assistant/presentation/view/widgets/home/option_card.dart';

class HealthCheckChat extends StatefulWidget {
  const HealthCheckChat({super.key});

  @override
  State<HealthCheckChat> createState() => _HealthCheckChatState();
}

class _HealthCheckChatState extends State<HealthCheckChat> {
  final _chatController = InMemoryChatController();
  bool showOptions = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AnalyzeSymptomsCubit>()),
        BlocProvider(create: (_) => getIt<GenerateFitnessPlanCubit>()),
        BlocProvider(create: (_) => getIt<GenerateNutritionPlanCubit>()),
        BlocProvider(create: (_) => getIt<GeneralChatCubit>()),
      ],
      child: Builder(
        builder: (context) {
          void openAnalyzeBottomSheet() {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => BlocProvider.value(
                value: context.read<AnalyzeSymptomsCubit>(),
                child: AnalyzeSymptomsBottomSheet(
                  chatController: _chatController,
                  onActionDone: () {
                    setState(() {
                      showOptions = false;
                    });
                  },
                ),
              ),
            );
          }

          void openFitnessBottomSheet() {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => BlocProvider.value(
                value: context.read<GenerateFitnessPlanCubit>(),
                child: FitnessPlanBottomSheet(
                  chatController: _chatController,
                  onActionDone: () {
                    setState(() {
                      showOptions = false;
                    });
                  },
                ),
              ),
            );
          }

          void openNutritionBottomSheet() {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => BlocProvider.value(
                value: context.read<GenerateNutritionPlanCubit>(),
                child: NutritionPlanBottomSheet(
                  chatController: _chatController,
                  onActionDone: () {
                    setState(() {
                      showOptions = false;
                    });
                  },
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: CustomCircleItem(
                onTap: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: ColorsManager.lightGray),
              ),
              centerTitle: true,
              titleSpacing: 40.0,
              title: const ChatAppBarTitle(),
              actions: [
                ChatOptionsMenu(
                  optionOne: openAnalyzeBottomSheet,
                  optionTwo: openFitnessBottomSheet,
                  optionThree: openNutritionBottomSheet,
                  optionOneImage: 'assets/images/symptom.png',
                  optionOneTitle: 'Analyze symptoms',
                  optionTwoImage: 'assets/images/exercise_running.png',
                  optionTwoTitle: 'Fitness Plan',
                  optionThreeImage: 'assets/images/nutrition.png',
                  optionThreeTitle: 'Fitness Plan',
                )
              ],
            ),
            body: SafeArea(
              child: HealthCheckChatBody(
                chatController: _chatController,
                showOptions: showOptions,
                onAnalyze: openAnalyzeBottomSheet,
                onFitnessPlan: openFitnessBottomSheet,
                onNutritionPlan: openNutritionBottomSheet,
                hideOptions: () {
                  setState(() {
                    showOptions = false;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}


class HealthCheckChatBody extends StatefulWidget {
  const HealthCheckChatBody({
    super.key,
    required this.chatController,
    required this.showOptions,
    required this.onAnalyze,
    required this.onFitnessPlan,
    required this.onNutritionPlan,
    required this.hideOptions,
  });

  final InMemoryChatController chatController;
  final bool showOptions;
  final VoidCallback onAnalyze;
  final VoidCallback onFitnessPlan;
  final VoidCallback onNutritionPlan;
  final VoidCallback hideOptions;

  @override
  State<HealthCheckChatBody> createState() => _HealthCheckChatBodyState();
}

class _HealthCheckChatBodyState extends State<HealthCheckChatBody> {
  void handleFocusChanged(bool hasFocus) {
    if (hasFocus && widget.showOptions) {
      widget.hideOptions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomChat(
          onFocusChanged: handleFocusChanged,
          chatController: widget.chatController,
          onSend: (text, rawHistory) {
            final history = (rawHistory as List<TextMessage>)
                .map((msg) => [msg.authorId == 'user1' ? 'user' : 'assistant', msg.text])
                .toList();
            final requestModel = GeneralChatRequestModel(message: text, history: history, userId: FirebaseAuth.instance.currentUser!.uid);
            context.read<GeneralChatCubit>().generalChat(requestModel);
          },
        ),
        AnalyzeSymptomsBlocListner(chatController: widget.chatController),
        GenerateFitnessPlanBlocListner(chatController: widget.chatController),
        NutritionPlanBlocListner(chatController: widget.chatController),
        GeneralChatBlocListner(chatController: widget.chatController),
        if (widget.showOptions)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OptionCard(
                      image: 'assets/images/symptom.png',
                      title: 'Analyze Symptoms',
                      onTap: widget.onAnalyze,
                    ),
                    horizontalSpace(context, 20),
                    OptionCard(
                      image: 'assets/images/exercise_running.png',
                      title: 'Fitness Plan',
                      onTap: widget.onFitnessPlan,
                    ),
                  ],
                ),
                verticalSpace(context, 12),
                OptionCard(
                  image: 'assets/images/nutrition.png',
                  title: 'Nutrition Plan',
                  onTap: widget.onNutritionPlan,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
