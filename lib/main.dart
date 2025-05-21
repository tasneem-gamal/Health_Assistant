import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_assistant/core/di/dependency_injection.dart';
import 'package:health_assistant/firebase_options.dart';
import 'package:health_assistant/health_assistant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpGetIt();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HealthAssistant());
}


