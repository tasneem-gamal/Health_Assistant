import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_circle_item.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_request_model.dart';
import 'package:health_assistant/presentation/controllers/mental_health_chat/mental_health_chat_cubit.dart';
import 'package:health_assistant/presentation/view/screens/home/adjustment_assessment.dart';
import 'package:health_assistant/presentation/view/screens/home/anxiety_assessment.dart';
import 'package:health_assistant/presentation/view/screens/home/mood_assessment.dart';
import 'package:health_assistant/presentation/view/widgets/home/chat_app_bar_title.dart';
import 'package:health_assistant/presentation/view/widgets/home/chat_options_menu.dart';
import 'package:health_assistant/presentation/view/widgets/home/custom_chat.dart';
import 'package:health_assistant/presentation/view/widgets/home/mental_health_chat_bloc_listner.dart';
import 'package:health_assistant/presentation/view/widgets/home/mood_progress.dart';
import 'package:health_assistant/presentation/view/widgets/home/option_card.dart';

class MentalHealthChat extends StatefulWidget {
  const MentalHealthChat({super.key});

  @override
  State<MentalHealthChat> createState() => _MentalHealthChatState();
}

class _MentalHealthChatState extends State<MentalHealthChat> {
  final _chatController = InMemoryChatController();
  bool showOptions = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MentalHealthChatCubit>(),
      child: Builder(
        builder: (context) {
          
          void openMoodAssessment() {
            context.push(MoodAssessment(
              chatController: _chatController,
              mentalHealthChatCubit: context.read<MentalHealthChatCubit>(),
              onFinish: () {
                setState(() {
                  showOptions = false;
                });
              },
            ));
          }

          void openAnxietyAssessment() {
            context.push(AnxietyAssessment(
              chatController: _chatController,
              mentalHealthChatCubit: context.read<MentalHealthChatCubit>(),
              onFinish: () {
                setState(() {
                  showOptions = false;
                });
              },
            ));
          }

          void openAdjustmentAssessment() {
            context.push(AdjustmentAssessment(
              chatController: _chatController,
              mentalHealthChatCubit: context.read<MentalHealthChatCubit>(),
              onFinish: () {
                setState(() {
                  showOptions = false;
                });
              },
            ));
          }

          return Scaffold(
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
                ChatOptionsMenu(
                  optionOne: openMoodAssessment,
                  optionTwo: openAnxietyAssessment,
                  optionThree: openAdjustmentAssessment,
                  optionOneImage: 'assets/images/neutral.png',
                  optionOneTitle: 'Mood Assessment',
                  optionTwoImage: 'assets/images/anxiety.png',
                  optionTwoTitle: 'Anxiety Assessment',
                  optionThreeImage: 'assets/images/adjustment.png',
                  optionThreeTitle: 'Adjustment Assessment',
                )
              ],
            ),
            body: SafeArea(
              child: MentalHealthChatBody(
                onMoodAssessment: openMoodAssessment,
                onAnxietyAssessment: openAnxietyAssessment,
                onadjustmentAssessment: openAdjustmentAssessment,
                chatController: _chatController,
                hideOptions: (){
                  setState(() {
                    showOptions = false;
                  });
                },
              )
            ),
          );
        },
      ),
    );
  }
}

class MentalHealthChatBody extends StatefulWidget {
  const MentalHealthChatBody({super.key, 
  required this.onMoodAssessment, 
  required this.onAnxietyAssessment, 
  required this.onadjustmentAssessment, 
  required this.hideOptions, required this.chatController});
  final VoidCallback onMoodAssessment;
  final VoidCallback onAnxietyAssessment;
  final VoidCallback onadjustmentAssessment;
  final VoidCallback hideOptions;
  final InMemoryChatController chatController;
  
  @override
  State<MentalHealthChatBody> createState() => _MentalHealthChatBodyState();
}

class _MentalHealthChatBodyState extends State<MentalHealthChatBody> {
  bool showOptions = true;
  

  void handleFocusChanged(bool hasFocus) {
    if (hasFocus && showOptions) {
      setState(() {
        showOptions = false;
      });
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
                .map((msg) =>
                    {msg.authorId == 'user1' ? 'user' : 'assistant': msg.text})
                .toList();

            final requestModel = MentalHealthRequestModel(
                message: text, sessionId: 'sessionId', history: history);
            
            context.read<MentalHealthChatCubit>().mentalHealthChat(requestModel);
          },
        ),
        MentalHealthChatBlocListner(chatController: widget.chatController),
        if (showOptions)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 24,
            right: 24,
            child: Column(
              children: [
                const MoodProgress(
                  progress: 0.3,
                  mood: 'Negative',
                ),
                verticalSpace(context, 30),
                Row(
                  children: [
                    Expanded(
                      child: OptionCard(
                          image: 'assets/images/neutral.png',
                          title: 'Mood Assessment',
                          onTap: widget.onMoodAssessment
                        ),
                    ),
                    horizontalSpace(context, 12),
                    Expanded(
                      child: OptionCard(
                          image: 'assets/images/anxiety.png',
                          title: '   Anxiety Assessment',
                          onTap: widget.onAnxietyAssessment),
                    ),
                    horizontalSpace(context, 12),
                    Expanded(
                      child: OptionCard(
                          image: 'assets/images/adjustment.png',
                          title: 'Adjustment Assessment',
                          onTap: widget.onadjustmentAssessment),
                    )
                  ],
                )
              ],
            ),
          )
      ],
    );
  }
}
