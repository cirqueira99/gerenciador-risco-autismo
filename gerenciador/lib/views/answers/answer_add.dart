import 'package:flutter/material.dart';
import 'package:gerenciador/services/answer_service.dart';
import 'package:gerenciador/shared/snackbar_dialog_yes_no.dart';
import 'package:gerenciador/shared/snackbar_notify.dart';
import 'package:intl/intl.dart';

import 'package:gerenciador/models/answer_model.dart';


class AnswerAdd extends StatefulWidget {
  final bool edit;
  AnswerModel answerModel;

  AnswerAdd({super.key, required this.edit, required this.answerModel});

  @override
  State<AnswerAdd> createState() => _AnswersAddState();
}

class _AnswersAddState extends State<AnswerAdd> {
  AnswerService answerService = AnswerService();
  bool validing = false;
  bool formsValid = false;

  @override
  void initState(){
    _initValuesAnswer();
    super.initState();
  }

  _initValuesAnswer() {
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
        backgroundColor: const Color(0xFF184F49),
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

                try {
                  resultOptions = await SnackbarDialogYesNo.exibirModalDialog(context, 'Confirmar exclusão?', 'Isso irá mudar a média dos resultados de risco');

                  if(resultOptions){
                    await answerService.delete(widget.answerModel.key);
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
          getInputs("Data de registro", const Icon(Icons.calendar_month, size: 20, color: Colors.white), widget.answerModel.dateregister),
          getInputs("Resultado do questionário", const Icon(Icons.spellcheck, size: 20, color: Colors.white), widget.answerModel.risk),
          getInputs("Pontuação", const Icon(Icons.assessment_outlined, size: 20, color: Colors.white), widget.answerModel.punctuation.toString()),
          getInputs("Respondido por", const Icon(Icons.supervisor_account, size: 20, color: Colors.white), widget.answerModel.name, name(screenW)),
          getInputs("Parentesco", const Icon(Icons.assignment_ind, size: 20, color: Colors.white), widget.answerModel.kinship, kinship(screenW)),
        ],
      ),
    );
  }

  Widget name(num screenW){
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
                keyboardType: TextInputType.text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                decoration: InputDecoration(
                    hintText: widget.answerModel.name == "" ? 'Digite aqui...' : widget.answerModel.name,
                    hintStyle: widget.answerModel.name == "" ?
                      TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey.shade500, fontStyle: FontStyle.italic) :
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green.shade900, fontStyle: FontStyle.normal),
                    counterStyle: const TextStyle(fontSize: 10),
                    border: InputBorder.none
                ),
                onChanged: (String value) {
                  setState(() {
                    widget.answerModel.name = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget kinship(num screenW){
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
                keyboardType: TextInputType.text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                decoration: InputDecoration(
                    hintText: widget.answerModel.kinship == "" ? 'Digite aqui...' : widget.answerModel.kinship,
                    hintStyle: widget.answerModel.kinship == "" ?
                    TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey.shade500, fontStyle: FontStyle.italic) :
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green.shade900, fontStyle: FontStyle.normal),
                    counterStyle: const TextStyle(fontSize: 10),
                    border: InputBorder.none
                ),
                onChanged: (String value) {
                  setState(() {
                    widget.answerModel.kinship = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getInputs(String title, Icon icon, String text, [Widget? textFormField]){
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
              color: textFormField != null? Colors.white: Colors.grey.shade100,
              border: validing? text.isNotEmpty? Border.all(color: Colors.grey.shade500) : Border.all(color: Colors.red.shade500) : Border.all(color: Colors.grey.shade500),
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
                SizedBox(
                    width: screenW * 0.70,
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

            if(validInputs()){
              try{
                if(widget.edit){
                  await answerService.update(widget.answerModel);
                  message = {"message": "Resposta atualizada!", "type": "success"};
                }else{
                  await answerService.create(widget.answerModel);
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

    if( widget.answerModel.kinship.isEmpty || widget.answerModel.name.isEmpty){
      isValid = false;
    }

    return isValid;
  }
}
