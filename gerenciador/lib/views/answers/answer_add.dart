import 'package:flutter/material.dart';
import 'package:gerenciador/services/answer_service.dart';
import 'package:gerenciador/shared/snackbar_notify.dart';
import 'package:intl/intl.dart';

import 'package:gerenciador/models/answer_model.dart';


class AnswerAdd extends StatefulWidget {
  bool edit;
  Map<String, dynamic> qrCodeInfo = {};
  AnswerModal answerModal;

  AnswerAdd({super.key, required this.edit, required this.qrCodeInfo, required this.answerModal});

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
        widget.answerModal.id = '5';
        widget.answerModal.dateregister = DateFormat('dd/MM/yyyy').format(DateTime.now());
        widget.answerModal.risk = 'Baixo';
        widget.answerModal.punctuation = 0.2;
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
      child: Form(
          key: _formkey,
          child: forms()
      )
    );
  }

  Widget forms(){
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xFF26877B),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Icon(Icons.calendar_month, size: 20, color: Colors.white),
                ),
                Container(
                    width: 320,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 2.0
                            )
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Data de registro", style: TextStyle(fontSize: 12)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(widget.answerModal.dateregister, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xFF26877B),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Icon(Icons.check_box, size: 20, color: Colors.white),
                ),
                Container(
                    width: 320,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 2.0
                            )
                        )
                    ),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Resultado do questionário:", style: TextStyle(fontSize: 12)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(widget.answerModal.risk, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xFF26877B),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Icon(Icons.list, size: 20, color: Colors.white),
                ),
                Container(
                    width: 320,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 2.0
                            )
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Pontuação:", style: TextStyle(fontSize: 12)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(widget.answerModal.punctuation.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xFF26877B),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Icon(Icons.perm_identity, size: 20, color: Colors.white),
                ),
                Container(
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
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xFF26877B),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Icon(Icons.person, size: 20, color: Colors.white),
                ),
                Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Respondido por:", style: TextStyle(fontSize: 12)),
                        name()
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget kinship(){
    return Container(
      height: 40,
      width: 320,
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        initialValue: widget.answerModal.kinship,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0)
          ),
        ),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        validator: (String? value){
          if(value == null || value.isEmpty){
            return "Preencha o campo parentesco!";
          }
          return null;
        },
        onChanged: (String? kinship) => setState(() {
          if(kinship != null){
            setState(() {
              widget.answerModal.kinship = kinship;
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
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        initialValue: widget.answerModal.name ,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0)
          ),
        ),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        validator: (String? value){
          if(value == null || value.isEmpty){
            return "Preencha o campo nome!";
          }
          return null;
        },
        onChanged: (String? name) => setState(() {
          if(name != null){
            setState(() {
              widget.answerModal.name = name;
            });
          }
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
          onPressed: () async {
            bool? response = false;
            Map<String, dynamic> message = {};

            if(_formkey.currentState!.validate()){
              try{
                response = await answerService.create(widget.answerModal);
                message = {"message": "Resposta cadastrada!", "type": "success"};
              }catch(error){
                print('>>>> Erro: $error');
                message = {"message": "Não foi possível realizar o cadastro!", "type": "error"};
              }finally {
                if(response == true){
                  Navigator.pop(context, message);
                }else {
                  SnackBarNotify.createSnackBar(context, message);
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
