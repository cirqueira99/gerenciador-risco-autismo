
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class SnackBarNotify{
  static Future createSnackBar(BuildContext context, Map<String, dynamic> message) {
    switch(message["type"]){
      case "success":
        message["backColor"] = Colors.green.shade500;
        message["txtColor"] = Colors.white60;
        message["icon"] = Icons.check;
        break;
      case "warning":
        message["backColor"] = Colors.red.shade500;
        message["txtColor"] = Colors.black54;
        message["icon"] = Icons.info_outline;
        break;
      case "error":
        message["backColor"] = Colors.red.shade500;
        message["txtColor"] = Colors.white60;
        message["icon"] = Icons.cancel_outlined;
        break;
      default:
        break;
    }

    return Flushbar(
      message: message['message'],
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: message["backColor"],
      titleColor: message["txtColor"],
      icon: Icon(message["icon"],color: Colors.white,),
      reverseAnimationCurve: Curves.decelerate,
    ).show(context);
  }
}
