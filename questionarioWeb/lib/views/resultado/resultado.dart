import 'package:flutter/material.dart';
import 'package:questionario/views/resultado/resultado_desktop.dart';
import 'package:questionario/views/resultado/resultado_mobile.dart';
import 'package:questionario/views/resultado/resultado_tablet.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Map<String, dynamic> dados = {};

  @override
  Widget build(BuildContext context) {
    dados = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Resultado", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          if(constraints.maxWidth < 510){
            return ResultPageMobile(dados: dados);
          }else if(constraints.maxWidth < 750){
            return ResultPageTablet(dados: dados);
          }else {
            return ResultPageDesktop(dados: dados);
          }
        }),
      ),
    );
  }
}
