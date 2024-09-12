
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';


class SnackBarNotify{
  static Future createSnackBar(BuildContext context, Map<String, dynamic> message) {
    Color backColor;
    Color txtColor;
    IconData icon;

    switch(message["type"]){
      case "success":
        backColor = Colors.green.shade500;
        txtColor = Colors.white60;
        icon = Icons.check;
        break;
      case "warning":
        backColor = Colors.orange.shade500;
        txtColor = Colors.black54;
        icon = Icons.info_outline;
        break;
      case "error":
        backColor = Colors.red.shade500;
        txtColor = Colors.white60;
        icon = Icons.cancel_outlined;
        break;
      default:
        backColor = Colors.green.shade500;
        txtColor = Colors.white60;
        icon = Icons.check;
        break;
    }

    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 4),
      messageText: SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(message['message'], style: TextStyle(color: txtColor, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ],
          )),
      backgroundColor: backColor,
      messageSize: 14.0,
      maxWidth: 250,
      //margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 30),
      borderRadius: BorderRadius.circular(5.0),
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 40.0), // Define o preenchimento do ícone
        child: Icon(icon, color: txtColor),
      ),
      reverseAnimationCurve: Curves.linearToEaseOut,
    ).show(context);
  }
}
