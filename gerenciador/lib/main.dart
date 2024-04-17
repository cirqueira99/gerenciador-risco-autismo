import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:gerenciador/views/home/home_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDir.path);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box box;

  @override
  void initState() {
    super.initState();
    _initHiveBox();
  }

  Future<void> _initHiveBox() async {
    try {
      box = await Hive.openBox('db');
      // box.clear();
      // box.put('childrens', [
      //   {
      //     'id': 1, 'nome': 'Pedro Henrique da Silva', 'idade': 8, 'sexo': 'masculino', 'responsavel': 'Roberta de Oliveira Juliano da Silva', 'medresults': 0.35
      //   },
      //   {
      //     'id': 2, 'nome': 'Maria Henrique da Silva', 'idade': 8, 'sexo': 'masculino', 'responsavel': 'Roberta de Oliveira Juliano da Silva', 'medresults': 0.35
      //   },
      //   {
      //     'id': 3, 'nome': 'João Henrique', 'idade': 8, 'sexo': 'masculino', 'responsavel': 'Roberta de Oliveira Juliano da Silva', 'medresults': 0.35
      //   }
      // ]
      // );
      // box.put('answers', [
      //   {'idReg': 1, 'idCh': 1, 'data': '10/10/2020', 'parentesco': 'Pai', 'nome': 'Roberto Gomes Aparecido Da Silva', 'result': 'Risco Médio', 'punctuation': 0.55},
      //   {'idReg': 2, 'idCh': 1, 'data': '10/10/2020', 'parentesco': 'Pai', 'nome': 'Roberto Gomes Aparecido Da Silva', 'result': 'Risco Médio', 'punctuation': 0.25},
      //   {'idReg': 3, 'idCh': 2, 'data': '10/10/2020', 'parentesco': 'Pai', 'nome': 'Roberto Gomes Aparecido Da Silva', 'result': 'Risco Médio', 'punctuation': 0.15},
      //   {'idReg': 4, 'idCh': 2, 'data': '10/10/2020', 'parentesco': 'Pai', 'nome': 'Roberto Gomes Aparecido Da Silva', 'result': 'Risco Médio', 'punctuation': 0.35},
      //   {'idReg': 5, 'idCh': 3, 'data': '10/10/2020', 'parentesco': 'Pai', 'nome': 'Roberto Gomes Aparecido Da Silva', 'result': 'Risco Médio', 'punctuation': 0.55},
      //   {'idReg': 6, 'idCh': 4, 'data': '10/10/2020', 'parentesco': 'Pai', 'nome': 'Roberto Gomes Aparecido Da Silva', 'result': 'Risco Médio', 'punctuation': 0.40}
      // ]);
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
      final boxChildren = await Hive.box('db');
      await boxChildren.close();
    } catch (e) {
      print('Erro ao fechar a caixa Hive: $e');
    }

    await Hive.close();
  }
}
