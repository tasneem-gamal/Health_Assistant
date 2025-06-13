import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_circle_item.dart';
import 'package:health_assistant/presentation/controllers/analyze_symptoms/analyze_symptoms_cubit.dart';
import 'package:health_assistant/presentation/controllers/general_chat/general_chat_cubit.dart';
import 'package:health_assistant/presentation/controllers/generate_fitness_plan/generate_fitness_plan_cubit.dart';
import 'package:health_assistant/presentation/controllers/generate_nutrition_plan/generate_nutrition_plan_cubit.dart';
import 'package:health_assistant/presentation/view/widgets/home/analyze_symptoms_bloc_listner.dart';
import 'package:health_assistant/presentation/view/widgets/home/analyze_symptoms_bottom_sheet.dart';
import 'package:health_assistant/presentation/view/widgets/home/chat_app_bar_title.dart';
import 'package:health_assistant/presentation/view/widgets/home/custom_chat.dart';
import 'package:health_assistant/presentation/view/widgets/home/fitness_plan_bottom_sheet.dart';
import 'package:health_assistant/presentation/view/widgets/home/general_chat_bloc_listner.dart';
import 'package:health_assistant/presentation/view/widgets/home/generate_fitness_plan_bloc_listner.dart';
import 'package:health_assistant/presentation/view/widgets/home/nutrition_plan_bloc_listner.dart';
import 'package:health_assistant/presentation/view/widgets/home/nutrition_plan_bottom_sheet.dart';
import 'package:health_assistant/presentation/view/widgets/home/option_card.dart';

class HealthCheckChat extends StatelessWidget {
  const HealthCheckChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AnalyzeSymptomsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<GenerateFitnessPlanCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<GenerateNutritionPlanCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<GeneralChatCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: CustomCircleItem(
            onTap: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorsManager.lightGray,
            ),
          ),
          centerTitle: true,
          titleSpacing: 40.0,
          title: const ChatAppBarTitle(),
          actions: [
            CustomCircleItem(
                icon: const Icon(
                  Icons.more_horiz,
                  color: ColorsManager.lightGray,
                ),
                onTap: () {})
          ],
        ),
        body: const SafeArea(child: HealthCheckChatBody()),
      ),
    );
  }
}

class HealthCheckChatBody extends StatefulWidget {
  const HealthCheckChatBody({super.key});

  @override
  State<HealthCheckChatBody> createState() => _HealthCheckChatBodyState();
}

class _HealthCheckChatBodyState extends State<HealthCheckChatBody> {
  bool showOptions = true;
  final _chatController = InMemoryChatController();

  void handleFocusChanged(bool hasFocus) {
    if (hasFocus && showOptions) {
      setState(() {
        showOptions = false;
      });
    }
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomChat(
          onFocusChanged: handleFocusChanged,
          chatController: _chatController,
        ),
        AnalyzeSymptomsBlocListner(
          chatController: _chatController,
        ),
        GenerateFitnessPlanBlocListner(chatController: _chatController),
        NutritionPlanBlocListner(chatController: _chatController,),
        GeneralChatBlocListner(chatController: _chatController),
        if (showOptions)
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
                      onTap: () {
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
                      },
                    ),
                    horizontalSpace(context, 20),
                    OptionCard(
                        image: 'assets/images/exercise_running.png',
                        title: 'Fitness Plan',
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) => BlocProvider.value(
                                    value: context
                                        .read<GenerateFitnessPlanCubit>(),
                                    child: FitnessPlanBottomSheet(
                                      chatController: _chatController,
                                      onActionDone: () {
                                        setState(() {
                                          showOptions = false;
                                        });
                                      },
                                    ),
                                  ));
                        }),
                  ],
                ),
                verticalSpace(context, 12),
                OptionCard(
                  image: 'assets/images/nutrition.png',
                  title: 'Nutrition Plan',
                  onTap: () {
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
                            ));
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
