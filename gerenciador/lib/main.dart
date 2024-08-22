import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:gerenciador/views/home/home_view.dart';

import 'adapters/answer_adapter.dart';
import 'adapters/children_adapter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ChildrenAdapter());
  Hive.registerAdapter(AnswersAdapter());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box boxChildrens;
  late Box boxAnswers;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador Autismo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF23645D)),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
      },
      initialRoute: "/",
    );
  }

  @override
  void dispose() async{
    _closeHiveBox();
    super.dispose();
  }

  Future<void> _closeHiveBox() async {
    try {
      await Hive.close();
    } catch (e) {
      throw Exception(e);
    }
  }
}
