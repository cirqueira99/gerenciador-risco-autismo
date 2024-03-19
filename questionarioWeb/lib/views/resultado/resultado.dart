import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:questionario/views/resultado/resultado_desktop.dart';
import 'package:questionario/views/resultado/resultado_mobile.dart';
import 'package:questionario/views/resultado/resultado_tablet.dart';
import 'package:share_plus/share_plus.dart';

//import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';

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
          print("with: ${constraints.maxWidth}");
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
