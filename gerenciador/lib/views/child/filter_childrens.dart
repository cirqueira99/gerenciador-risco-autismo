
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
          title: const Text("Filtrar lista por:", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
          content: CheckboxOptions(updateOptionFilter, optionsFilter),
          actions: <Widget>[ buttonsActions(context, childrenList) ],
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
                  optionsFilter['execute'] = false;
                  //optionsFilter['newChildrenList'] = childrenList;
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
                  optionsFilter['execute'] = true;
                  optionsFilter['newChildrenList'] = executeFilter(childrenList, optionsFilter['checkedOptions']);

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check, size: 20, color: Color(0xFF26877B)),
                label: const Text("Filtrar", style: TextStyle(fontSize: 12, color: Color(0xFF26877B))),
              )
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
      height: 220,
      width: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          checkBoxContainer("Remover filtros", widget.optionsFilter['checkedOptions']['checkedResetFilters']),
          checkBoxContainer("Crianças sem Média", widget.optionsFilter['checkedOptions']['checkedEmpty']),
          checkBoxContainer("Crianças com Risco Baixo", widget.optionsFilter['checkedOptions']['checkedSmall']),
          checkBoxContainer("Crianças com Risco Médio", widget.optionsFilter['checkedOptions']['checkedMedium']),
          checkBoxContainer("Crianças com Risco Alto ", widget.optionsFilter['checkedOptions']['checkedTall'])
        ],
      ),
    );
  }

  Widget checkBoxContainer(String txtChecked, bool isChecked){
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
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
                if(txtChecked == "Crianças com Risco Baixo"){
                  widget.optionsFilter['checkedOptions']['checkedResetFilters'] = false;
                  widget.optionsFilter['checkedOptions']['checkedSmall'] = value!;
                }else
                if(txtChecked == "Crianças com Risco Médio"){
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
          Text(txtChecked,  style: const TextStyle(fontSize: 14), textAlign: TextAlign.start)
        ],
      ),
    );
  }

}