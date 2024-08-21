
import 'package:flutter/material.dart';

class SnackbarDialogYesNo{
  // Função para exibir o modal dialog com botões "Sim" e "Não"
  static Future<bool> exibirModalDialog(BuildContext context, String title, String content) async{
    bool option = false;

    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: SizedBox(
              width: 200,
            child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
          ),
          content: SizedBox(
            width: 200,
            child: Text(content, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center)
          ),
          contentPadding: const EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 15),
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
                      icon: const Icon(Icons.cancel_outlined, size: 15, color: Colors.white),
                      label: const Text("Cancelar", style: TextStyle(fontSize: 12, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF26877B),
                          side: const BorderSide(width: 1.0, color:  Color(0xFF26877B)),
                          padding: const EdgeInsets.all(2)
                      ),
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
                      icon: const Icon(Icons.check, size: 15, color: Color(0xFF26877B)),
                      label: const Text("Confirmar", style: TextStyle(fontSize: 12, color: Color(0xFF26877B))),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFCFEFE),
                          side: const BorderSide(width: 1.0, color:  Color(0xFF26877B)),
                          padding: const EdgeInsets.all(2)
                      )
                    )
                  )
                ],
              ),
            )
          ],
          actionsPadding: const EdgeInsets.only(top: 20, bottom: 20, right: 25, left: 25)
        );
      },
    );

    return option;
  }
}
