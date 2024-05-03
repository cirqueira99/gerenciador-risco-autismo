import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerenciador/models/answer_model.dart';
import 'package:intl/intl.dart';

class AnswerAdd extends StatefulWidget {
  bool edit;
  Map<String, dynamic> qrCodeInfo = {};

  AnswerAdd({super.key, required this.edit, required this.qrCodeInfo});

  @override
  State<AnswerAdd> createState() => _AnswersAddState();
}

class _AnswersAddState extends State<AnswerAdd> {
  String dateRegister = DateFormat('dd/MM/yyyy').format(DateTime.now());
  AnswerModal answerModal = AnswerModal(id: '', fkchildren: '', dateregister: '', kinship: '', name: '', risk: '', punctuation: 0);

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF148174),
        title: Text(widget.edit? "Editar resposta": 'Cadastrar resposta', style: const TextStyle(fontSize: 20, color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              Map<String, dynamic> message = {};
              bool response = false;
              bool option = false;

              try {
                
              } catch (error) {
                
                throw Exception(error);
              } finally {
                Navigator.pop(context, message);
              }
            },
          ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.shade300, width: 2.0
                    )
                )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFF26877B),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Icon(Icons.calendar_month, size: 20, color: Colors.white),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Data de registro", style: TextStyle(fontSize: 12)),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text("20/20/2020", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.shade300, width: 2.0
                    )
                )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: const Color(0xFF26877B),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Icon(Icons.check_box, size: 20, color: Colors.white),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Resultado do questionário:", style: TextStyle(fontSize: 12)),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text("Risco Médio", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.shade300, width: 2.0
                    )
                )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: const Color(0xFF26877B),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Icon(Icons.list, size: 20, color: Colors.white),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Respostas com SIM:", style: TextStyle(fontSize: 12)),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text("11/20", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Container(

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: const Color(0xFF26877B),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Icon(Icons.person, size: 20, color: Colors.white),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Nome do responsável:", style: TextStyle(fontSize: 12)),
                        name()
                      ],
                    )),
              ],
            ),
          ),
          Container(

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: const Color(0xFF26877B),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Icon(Icons.perm_identity, size: 20, color: Colors.white),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Parentesco", style: TextStyle(fontSize: 12)),
                        kinship()
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget name(){
    return Container(
      height: 40,
      width: 300,
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        initialValue: widget.edit? answerModal.name : 'Roberta de Oliveira Juliano da Silva',
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0)
          ),
        ),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        validator: (String? value){
          if(value == null || value.isEmpty){
            return "Preencha o campo descrição!";
          }
          return null;
        },
        onChanged: (String? value) => setState(() {

        }),
      ),
    );
  }

  Widget kinship(){
    return Container(
      height: 40,
      width: 300,
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        initialValue: widget.edit? answerModal.kinship : 'Mãe',
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0)
          ),
        ),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        validator: (String? value){
          if(value == null || value.isEmpty){
            return "Preencha o campo descrição!";
          }
          return null;
        },
        onChanged: (String? value) => setState(() {

        }),
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
          onPressed: (){},
          icon: const Icon(Icons.save, size: 20, color: Colors.white),
          label: const Text("Salvar", style: TextStyle(fontSize: 12, color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF26877B)
          ),
        )
    );
  }

  Widget btnCancel(){
    return Container(
        width: 120,
        child: OutlinedButton.icon(
            onPressed: (){},
            icon: const Icon(Icons.cancel_outlined, size: 20, color: Color(0xFF26877B)),
            label: const Text("Cancelar", style: TextStyle(fontSize: 12, color: Color(0xFF26877B))),
        )
    );
  }
}
