import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/firebase/firebase_options.dart';

import 'app.dart';
import 'core/di/injector.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies();
  runApp(const MyApp());
}