
import 'package:flutter/material.dart';


class ShowDialogYesNo{
  static Future<String> exibirModalDialog(BuildContext context, String title, String content)async{

    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontSize: 18, color: Colors.deepPurple), textAlign: TextAlign.center,),
          content: Text(content, style: const TextStyle(fontSize: 14, color: Colors.black54),),
          actions: <Widget>[
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão NÃO
                  SizedBox(
                      height: 30,
                      width: 100,
                      child: OutlinedButton.icon(
                        onPressed: (){
                          Navigator.pop(context, "No");
                        },
                        icon: const Icon(Icons.check, size: 20, color: Colors.deepPurple),
                        label: const Text("Não", style: TextStyle(fontSize: 12, color: Colors.deepPurple)),
                      )
                  ),
                  // Botão SIM
                  SizedBox(
                      height: 30,
                      width: 100,
                      child: OutlinedButton.icon(
                        onPressed: (){
                          Navigator.pop(context, "Yes");
                        },
                        icon: const Icon(Icons.cancel_outlined, size: 20, color: Colors.white),
                        label: const Text("Sim", style: TextStyle(fontSize: 12, color: Colors.white)),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                      )
                  )
                ],
              ),
            )
          ],
        );
      },
    );

    return result;
  }

}
