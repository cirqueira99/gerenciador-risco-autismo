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

    if(code != '-1') {
      qrCodeInfo = json.decode(code);
      qrCodeInfo['punctuation'] = qrCodeInfo['punctuation'].toDouble();
    }else{
      qrCodeInfo = {'result': 'Não validado'};
    }

    qrCodeInfo = {
      'risk': 'Risco Alto',
      'punctuation': 15.0,
      'answers': ['Não', 'Sim', 'Sim', 'Sim', 'Não', 'Não', 'Sim', 'Sim', 'Sim', 'Sim', 'Não', 'Não', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sim', 'Sim', 'Não']
    };

    return qrCodeInfo;
  }
}