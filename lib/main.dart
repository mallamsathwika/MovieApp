import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_project/colors.dart';
import 'package:tmdb_project/screens/login_screen.dart';
//import 'package:tmdb_project/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
      ),
      home: const Login(),
    );
  }
}
