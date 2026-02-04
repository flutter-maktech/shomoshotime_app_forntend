import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shomoshotime/firebase_options.dart';
import 'package:shomoshotime/management.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(Management());
}
