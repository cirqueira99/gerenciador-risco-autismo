import 'dart:convert';
import 'dart:html' as html;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:questionario/shared/showdialog_notify.dart';

class ResultPageMobile extends StatefulWidget {
  final Map<String, dynamic> infos;
  final String text;

  const ResultPageMobile({super.key, required this.infos, required this.text});

  @override
  State<ResultPageMobile> createState() => _ResultPageMobileState();
}

class _ResultPageMobileState extends State<ResultPageMobile> {
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
        children: [
          resultArea(),
          qrCodeArea(widget.infos['viewQrcode']),
          btnRepeat()
        ],
      ),
    );
  }

  Widget resultArea(){
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          const SizedBox(
              child: Text("Resultado:",  style: TextStyle(fontSize: 14))
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Text(widget.infos['result']['risk'], style: const TextStyle(fontSize: 22, color: Colors.indigo)),
          ),
          Container(
            width: 250,
            padding: const EdgeInsets.only(top: 20, bottom: 50),
            child:  Text(widget.text,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  downloadFile() async{
    Map<String, dynamic> message = {};

    try{
      final qrValidationResult = QrValidator.validate(
        data: jsonData,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );

      final qrCode = qrValidationResult.qrCode;

      final painter = QrPainter.withQr(
        qr: qrCode!,
        color: const Color(0xFF000000),
        emptyColor: null,
        gapless: true,
      );

      final picData = await painter.toImageData(1000, format: ImageByteFormat.png);
      final pngBytes = picData!.buffer.asUint8List();
      final blob = html.Blob([pngBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "qrcode.png")
        ..click();
      html.Url.revokeObjectUrl(url);

      message = {"message": "Download realizado!", "type": "success"};
    }catch(e){
      message = {"message": "Não foi possível baixar a imagem!", "type": "error"};
      print(e);
    }finally{
      await Future.delayed(const Duration(seconds: 2));
      SnackBarNotify.createSnackBar(context, message);
    }
  }

  Widget qrCodeArea(String viewQRcode){
    if(viewQRcode == "Yes"){
      return SizedBox(
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
              width: 210,
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  onPressed: () async{
                    try{
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
                      const Text("Download da Imagem", style: TextStyle(fontSize: 12, color: Colors.white))
                    ],
                  )
              ),
            )
          ],
        ),
      );
    }else{
      return const SizedBox(height: 30);
    }
  }

  Widget btnRepeat(){
    return Container(
      width: 150,
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
              const Text("Refazer teste", style: TextStyle(fontSize: 12, color: Colors.white))
            ],
          )
      ),
    );
  }
}
