import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrCodeScanner{

  Future<Map<String, dynamic>> readQRcode() async {
    Map<String, dynamic> qrCodeInfo = {};

    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );

    code != '-1'? qrCodeInfo = json.decode(code) : qrCodeInfo = {'result': 'Não validado'};

    qrCodeInfo['punctuation'] = qrCodeInfo['punctuation'].toDouble();
    // qrCodeInfo = {
    //   'risk': '',
    //   'punctuation': 0.0,
    //   'answers': ['Não', 'Sim', 'Sim', 'Sim', 'Não', 'Não', 'Sim', 'Sim', 'Sim', 'Sim', 'Não', 'Não', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sim', 'Sim', 'Não']
    // };

    return qrCodeInfo;
  }
}