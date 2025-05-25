import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/widgets/custom_curved_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.mainColor,
        elevation: 0,
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.sort, color: Colors.white,),
        ),
        title: Text(
          'Health Assistant',
            style: CustomTextStyles.font24WhiteMedium(context).copyWith(
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: <Color>[
                    Colors.white,
                    ColorsManager.mainColorLight
                  ],
                ).createShader(const Rect.fromLTWH(200.0, 0.0, 50.0, 0.0)),
            )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.settings_outlined, color: Colors.white,),
          )
        ],
      ),
      body: const HomeViewBody(),
    );
  }
}

class HomeViewBody  extends StatelessWidget {
  const HomeViewBody ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCurvedContainer()
      ],
    );
  }
}

