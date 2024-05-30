import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:questionario/shared/showdialog_notify.dart';


class ResultPageDesktop extends StatefulWidget {
  final Map<String, dynamic> infos;
  final String text;

  const ResultPageDesktop({super.key, required this.infos, required this.text});

  @override
  State<ResultPageDesktop> createState() => _ResultPageDesktopState();
}

class _ResultPageDesktopState extends State<ResultPageDesktop> {
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

              child: const Text("Resultado:", style: TextStyle(fontSize: 16))
          ),
          result()
        ],
      ),
    );
  }

  downloadFile() async{
    Map<String, dynamic> message = {};

    try{
      RenderRepaintBoundary boundary = _qrImageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        final blob = html.Blob([pngBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download", "qrcode.jpg")
          ..click();
        html.Url.revokeObjectUrl(url);
      }
    }catch(e){
      SnackBarNotify.createSnackBar(context, {"message": e, "type": "error"});
      print(e);
    }
  }

  Widget result(){
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Text(widget.infos['result']['risk'], style: const TextStyle(fontSize: 26, color: Colors.indigo)),
          ),
          Container(
            width: 450,
            padding: const EdgeInsets.only(top: 20, bottom: 50),
            child: Text(widget.text,
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
                      size: 150.0,
                    ),
                  ),
                ),
                Container(
                  width: 240,
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
                          const Text("Download da Imagem", style: TextStyle(fontSize: 16, color: Colors.white))
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
            width: 180,
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
                    const Text("Refazer teste", style: TextStyle(fontSize: 16, color: Colors.white))
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}
