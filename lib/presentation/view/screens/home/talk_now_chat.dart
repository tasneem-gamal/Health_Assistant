import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_circle_item.dart';
import 'package:health_assistant/presentation/view/screens/home/mood_assessment.dart';
import 'package:health_assistant/presentation/view/widgets/home/chat_app_bar_title.dart';
import 'package:health_assistant/presentation/view/widgets/home/custom_chat.dart';
import 'package:health_assistant/presentation/view/widgets/home/mood_progress.dart';
import 'package:health_assistant/presentation/view/widgets/home/option_card.dart';

class TalkNowChat extends StatelessWidget {
  const TalkNowChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: CustomCircleItem(
          onTap:() {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back, color: ColorsManager.lightGray,),
        ),
        centerTitle: true,
        titleSpacing: 40.0,
        title: const ChatAppBarTitle(),
        actions: [
          CustomCircleItem(
            icon: const Icon(Icons.more_horiz, color: ColorsManager.lightGray,), 
            onTap: (){}
          )
        ],
      ),
      body: const SafeArea(child: TalkNowChatBody()),
    );
  }
}

class TalkNowChatBody extends StatefulWidget {
  const TalkNowChatBody({super.key});

  @override
  State<TalkNowChatBody> createState() => _TalkNowChatBodyState();
}

class _TalkNowChatBodyState extends State<TalkNowChatBody> {
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
        CustomChat(onFocusChanged: handleFocusChanged),
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
                        onTap: (){
                          context.push(const MoodAssessment());
                        }
                      ),
                    ),
                    horizontalSpace(context, 12),
                    Expanded(
                      child: OptionCard(
                        image: 'assets/images/anxiety.png', 
                        title: '   Anxiety Assessment', 
                        onTap: (){}
                      ),
                    ),
                    horizontalSpace(context, 12),
                    Expanded(
                      child: OptionCard(
                        image: 'assets/images/adjustment.png', 
                        title: 'Adjustment Assessment', 
                        onTap: (){}
                      ),
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


