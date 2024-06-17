import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador/services/answer_service.dart';
import 'package:gerenciador/shared/snackbar_dialog_yes_no.dart';
import 'package:gerenciador/shared/snackbar_notify.dart';
import 'package:intl/intl.dart';

import 'package:gerenciador/models/answer_model.dart';


class AnswerAdd extends StatefulWidget {
  bool edit;
  AnswerModel answerModel;

  AnswerAdd({super.key, required this.edit, required this.answerModel});

  @override
  State<AnswerAdd> createState() => _AnswersAddState();
}

class _AnswersAddState extends State<AnswerAdd> {
  AnswerService answerService = AnswerService();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState(){
    _getValuesAnswer();
    super.initState();
  }

  _getValuesAnswer() {
    if(!widget.edit){
      setState(() {
        widget.answerModel.dateregister = DateFormat('dd/MM/yyyy').format(DateTime.now());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF148174),
        title: Text(widget.edit? "Editar resposta": 'Cadastrar resposta', style: const TextStyle(fontSize: 20, color: Colors.white)),
        actions: [
          widget.edit?
          Container(
            width: 50,
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.white,),
              onPressed: () async {
                bool resultOptions = false;
                bool? response = false;
                Map<String, dynamic> message = {};

                try {
                  resultOptions = await SnackbarDialogYesNo.exibirModalDialog(context, 'Confirmar exclusão?', '');

                  if(resultOptions){
                    response = await answerService.delete(widget.answerModel.key);
                    Navigator.pop(context, {"message": "Resposta deletada!", "type": "success"});
                  }
                } catch (error) {
                  SnackbarNotify.createSnackBar(context, {"message": "Não foi possível excluir a resposta!", "type": "error"});
                  throw Exception(error);
                }
              },
            ),
          ):
          const SizedBox(width: 30,),
        ],
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
          getInputs("Data de registro", const Icon(Icons.calendar_month, size: 20, color: Colors.white), widget.answerModel.dateregister),
          getInputs("Resultado do questionário", const Icon(Icons.spellcheck, size: 20, color: Colors.white), widget.answerModel.risk),
          getInputs("Pontuação", const Icon(Icons.assessment_outlined, size: 20, color: Colors.white), widget.answerModel.punctuation.toString()),
          getInputs("Parentesco:", const Icon(Icons.supervisor_account, size: 20, color: Colors.white), "", name()),
          getInputs("Nome do responsável:", const Icon(Icons.assignment_ind, size: 20, color: Colors.white), "", kinship()),
        ],
      ),
    );
  }

  Widget kinship(){
    return Container(
      height: 40,
      width: 320,
      padding: const EdgeInsets.only(right: 8, bottom: 10),
      child: TextFormField(
        initialValue: widget.answerModel.kinship,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(10.0)
          ),
        ),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center,
        validator: (String? value){
          if(value == null || value.isEmpty){
            return "Preencha o campo parentesco!";
          }
          return null;
        },
        onChanged: (String? kinship) => setState(() {
          if(kinship != null){
            setState(() {
              widget.answerModel.kinship = kinship;
            });
          }
        }),
      ),
    );
  }

  Widget name(){
    return Container(
      height: 40,
      width: 320,
      padding: const EdgeInsets.only(right: 8, bottom: 10),
      child: TextFormField(
        initialValue: widget.answerModel.name ,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(10.0)
          ),
        ),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center,
        validator: (String? value){
          if(value == null || value.isEmpty){
            return "Preencha o campo nome!";
          }
          return null;
        },
        onChanged: (String? name) => setState(() {
          if(name != null){
            setState(() {
              widget.answerModel.name = name;
            });
          }
        }),
      ),
    );
  }

  Widget getInputs(String title, Icon icon, String text, [Widget? textFormField]){

    return Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          Container(
            height: 40,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              color: textFormField != null? Colors.white: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
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
                textFormField ??
                Container(
                  width: 300,
                  child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87))
                )
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
    return Container(
        width: 120,
        child: ElevatedButton.icon(
          onPressed: () async {
            bool? response = false;
            Map<String, dynamic> message = {};

            if(_formkey.currentState!.validate()){
              try{
                if(widget.edit){
                  response = await answerService.update(widget.answerModel);
                  message = {"message": "Resposta atualizada!", "type": "success"};
                }else{
                  response = await answerService.create(widget.answerModel);
                  message = {"message": "Resposta cadastrada!", "type": "success"};
                }
                Navigator.pop(context, message);
              }catch(error){
                widget.edit?
                SnackbarNotify.createSnackBar(context, {"message": "Não foi possível atualizar a resposta!", "type": "error"})
                :
                SnackbarNotify.createSnackBar(context, {"message": "Não foi possível cadastrar a resposta!", "type": "error"});
                throw Exception(error);
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
    return Container(
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
