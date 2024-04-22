import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerenciador/models/answer_model.dart';
import 'package:gerenciador/models/child_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:gerenciador/views/home/home_view.dart';

import 'adapters/answer_adapter.dart';
import 'adapters/children_adapter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDir.path);

  // String boxName = 'db';
  // Future<bool> boxExists = Hive.boxExists(boxName);
  // if (await boxExists) {
  //   // A caixa existe
  //   print('A caixa existe');
  //   await Hive.deleteBoxFromDisk(boxName);
  // } else {
  //   // A caixa não existe
  //   print('A caixa não existe');
  // }

  // Registro dos adaptadores
  Hive.registerAdapter(ChildrenAdapter());
  //Hive.registerAdapter(AnswersAdapter());


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box boxChildren;
  late Box boxAnswers;

  @override
  void initState() {
    super.initState();
    _initHiveBox();
  }

  Future<void> _initHiveBox() async {
    try {
      boxChildren = await Hive.openBox('childrens');
      // boxChildren.clear();
      // var children1 = Children(
      //   name: 'Pedro Henrique da Silva', age: 8, sex: 'masculino', responsible: 'Roberta de Oliveira Juliano da Silva', risk: 'Médio', punctuation: 0.35,
      // );
      // var children2 = Children(
      //   name: 'Maria Henrique da Silva', age: 8, sex: 'masculino', responsible: 'Roberta de Oliveira Juliano da Silva', risk: 'Médio', punctuation: 0.35
      // );
      // var children3 = Children(
      //   name: 'João Henrique', age: 8, sex: 'masculino', responsible: 'Roberta de Oliveira Juliano da Silva', risk: 'Médio', punctuation: 0.35
      // );
      //
      // await boxChildren.add(children1);
      // await boxChildren.add(children2);
      // await boxChildren.add(children3);

      // boxAnswers = await Hive.openBox('answers');
      // boxAnswers.clear();
      // var answer1 = Answer(
      //     fkchildren: 1, dateregister: '10/10/2020', kinship: 'Pai', name: 'Roberto Gomes Aparecido Da Silva', risk: 'Médio', punctuation: 0.35
      // );
      // var answer2 = Answer(
      //     fkchildren: 1, dateregister: '10/09/2020', kinship: 'Pai', name: 'Alice Da Silva', risk: 'Médio', punctuation: 0.25
      // );
      // var answer3 = Answer(
      //     fkchildren: 2, dateregister: '10/10/2020', kinship: 'Mãe', name: 'Juliana Oliveira', risk: 'Médio', punctuation: 0.35
      // );
      //
      // await boxAnswers.add(answer1);
      // await boxAnswers.add(answer2);
      // await boxAnswers.add(answer3);

      List<Children> childrenList = boxChildren.values.toList().cast<Children>();
      // List<Answer> answerList = boxAnswers.values.toList().cast<Answer>();

      for (var child in childrenList) {
        print('{ ${child.name}, ${child.age}, ${child.sex}, ${child.responsible}, ${child.risk}, ${child.punctuation}}');
      }
      //print(answerList);
    } catch (e) {
      print('Erro ao inicializar a caixa Hive: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador Autismo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
      await boxChildren.close();
      //await boxAnswers.close();
      await Hive.close();
    } catch (e) {
      print('Erro ao fechar a caixa Hive: $e');
    }
  }
}
