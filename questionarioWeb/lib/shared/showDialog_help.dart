
import 'package:flutter/material.dart';


class ShowDialogHelp{
  static Future<bool> exibirModalDialog(BuildContext context, String content)async{

    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text(title, style: const TextStyle(fontSize: 18, color: Colors.deepPurple), textAlign: TextAlign.center,),
          content: Text(content, style: const TextStyle(fontSize: 12, color: Colors.black),),
          contentPadding: const EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
          actions: <Widget>[
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      height: 20,
                      width: 70,
                      child: OutlinedButton.icon(
                        onPressed: (){
                          Navigator.pop(context, true);
                        },
                        label: const Text("Ok", style: TextStyle(fontSize: 10, color: Colors.deepPurple)),
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(width: 1.0, color:  Colors.deepPurple),
                            padding: const EdgeInsets.all(2)
                        )
                      )
                  ),
                ],
              ),
            )
          ],
          actionsPadding: const EdgeInsets.only(top: 10, bottom: 10, right: 25, left: 25),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        );
      },
    );

    return result;
  }

}
