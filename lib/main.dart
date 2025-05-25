import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/core/utils/constants.dart';
import 'package:health_assistant/core/utils/shared_preference_helper.dart';
import 'package:health_assistant/firebase_options.dart';
import 'package:health_assistant/health_assistant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setUpGetIt();
  bool isLoggedIn = await checkIfLoggedInUser();
  runApp(HealthAssistant(isLoggedIn: isLoggedIn,));
}

Future<bool> checkIfLoggedInUser() async {
  String? uid = await SharedPreferenceHelper.getUid();
  if (uid != null && uid.isNotEmpty) {
    Constants.isLoggedIn = true;
    return true;
  } else {
    Constants.isLoggedIn = false;
    return false;
  }
}
