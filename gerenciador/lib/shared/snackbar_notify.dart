
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class SnackbarNotify{
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
        backColor = Colors.red.shade500;
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
      message: message['message'],
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: backColor,
      titleColor: txtColor,
      icon: Icon(icon,color: Colors.white,),
      reverseAnimationCurve: Curves.decelerate,
    ).show(context);
  }
}
