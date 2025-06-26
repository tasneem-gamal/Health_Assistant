import 'package:firebase_auth/firebase_auth.dart';
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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? userId;

  @override
void initState() {
  super.initState();
  loadUserId();
}

Future<void> loadUserId() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid != null) {
    setState(() {
      userId = uid;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.mainColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.sort, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'Health Assistant',
          style: CustomTextStyles.font24WhiteMedium(context).copyWith(
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [Colors.white, ColorsManager.mainColorLight],
              ).createShader(const Rect.fromLTWH(200.0, 0.0, 50.0, 0.0)),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.push(const SettingsView());
            },
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
          ),
        ],
      ),
      drawer: AppDrawer(userId: userId!), 
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
        CustomCurvedContainer(
          text: 'Welcome back \n${FirebaseAuth.instance.currentUser?.displayName ?? "Name"}!',
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





