import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrCodeScanner{

  Future<Map<String, dynamic>> readQRcode() async {
    Map<String, dynamic> qrCodeInfo = {};
    // String code = await FlutterBarcodeScanner.scanBarcode(
    //   "#FFFFFF",
    //   "Cancelar",
    //   false,
    //   ScanMode.QR,
    // );
    //
    // code != '-1'? qrCodeInfo = json.decode(code) : qrCodeinfo = {'answers': 'Não validado'};

    qrCodeInfo['answers'] = ['Sim', 'Não', 'Sim', 'Não', 'Sim', 'Sim', 'Não', 'Sim', 'Sim', 'Sim', 'Não', 'Sim', 'Sim', 'Não', 'Não', 'Sim', 'Sim', 'Não', 'Sim', 'Sim'];

    return qrCodeInfo;
  }
}