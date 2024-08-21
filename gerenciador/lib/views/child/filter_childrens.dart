
import 'package:flutter/material.dart';

import '../../models/child_model.dart';

class FilterChildrens{
  Map<String, dynamic> optionsFilter = {
    'execute': false,
    'checkedOptions': {
      'checkedResetFilters': true,
      'checkedEmpty': false,
      'checkedSmall': false,
      'checkedMedium': false,
      'checkedTall': false
    },
    'newChildrenList' : []
  };

  Future<Map<String, dynamic>> exibirModalDialog(BuildContext context, List<ChildrenModel> childrenList, Map<String, dynamic> optionsFilterStart) async{

    optionsFilter['checkedOptions'] = Map<String, dynamic>.from( optionsFilterStart['checkedOptions']);

    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: txtTitle(),
          titlePadding: const EdgeInsets.only(top: 15, bottom: 10, right: 5, left: 5),
          content: CheckboxOptions(updateOptionFilter, optionsFilter),
          contentPadding: const EdgeInsets.only(top: 5, bottom: 10, right: 0, left:0),
          actions: <Widget>[ buttonsActions(context, childrenList) ],
          actionsPadding: const EdgeInsets.only(top: 10, bottom: 10, right: 25, left: 25),
          backgroundColor: Colors.white,
        );
      },
    );

    return optionsFilter;
  }

  void updateOptionFilter(Map<String, dynamic> checkedOptions){
    optionsFilter['checkedOptions'] = {
      'checkedResetFilters': checkedOptions['checkedOptions']['checkedResetFilters'],
      'checkedEmpty': checkedOptions['checkedOptions']['checkedEmpty'],
      'checkedSmall': checkedOptions['checkedOptions']['checkedSmall'],
      'checkedMedium': checkedOptions['checkedOptions']['checkedMedium'],
      'checkedTall': checkedOptions['checkedOptions']['checkedTall']
    };
  }

  Widget txtTitle(){
    return Container(
      height: 30,
      width: 180,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: Colors.grey.shade300, width: 2.0
            )
        )
      ),
      child: const Text("Filtrar lista por:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
    );
  }

  Widget buttonsActions(BuildContext context, List<ChildrenModel> childrenList){
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Botão Cancelar
          SizedBox(
            height: 30,
            width: 100,
            child: OutlinedButton.icon(
              onPressed: (){
                optionsFilter['execute'] = false;
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
          // Botão Ordenar
          SizedBox(
            height: 30,
            width: 100,
            child: OutlinedButton.icon(
              onPressed: (){
                optionsFilter['execute'] = true;
                optionsFilter['newChildrenList'] = executeFilter(childrenList, optionsFilter['checkedOptions']);

                Navigator.pop(context);
              },
              icon: const Icon(Icons.check, size: 15, color: Color(0xFF26877B)),
              label: const Text("Filtrar", style: TextStyle(fontSize: 12, color: Color(0xFF26877B))),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFCFEFE),
                  side: const BorderSide(width: 1.0, color:  Color(0xFF26877B)),
                  padding: const EdgeInsets.all(2)
              )
            ),
          )
        ],
      ),
    );
  }

  List<ChildrenModel> executeFilter(List<ChildrenModel> listCurrent, Map<String, dynamic> options){
    List<ChildrenModel> newchildrenList = [];

    for(ChildrenModel children in listCurrent){
      bool checkedEmpty = false;
      bool checkedSmall = false;
      bool checkedMedium = false;
      bool checkedTall = false;

      if( (children.risk == '') && (options['checkedEmpty']!) ) checkedEmpty = true;
      if( (children.risk == 'Risco Baixo') && (options['checkedSmall']!) ) checkedSmall = true;
      if( (children.risk == 'Risco Médio') && (options['checkedMedium']!) ) checkedMedium = true;
      if( (children.risk == 'Risco Alto') && (options['checkedTall']!) ) checkedTall = true;

      if(checkedEmpty || checkedSmall || checkedMedium || checkedTall) newchildrenList.add(children);
    }

    return newchildrenList;
  }
}

class CheckboxOptions extends StatefulWidget {
  final Function (Map<String, dynamic>)updateOptionFilter;
  Map<String, dynamic> optionsFilter;

  CheckboxOptions(this.updateOptionFilter, this.optionsFilter, {super.key});

  @override
  State<CheckboxOptions> createState() => _CheckboxOptionsState();
}

class _CheckboxOptionsState extends State<CheckboxOptions> {

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 200,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          checkBoxContainer("Remover filtros", widget.optionsFilter['checkedOptions']['checkedResetFilters']),
          checkBoxContainer("Crianças sem Média", widget.optionsFilter['checkedOptions']['checkedEmpty']),
          checkBoxContainer("Risco Baixo", widget.optionsFilter['checkedOptions']['checkedSmall']),
          checkBoxContainer("Risco Médio", widget.optionsFilter['checkedOptions']['checkedMedium']),
          checkBoxContainer("Risco Alto ", widget.optionsFilter['checkedOptions']['checkedTall'])
        ],
      ),
    );
  }

  Widget checkBoxContainer(String txtChecked, bool isChecked){
    return Container(
      height: 40,
      width: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
            child: Checkbox(
              tristate: false,
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  if(txtChecked == "Remover filtros"){
                    widget.optionsFilter['checkedOptions']['checkedResetFilters'] = value!;
                    if(widget.optionsFilter['checkedOptions']['checkedResetFilters']){
                      widget.optionsFilter['checkedOptions']['checkedEmpty'] = false;
                      widget.optionsFilter['checkedOptions']['checkedSmall'] = false;
                      widget.optionsFilter['checkedOptions']['checkedMedium'] = false;
                      widget.optionsFilter['checkedOptions']['checkedTall'] = false;
                    }
                  }else
                  if(txtChecked == "Crianças sem Média"){
                    widget.optionsFilter['checkedOptions']['checkedResetFilters'] = false;
                    widget.optionsFilter['checkedOptions']['checkedEmpty'] = value!;
                  }else
                  if(txtChecked == "Risco Baixo"){
                    widget.optionsFilter['checkedOptions']['checkedResetFilters'] = false;
                    widget.optionsFilter['checkedOptions']['checkedSmall'] = value!;
                  }else
                  if(txtChecked == "Risco Médio"){
                    widget.optionsFilter['checkedOptions']['checkedResetFilters'] = false;
                    widget.optionsFilter['checkedOptions']['checkedMedium'] = value!;
                  }else {
                    widget.optionsFilter['checkedOptions']['checkedResetFilters'] = false;
                    widget.optionsFilter['checkedOptions']['checkedTall'] = value!;
                  }

                  widget.updateOptionFilter(widget.optionsFilter);
                });
              },
            ),
          ),
          txtChecked == 'Remover filtros' || txtChecked == 'Crianças sem Média'?
            Text(txtChecked,  style: const TextStyle(fontSize: 14, color: Color(0xFF2D2C2C)), textAlign: TextAlign.start):
            Row(
              children: [
                const Text('Crianças com ',  style:  TextStyle(fontSize: 14, color: Color(0xFF2D2C2C)), textAlign: TextAlign.start),
                Text(txtChecked,  style: TextStyle(fontSize: 14, color: getColorMedia(txtChecked)), textAlign: TextAlign.start),
              ],
            )
        ],
      ),
    );
  }

  Color getColorMedia(String risk){
    if(risk == 'Risco Baixo'){
      return const Color(0xFF047E02);
    } else
    if(risk == 'Risco Médio'){
      return const Color(0xFF9D9702);
    }else{
      return const Color(0xFFFF0000);
    }
  }

}