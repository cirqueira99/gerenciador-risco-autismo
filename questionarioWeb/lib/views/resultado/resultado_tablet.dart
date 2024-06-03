import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:questionario/shared/showdialog_notify.dart';

class ResultPageTablet extends StatefulWidget {
  final Map<String, dynamic> infos;
  final String text;

  const ResultPageTablet({super.key, required this.infos, required this.text});

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

    jsonData = jsonEncode(widget.infos['result']);

    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          body(screenHeight, screenWidth),
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

  downloadFile() async{
    Map<String, dynamic> message = {};

    try{
      // Usamos o QrValidator.validate para validar os dados que queremos codificar no QR. Ele retorna um objeto QrValidationResult que contém o QrCode gerado.
      final qrValidationResult = QrValidator.validate(
        data: jsonData,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );
      final qrCode = qrValidationResult.qrCode;

      // Usamos o QrPainter.withQr para criar um QrPainter a partir do QrCode validado. Esse pintor (painter) é configurado com as cores e o estilo do código QR.
      final painter = QrPainter.withQr(
        qr: qrCode!,
        color: const Color(0xFF000000),
        emptyColor: const Color(0xFFFFFFFF),
        gapless: true,
      );

      // Chamamos o método toImageData no QrPainter para converter o QR code em dados de imagem. Especificamos a resolução da imagem (neste caso, 2048 pixels) e o formato da imagem (PNG).
      final picData = await painter.toImageData(2048, format: ImageByteFormat.png);
      final pngBytes = picData!.buffer.asUint8List();

      // Convertendo os bytes da imagem PNG em um Blob HTML, que é um objeto que representa dados binários em forma de arquivo.
      // Criamos uma URL temporária para esse Blob usando html.Url.createObjectUrlFromBlob.
      // Criamos um elemento AnchorElement (tag <a> do HTML) e configuramos o atributo href com a URL do Blob, e o atributo download com o nome do arquivo.
      // Simulamos um clique nesse AnchorElement para iniciar o download.
      // Finalmente, revogamos a URL temporária para liberar os recursos.
      final blob = html.Blob([pngBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "qrcode.png")
        ..click();
      html.Url.revokeObjectUrl(url);

      message = {"message": "Download realizado!", "type": "success"};
    }catch(e){
      //message = {"message": "Não foi possível baixar a imagem!", "type": "error"};
      message = {"message": e, "type": "error"};
      print(e);
    }finally{
      SnackBarNotify.createSnackBar(context, message);
    }
  }

  Widget result(){
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Text(widget.infos['result']['risk'], style: const TextStyle(fontSize: 22, color: Colors.indigo)),
          ),
          Container(
            width: 350,
            padding: const EdgeInsets.only(top: 20, bottom: 50),
            child:  Text(widget.text,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          widget.infos['viewQrcode'] == "Yes"?
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
                      data: jsonData, // Usando a string JSON como infos
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
                          await downloadFile();
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
