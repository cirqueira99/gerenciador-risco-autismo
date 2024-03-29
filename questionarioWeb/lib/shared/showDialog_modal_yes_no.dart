
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ShowDialogYesNo{
  // Função para exibir o modal dialog com botões "Sim" e "Não"
  static Future<String> exibirModalDialog(BuildContext context, String title, String content)async{
    String option = "";

    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(5),
          contentPadding: const EdgeInsets.all(5),
          actionsPadding: const EdgeInsets.all(15),
          title: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 30),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 180,
                    child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                ),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 15,),
                    onPressed: ()=>{
                        Navigator.pop(context)
                    },
                  ),
                ),
              ],
            ),
          ),
          content: Text(content, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
          actions: <Widget>[
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade400,
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 30,
                    width: 50,
                    child: TextButton(
                      child: const Text('Não', style: TextStyle(fontSize: 12, color: Colors.white)),
                      onPressed: () {
                        option = "No";
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade400,
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 30,
                    width: 50,
                    child: TextButton(
                      child: const Text('Sim', style: TextStyle(fontSize: 12, color: Colors.white)),
                      onPressed: () {
                        option = "Yes";
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    return option;
  }

}
