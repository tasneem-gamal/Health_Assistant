import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_curved_container.dart';
import 'package:health_assistant/presentation/view/screens/profile/settings_view.dart';
import 'package:health_assistant/presentation/view/widgets/home/app_drawer.dart';
import 'package:health_assistant/presentation/view/widgets/home/start_health_check.dart';
import 'package:health_assistant/presentation/view/widgets/home/mental_health.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.mainColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.sort, color: Colors.white,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
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
            onPressed: (){
              context.push(const SettingsView());
            },
            icon: const Icon(Icons.settings_outlined, color: Colors.white,),
          )
        ],
      ),
      drawer: const AppDrawer(),
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
        const CustomCurvedContainer(
          text: 'Welcome back \nMariam!',
        ),
        verticalSpace(context, 20),
        Text(
          'Your wellness journey ',
          style: CustomTextStyles.font16LightGrayRegular(context),
        ),
        Text(
          'Start Here',
          style: CustomTextStyles.font16LightGrayBold(context).copyWith(color: Colors.black),
        ),
        verticalSpace(context, 20),
        const Divider(
          thickness: 1,
          color: ColorsManager.moreLightGray,
        ),
        Expanded(
          child: ListView(
            children: const [
              StartHealthCheck(),
              MentalHealth()
            ],
          )
        )
      ],
    );
  }
}





