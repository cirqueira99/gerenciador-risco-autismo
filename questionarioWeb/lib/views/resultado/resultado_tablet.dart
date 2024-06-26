import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ResultPageTablet extends StatefulWidget {
  final Map<String, dynamic> dados;

  const ResultPageTablet({super.key, required this.dados});

  @override
  State<ResultPageTablet> createState() => _ResultPageTabletState();
}

class _ResultPageTabletState extends State<ResultPageTablet> {
  late String jsonData;
  final GlobalKey _qrImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    jsonData = jsonEncode(widget.dados['answer']);

    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          top(screenWidth),
          body(screenHeight, screenWidth),
        ],
      ),
    );
  }

  Widget top(num screenWidth){
    return Container(
      width: screenWidth * 0.8,
      margin: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("O que é o código?", style: TextStyle(fontSize: 12),),
                Icon(Icons.account_circle_rounded, size: 15, color: Colors.deepPurple,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget body(num screenHeight, num screenWidth){
    return SizedBox(
      height: screenHeight * 0.8,
      width: screenWidth * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 30),
              child: const Text("Resultado:", style: TextStyle(fontSize: 14))
          ),
          result()
        ],
      ),
    );
  }

  Future<void> _gerarArquivo() async {
    try {
      RenderRepaintBoundary boundary = _qrImageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/qrcode.png';
        File(imagePath).writeAsBytesSync(pngBytes);
        final XFile xFile = XFile(imagePath);
        await Share.shareXFiles([xFile], text: 'Download do QR Code');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void downloadFile() async{
    try{
      RenderRepaintBoundary boundary = _qrImageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        final blob = html.Blob([pngBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download", "qrcode.png")
          ..click();
        html.Url.revokeObjectUrl(url);
      }
    }catch(e){
      print(e);
    }
  }

  Widget result(){
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: const Text("data", style: TextStyle(fontSize: 22, color: Colors.indigo)),
          ),
          Container(
            width: 350,
            padding: const EdgeInsets.only(top: 20, bottom: 50),
            child: const Text("dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\ndataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          widget.dados['viewQrcode'] == "Yes"?
          SizedBox(
            child: Column(
              children: [
                RepaintBoundary(
                  key: _qrImageKey,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2.0,
                            color: Colors.grey
                        )
                    ),
                    child: QrImageView(
                      data: jsonData, // Usando a string JSON como dados
                      version: QrVersions.auto,
                      size: 100.0,
                    ),
                  ),
                ),
                Container(
                  width: 220,
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                      onPressed: () async{
                        try{
                          //await _gerarArquivo();
                          downloadFile();
                        }catch(e){
                          print(e);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: const Icon(Icons.download, size: 16, color: Colors.white)
                          ),
                          const Text("Download da Imagem", style: TextStyle(fontSize: 14, color: Colors.white))
                        ],
                      )
                  ),
                )
              ],
            ),
          )
              :
          const SizedBox(height: 30,),
          Container(
            width: 160,
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(
                onPressed: ()=>{
                  Navigator.popAndPushNamed(context, '/questionario')
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Icon(Icons.replay, size: 16, color: Colors.white)
                    ),
                    const Text("Refazer teste", style: TextStyle(fontSize: 14, color: Colors.white))
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}
