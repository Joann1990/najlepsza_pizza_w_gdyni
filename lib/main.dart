import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:najlepsza_pizza_w_gdyni/app/features/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
