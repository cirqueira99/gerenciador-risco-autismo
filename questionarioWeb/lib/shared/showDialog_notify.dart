
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
      flushbarPosition: FlushbarPosition.TOP,
      messageText: SizedBox( height: 30,child:Text(message['message'], textAlign: TextAlign.center)),
      messageColor: message["txtColor"],
      backgroundColor: message["backColor"],
      messageSize: 14.0,
      maxWidth: 250,
      //margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 30),
      borderRadius: BorderRadius.circular(5.0),
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 40.0), // Define o preenchimento do ícone
        child: Icon(message["icon"], color: Colors.black),
      ),
      reverseAnimationCurve: Curves.linearToEaseOut,
    ).show(context);
  }
}
