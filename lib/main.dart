import 'package:flutter/material.dart';
import 'package:my_app_c1/screens/act1.dart';
import 'package:my_app_c1/screens/act2.dart';
import 'package:my_app_c1/screens/act3.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App C1',
      initialRoute: '/',  
      routes: {
        '/': (context) => WelcomeScreen(),
        '/act1': (context) => Act1(),
        '/act2': (context) => Act2(),
        '/act3': (context) => Act3()
      },
    );
  }
}