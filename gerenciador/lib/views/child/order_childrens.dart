
import 'package:flutter/material.dart';

import '../../models/child_model.dart';

class OrderChildrens{
  Map<String, dynamic> option = { 'execute': false, 'optionOrder': '', 'newChildrenList': []};

   Future<Map<String, dynamic>> exibirModalDialog(BuildContext context, List<ChildrenModel> childrenList, String orderCurrent) async{
     option['optionOrder'] = orderCurrent;

     final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ordenar lista por:", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
          content: RadioOptions(updateOptionOrder, orderCurrent),
          actions: <Widget>[ buttonsActions(context, childrenList) ],
        );
      },
    );

    return option;
  }

  void updateOptionOrder(String answer){
    option = { 'execute': false, 'optionOrder': answer };
  }

  Widget buttonsActions(BuildContext context, List<ChildrenModel> childrenList){
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Botão Cancelar
          SizedBox(
              height: 30,
              width: 130,
              child: OutlinedButton.icon(
                onPressed: (){
                  option['execute'] = false;
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel_outlined, size: 20, color: Colors.white),
                label: const Text("Cancelar", style: TextStyle(fontSize: 12, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF26877B)
                ),
              )
          ),
          // Botão Ordenar
          SizedBox(
              height: 30,
              width: 130,
              child: OutlinedButton.icon(
                onPressed: (){
                  option['execute'] = true;
                  //option['newChildrenList'] = executeOrder(childrenList, option['optionOrder']);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check, size: 20, color: Color(0xFF26877B)),
                label: const Text("Ordenar", style: TextStyle(fontSize: 12, color: Color(0xFF26877B))),
              )
          )
        ],
      ),
    );
  }

  List<ChildrenModel> executeOrder(List<ChildrenModel> listCurrent, int orderOption){

    switch(orderOption){
      case 1:
        listCurrent.sort((r1, r2) => r1.name.compareTo(r2.name));
        break;
      case 2:
        listCurrent.sort((r1, r2) => _compareRisk(r1.risk, r2.risk)); // ordena crescente
        break;
      case 3:
        listCurrent.sort((r1, r2) => _compareRisk(r2.risk, r1.risk)); // ordena decrescente
        break;
      default:
        break;
    }

    return listCurrent;
  }

  int _compareRisk(String risk1, String risk2) {
    // Definir a ordem de risco do menor para o maior
    const riskOrder = ['', 'Risco Baixo', 'Risco Médio', 'Risco Alto'];

    // Comparar as posições de risco na lista de prioridade
    int index1 = riskOrder.indexOf(risk1);
    int index2 = riskOrder.indexOf(risk2);

    return index1.compareTo(index2);
  }
}

class RadioOptions extends StatefulWidget {
  final Function(String answer) updateOptionOrder;
  String orderCurrent;

  RadioOptions(this.updateOptionOrder, this.orderCurrent, {super.key});

  @override
  State<RadioOptions> createState() => _RadioOptionsState();
}

class _RadioOptionsState extends State<RadioOptions> {

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 150,
      width: 270,
      child: Column(
        children: [
          radioContainer("Ordem alfabética A -> Z", "1"),
          radioContainer("Ordem em média crescente", "2"),
          radioContainer("Ordem média decrescente", "3"),
        ],
      ),
    );
  }

  Widget radioContainer(String txtRadio, String valueRadio){
    return SizedBox(
      child: Row(
        children: [
          Radio<String>(
            value: valueRadio,
            groupValue: widget.orderCurrent,
            onChanged: (value) {
              setState(() {
                widget.orderCurrent = value.toString();
                widget.updateOptionOrder(widget.orderCurrent);
              });
            },
          ),
          Text(txtRadio, style: const TextStyle(fontSize: 14, color: Colors.black),)
        ],
      ),
    );
  }
}

