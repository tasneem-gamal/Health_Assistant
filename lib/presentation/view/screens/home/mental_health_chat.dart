import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_circle_item.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_request_model.dart';
import 'package:health_assistant/data/models/mental_health_chat/mental_health_response_model.dart';
import 'package:health_assistant/firebase_database.dart';
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
import 'package:uuid/uuid.dart';

class MentalHealthChat extends StatefulWidget {
  const MentalHealthChat({super.key, this.historyId, required this.hideOptionsAtStart});
  final String? historyId;
  final bool hideOptionsAtStart; 

  @override
  State<MentalHealthChat> createState() => _MentalHealthChatState();
}

class _MentalHealthChatState extends State<MentalHealthChat> {
  final _chatController = InMemoryChatController();
  bool showOptions = true;
  String? sessionId;



  @override
  void initState() {
    super.initState();
    showOptions = !widget.hideOptionsAtStart;
    if (widget.historyId != null) {
      Future.microtask(() async {
        sessionId = await loadOldMessagesFromFirestore(widget.historyId!);
        setState(() {});
      });
    }
  }


final uuid = const Uuid();

Future<String?> loadOldMessagesFromFirestore(String historyId) async {
  final doc = await secondaryFirestore.collection('chat_history').doc(historyId).get();
  if (doc.exists) {
    final data = doc.data()!;

    final messages = <TextMessage>[];

    final historyList = data['history'] as List<dynamic>?;

    if (historyList != null && historyList.isNotEmpty) {
      for (var item in historyList) {
        if (item is Map<String, dynamic>) {
          if (item.containsKey('user')) {
            final userText = item['user'] as String?;
            if (userText != null && userText.isNotEmpty) {
              messages.add(TextMessage(
                id: uuid.v4(),
                authorId: 'user1',
                text: userText,
              ));
            }
          }
          if (item.containsKey('assistant')) {
            final assistantText = item['assistant'] as String?;
            if (assistantText != null && assistantText.isNotEmpty) {
              messages.add(TextMessage(
                id: uuid.v4(),
                authorId: 'HealthAssistant',
                text: assistantText,
              ));
            }
          }
        }
      }
    }

    await _chatController.setMessages(messages);

    final sessionId = data['session_id'] as String?;
    return sessionId;
  }

  return null;
}



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MentalHealthChatCubit>(),
      child: Builder(
        builder: (context) {
          
          void openMoodAssessment() {
            context.push(MoodAssessment(
              sessionId: sessionId,
              chatController: _chatController,
              mentalHealthChatCubit: context.read<MentalHealthChatCubit>(),
              onFinish: () {
                
              },
            ));
          }

          void openAnxietyAssessment() {
            context.push(AnxietyAssessment(
              sessionId: sessionId,
              chatController: _chatController,
              mentalHealthChatCubit: context.read<MentalHealthChatCubit>(),
              onFinish: () {
                
              }
            ));
          }

          void openAdjustmentAssessment() {
            context.push(AdjustmentAssessment(
              sessionId: sessionId,
              chatController: _chatController,
              mentalHealthChatCubit: context.read<MentalHealthChatCubit>(),
              onFinish: () {
                
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
                historyId: widget.historyId,
                initialShowOptions: showOptions,
                sessionId: sessionId,
                hideOptions: (){
                  
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
  const MentalHealthChatBody(
      {super.key,
      required this.onMoodAssessment,
      required this.onAnxietyAssessment,
      required this.onadjustmentAssessment,
      required this.hideOptions,
      required this.chatController, this.historyId, required this.initialShowOptions, this.sessionId});
  final VoidCallback onMoodAssessment;
  final VoidCallback onAnxietyAssessment;
  final VoidCallback onadjustmentAssessment;
  final VoidCallback hideOptions;
  final InMemoryChatController chatController;
  final String? historyId;
  final bool initialShowOptions; 
  final String? sessionId;

  @override
  State<MentalHealthChatBody> createState() => _MentalHealthChatBodyState();
}

class _MentalHealthChatBodyState extends State<MentalHealthChatBody> {
  bool showOptions = true;
  bool showMoodProgress = false;
  MentalHealthResponseModel? moodInfo;


  @override
  void initState() {
    super.initState();
    showOptions = widget.initialShowOptions;
  }


  void updateMoodProgress(MentalHealthResponseModel info) {
  setState(() {
    showOptions = false;
    showMoodProgress = true;
    moodInfo = info;
  });
}

  void handleFocusChanged(bool hasFocus) {
    if (hasFocus && (showOptions || showMoodProgress)) {
      setState(() {
        showOptions = false;
        showMoodProgress = false;
      });
    }
  }

  void hideOverlaysImmediately() {
    setState(() {
      showOptions = false;
      showMoodProgress = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomChat(
          onFocusChanged: handleFocusChanged,
          chatController: widget.chatController,
          onSend: (text, rawHistory) {
            hideOverlaysImmediately();
            final history = widget.chatController.messages
                .whereType<TextMessage>()
                .map((msg) =>
                    {msg.authorId == 'user1' ? 'user' : 'assistant': msg.text})
                .toList();

            final requestModel = MentalHealthRequestModel(
                message: text,
                sessionId: widget.sessionId ?? '',
                history: history,
                userId: FirebaseAuth.instance.currentUser!.uid,
                historyId: widget.historyId);


            context
                .read<MentalHealthChatCubit>()
                .mentalHealthChat(requestModel);
          },
        ),
        MentalHealthChatBlocListner(
          hideOverlays: hideOverlaysImmediately,
          chatController: widget.chatController,
          onMoodAnalyzed: (info) {
            print("INFO: ${info.emotionData}");
            updateMoodProgress(info);
          },
        ),
        if (showOptions || showMoodProgress)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 24, right: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showMoodProgress && moodInfo != null)
                    MoodProgress(
                      info: moodInfo!,
                      onCancel: () {
                        setState(() {
                          showMoodProgress = false;
                        });
                      },
                    ),
                  if (showOptions) ...[
                    verticalSpace(context, 30),
                    Row(
                      children: [
                        Expanded(
                          child: OptionCard(
                            image: 'assets/images/neutral.png',
                            title: 'Mood Assessment',
                            onTap: widget.onMoodAssessment,
                          ),
                        ),
                        horizontalSpace(context, 12),
                        Expanded(
                          child: OptionCard(
                            image: 'assets/images/anxiety.png',
                            title: 'Anxiety Assessment',
                            onTap: widget.onAnxietyAssessment,
                          ),
                        ),
                        horizontalSpace(context, 12),
                        Expanded(
                          child: OptionCard(
                            image: 'assets/images/adjustment.png',
                            title: 'Adjustment Assessment',
                            onTap: widget.onadjustmentAssessment,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}
