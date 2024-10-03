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
  DateTime selectedDateToday = DateTime.now();
  bool validing = false;
  bool formsValid = false;
  late TextEditingController _nameController;
  late TextEditingController _responsibleController;


  @override
  void initState(){
    super.initState();
    _initValuesChildren();
    _nameController = TextEditingController(text: widget.childrenModel.name);
    _responsibleController = TextEditingController(text: widget.childrenModel.responsible);
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
      child: forms(screenW)
    );
  }

  Widget forms(num screenW){
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getInputs("Nome da criança:", const Icon(Icons.child_care, size: 20, color: Colors.white), nameChildren(screenW), widget.childrenModel.name.isNotEmpty),
          getInputs("Data de nascimento:", const Icon(Icons.calendar_month, size: 20, color: Colors.white), dateBirth(screenW), widget.childrenModel.dateNasc == "00/00/0000"? false: true),
          getInputs("Sexo:", const Icon(Icons.child_friendly_outlined, size: 20, color: Colors.white), radioSexChildren(screenW), widget.childrenModel.sex.isNotEmpty),
          getInputs("Nome do responsável:", const Icon(Icons.person, size: 20, color: Colors.white), nameResponsibleChildren(screenW), widget.childrenModel.responsible.isNotEmpty)
        ],
      ),
    );
  }

  Widget nameChildren(num screenW){
    return SizedBox(
      height: 40,
      width: screenW * 0.70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                decoration: InputDecoration(
                    hintText: 'Digite aqui...',
                    hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
                    counterStyle: const TextStyle(fontSize: 10),
                    border: InputBorder.none
                ),
                onChanged: (String value) {
                  setState(() {
                    widget.childrenModel.name = value;
                  });
                },
              ),
            ),
          ),
        ],
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
        widget.childrenModel.dateNasc = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Widget dateBirth(num screenW){
    return SizedBox(
      height: 40,
      width: screenW * 0.75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async{
              await _selectedDateToday(context);
            },
            child:
            widget.childrenModel.dateNasc == "00/00/0000"?
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                widget.childrenModel.dateNasc,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black54),
              ),
            ):
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                widget.childrenModel.dateNasc,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green.shade900),
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget radioSexChildren(num screenW){
    return Container(
        height: 40,
        width: screenW * 0.75,
        padding: const EdgeInsets.only(right: 10),
        child: RadioSexChildren(widget.childrenModel, updateSexChildren)
    );
  }

  Widget nameResponsibleChildren(num screenW){
    return SizedBox(
      height: 40,
      width: screenW * 0.70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: _responsibleController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                decoration: InputDecoration(
                    hintText: 'Digite aqui...',
                    hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
                    counterStyle: const TextStyle(fontSize: 10),
                    border: InputBorder.none
                ),
                onChanged: (String value) {
                  setState(() {
                    widget.childrenModel.responsible = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getInputs(String title, Icon icon, Widget textFormField, bool textValid){
    double screenW = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 100,
      width: screenW * 0.9,
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
              border: validing? textValid? Border.all(color: Colors.grey.shade500) : Border.all(color: Colors.red.shade500) : Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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

            if (validInputs()) {
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
            }else {
              setState(() {
                validing = true;
              });
              SnackbarNotify.createSnackBar(context, {"message": "Preencha os campos em vermelho!", "type": "warning"});
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

  bool validInputs(){
    bool isValid = true;

    if(widget.childrenModel.name.isEmpty || widget.childrenModel.dateNasc == "00/00/0000" || widget.childrenModel.sex.isEmpty || widget.childrenModel.responsible.isEmpty){
      isValid = false;
    }

    return isValid;
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
      mainAxisAlignment: MainAxisAlignment.center,
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
              Text("Masculino", style: TextStyle(fontSize: 14, color: Colors.green.shade900),)
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
              Text("Feminino", style: TextStyle(fontSize: 14, color: Colors.green.shade900),)
            ],
          ),
        ),
      ],
    );
  }
}