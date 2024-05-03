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
  Hive.registerAdapter(AnswersAdapter());


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late Box boxChildrens;
  // late Box boxAnswers;

  @override
  void initState() {
    super.initState();
    //_initHiveBox();
  }

  Future<void> _initHiveBox() async {
    List<ChildrenModal> childrenList = [];
    List<AnswerModal> answerList = [];

    //try {
      //boxChildrens = await Hive.openBox('childrens');
      //print(boxChildrens.values);
      //boxChildrens.clear();
      //print(boxChildrens.values);

      // var children1 = Children(
      //   id: '1', name: 'Pedro Henrique da Silva', age: 8, sex: 'masculino', responsible: 'Roberta de Oliveira Juliano da Silva', risk: 'Médio', punctuation: 0.35,
      // );
      // var children2 = Children(
      //     id: '2', name: 'Maria Henrique da Silva', age: 8, sex: 'masculino', responsible: 'Roberta de Oliveira Juliano da Silva', risk: 'Médio', punctuation: 0.35
      // );
      // var children3 = Children(
      //     id: '3', name: 'João Henrique', age: 8, sex: 'masculino', responsible: 'Roberta de Oliveira Juliano da Silva', risk: 'Médio', punctuation: 0.35
      // );

      //await boxChildrens.add(children1);
      //await boxChildrens.add(children2);
      //await boxChildrens.add(children3);

      //boxAnswers = await Hive.openBox('answers');
      //boxAnswers.clear();
      // var answer1 = Answer(
      //     id: '1', fkchildren: '1', dateregister: '10/10/2020', kinship: 'Pai', name: 'Roberto Gomes Aparecido Da Silva', risk: 'Médio', punctuation: 0.35
      // );
      // var answer2 = Answer(
      //     id: '2', fkchildren: '1', dateregister: '10/09/2020', kinship: 'Pai', name: 'Alice Da Silva', risk: 'Médio', punctuation: 0.25
      // );
      // var answer3 = Answer(
      //     id: '3', fkchildren: '2', dateregister: '10/10/2020', kinship: 'Mãe', name: 'Juliana Oliveira', risk: 'Médio', punctuation: 0.35
      // );

      //await boxAnswers.add(answer1);
      //await boxAnswers.add(answer2);
      // await boxAnswers.add(answer3);

      //childrenList = boxChildrens.values.toList().cast<Children>();
      //answerList = boxAnswers.values.toList().cast<Answer>();

      // for (var child in childrenList) {
      //   print('{${child.id}, ${child.name}, ${child.age}, ${child.sex}, ${child.responsible}, ${child.risk}, ${child.punctuation}}');
      // }
      // print('-------------');
      // for (var a in answerList) {
      //   print('{ ${a.id}, ${a.dateregister}, ${a.kinship}, ${a.name}, ${a.risk}, ${a.punctuation}}');
      // }

    // } catch (e) {
    //    print('Erro ao inicializar a caixa Hive: $e');
    // }finally{
    //   await boxChildrens.close();
      //await boxAnswers.close();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador Autismo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF148174)),
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
      print('Erro ao fechar a caixa Hive: $e');
    }
  }
}
