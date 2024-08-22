import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/child_model.dart';
import '../../services/children_service.dart';
import '../../shared/snackbar_notify.dart';


class ChildrenAdd extends StatefulWidget {
  final bool edit;
  ChildrenModel childrenModel;

  ChildrenAdd({super.key, required this.edit, required this.childrenModel});

  @override
  State<ChildrenAdd> createState() => _ChildrensAddState();
}

class _ChildrensAddState extends State<ChildrenAdd> {
  ChildrenService childrenService = ChildrenService();
  final _formkey = GlobalKey<FormState>();
  DateTime selectedDateToday = DateTime.now();

  @override
  void initState(){
    _initValuesChildren();
    super.initState();
  }

  _initValuesChildren() {
    if(!widget.edit){
      setState(() {
        widget.childrenModel.risk = "";
        widget.childrenModel.punctuation = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF184F49),
        title: Text(widget.edit? "Editar criança": 'Cadastrar criança', style: const TextStyle(fontSize: 20, color: Colors.white))
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            height: screenH * 0.9,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                infos(screenH, screenW),
                buttons()
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget infos(num screenH, num screenW){
    return  Container(
      height: screenH * 0.7,
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      child: Form(
          key: _formkey,
          child: forms()
      )
    );
  }

  Widget forms(){
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getInputs("Nome da criança:", const Icon(Icons.child_care, size: 20, color: Colors.white), nameChildren()),
          getInputs("Data de nascimento", const Icon(Icons.calendar_month, size: 20, color: Colors.white), dateBirth()),
          getInputs("Sexo:", const Icon(Icons.child_friendly_outlined, size: 20, color: Colors.white), radioSexChildren()),
          getInputs("Nome do responsável:", const Icon(Icons.person, size: 20, color: Colors.white), nameResponsibleChildren())
        ],
      ),
    );
  }

  Widget nameChildren(){
    return SizedBox(
      height: 40,
      width: 320,
      child: TextFormField(
        initialValue: widget.childrenModel.name,
        decoration: InputDecoration(
          hintText: "Digite aqui...",
          hintStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(10.0)
          ),
        ),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        textAlign: TextAlign.center,
        validator: (String? value){
          if(value == null || value.isEmpty){
            return "Preencha o campo nome!";
          }
          return null;
        },
        onChanged: (String? value) => setState(() {
          if(value != null){
            setState(() {
              widget.childrenModel.name = value;
            });
          }
        }),
      ),
    );
  }

  void updateSexChildren(String optionSelected){
    setState(() {
      widget.childrenModel.sex = optionSelected;
    });
  }

  Future<void> _selectedDateToday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateToday,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDateToday) {
      setState(() {
        selectedDateToday = picked;
        widget.childrenModel.dataNasc = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Widget dateBirth(){
    return SizedBox(
      height: 40,
      width: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async{
              await _selectedDateToday(context);
            },
            child:
            widget.childrenModel.dataNasc == "00/00/0000"?
            Text(
              widget.childrenModel.dataNasc,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black54),
            ):
            Text(
              widget.childrenModel.dataNasc,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
            )
          ),
        ],
      ),
    );
  }

  Widget radioSexChildren(){
    return SizedBox(
        height: 40,
        width: 320,
        child: RadioSexChildren(widget.childrenModel, updateSexChildren)
    );
  }

  Widget nameResponsibleChildren(){
    return SizedBox(
      height: 40,
      width: 320,
      child: TextFormField(
        initialValue: widget.childrenModel.responsible,
        decoration: InputDecoration(
          hintText: "Digite aqui...",
          hintStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(10.0)
          ),
        ),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        textAlign: TextAlign.center,
        validator: (String? value){
          if(value == null || value.isEmpty){
            return "Preencha o campo nome do responsável!";
          }
          return null;
        },
        onChanged: (String? value) => setState(() {
          if(value != null){
            setState(() {
              widget.childrenModel.responsible = value;
            });
          }
        }),
      ),
    );
  }

  Widget getInputs(String title, Icon icon, Widget textFormField){

    return SizedBox(
      height: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          Container(
            height: 45,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xFF26877B),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: icon,
                ),
                textFormField
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buttons(){
    return Container(
      width: 300,
      margin: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          btnCancel(),
          btnSave()
        ],
      ),
    );
  }

  Widget btnSave(){
    return SizedBox(
        width: 120,
        child: ElevatedButton.icon(
          onPressed: () async {
            Map<String, dynamic> message = {};

            if (_formkey.currentState!.validate()) {
              if (widget.childrenModel.dataNasc.isEmpty || widget.childrenModel.dataNasc == "00/00/0000") {
                message = {"message": "Selecione a data de nascimento!", "type": "warning"};
                SnackbarNotify.createSnackBar(context, message);
              } else if (widget.childrenModel.sex == "") {
                message = {"message": "Selecione o sexo da criança!", "type": "warning"};
                SnackbarNotify.createSnackBar(context, message);
              } else {
                try {
                  if (widget.edit) {
                    await childrenService.update(widget.childrenModel);
                    message = {"message": "Dados atualizados!", "type": "success"};
                  } else {
                    await childrenService.create(widget.childrenModel);
                    message = {"message": "Criança cadastrada!", "type": "success"};
                  }
                  Navigator.pop(context, message);
                } catch (error) {
                  widget.edit ?
                  SnackbarNotify.createSnackBar(context, {"message": "Não foi possível atualizar a criança!", "type": "error"})
                  :
                  SnackbarNotify.createSnackBar(context, {"message": "Não foi possível cadastrar a criança!", "type": "error"});
                  throw Exception(error);
                }
              }
            }
          },
          icon: const Icon(Icons.save, size: 20, color: Colors.white),
          label: const Text("Salvar", style: TextStyle(fontSize: 12, color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF26877B)
          ),
        )
    );
  }

  Widget btnCancel(){
    return SizedBox(
        width: 120,
        child: OutlinedButton.icon(
            onPressed: (){
              Map<String, dynamic> message = {};
              Navigator.pop(context, message);
            },
            icon: const Icon(Icons.cancel_outlined, size: 20, color: Color(0xFF26877B)),
            label: const Text("Cancelar", style: TextStyle(fontSize: 12, color: Color(0xFF26877B))),
        )
    );
  }


}

class RadioSexChildren extends StatefulWidget {
  final ChildrenModel children;
  final Function(String answer) updateSexChildren;

  const RadioSexChildren(this.children, this.updateSexChildren, {super.key});

  @override
  _RadioWidgetState createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioSexChildren> {
  String selectedOption = "";

  @override
  Widget build(BuildContext context) {
    if(widget.children.sex != ""){
      selectedOption = widget.children.sex;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          child: Row(
            children: [
              Radio<String>(
                value: 'Masculino',
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                    widget.updateSexChildren(selectedOption);
                  });
                },
              ),
              const Text("Masculino", style: TextStyle(fontSize: 16, color: Colors.black),)
            ],
          ),
        ),
        SizedBox(
          child: Row(
            children: [
              Radio<String>(
                value: 'Feminino',
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                    widget.updateSexChildren(selectedOption);
                  });
                },
              ),
              const Text("Feminino", style: TextStyle(fontSize: 16, color: Colors.black),)
            ],
          ),
        ),
      ],
    );
  }
}