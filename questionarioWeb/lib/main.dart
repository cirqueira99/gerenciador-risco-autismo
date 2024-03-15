import 'package:flutter/material.dart';
import 'package:questionario/views/home.dart';
import 'package:questionario/views/questionario.dart';
import 'package:questionario/views/resultado.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/questionario': (context) => const QuizPage(),
        '/resultado': (context) => const ResultPage()
      },
      initialRoute: "/questionario",
    );
  }
}
