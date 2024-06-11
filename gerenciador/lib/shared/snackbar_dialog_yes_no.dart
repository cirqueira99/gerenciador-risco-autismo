
import 'package:flutter/material.dart';

class SnackbarDialogYesNo{
  // Função para exibir o modal dialog com botões "Sim" e "Não"
  static Future<bool> exibirModalDialog(BuildContext context, String title, String content) async{
    bool option = false;

    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center,),
          content: Text(content),
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
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.cancel_outlined, size: 20, color: Color(0xFF26877B)),
                        label: const Text("Não", style: TextStyle(fontSize: 12, color: Color(0xFF26877B))),
                      )
                  ),
                  // Botão SIM
                  SizedBox(
                      height: 30,
                      width: 100,
                      child: OutlinedButton.icon(
                        onPressed: (){
                          option = true;
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.check, size: 20, color: Colors.white),
                        label: const Text("Sim", style: TextStyle(fontSize: 12, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF26877B)
                        ),
                      )
                  )
                ],
              ),
            )
          ],
        );
      },
    );

    return option;
  }
}
