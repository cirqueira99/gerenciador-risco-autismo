
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';


class SnackBarNotify{
  static Future createSnackBar(BuildContext context, Map<String, dynamic> message) {
    switch(message["type"]){
      case "success":
        message["backColor"] = Colors.green.shade500;
        message["txtColor"] = Colors.white60;
        message["icon"] = Icons.check;
        break;
      case "warning":
        message["backColor"] = Colors.orange.shade500;
        message["txtColor"] = Colors.white;
        message["icon"] = Icons.info_outline;
        break;
      case "error":
        message["backColor"] = Colors.red.shade500;
        message["txtColor"] = Colors.white60;
        message["icon"] = Icons.error;
        break;
      default:
        break;
    }

    return Flushbar(
      messageText: Text(message['message'], textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: message["backColor"],
      titleColor: message["txtColor"],
      messageSize: 14.0,
      maxWidth: 350,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
      borderRadius: BorderRadius.circular(20.0),
      icon: const Padding(
        padding: EdgeInsets.only(left: 20.0, bottom: 30.0), // Define o preenchimento do ícone
        child: Icon(Icons.info_outline, color: Colors.black),
      ),
      reverseAnimationCurve: Curves.linearToEaseOut,
    ).show(context);
  }
}
