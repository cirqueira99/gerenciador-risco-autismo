import 'package:flutter/material.dart';
import 'package:gerenciador/services/children_service.dart';
import 'package:gerenciador/services/qrcode_scanner.dart';
import 'package:gerenciador/views/answers/answer_add.dart';

import '../../services/answer_service.dart';
import '../../models/answer_model.dart';
import '../../models/child_model.dart';
import '../../shared/snackbar_dialog_yes_no.dart';
import '../../shared/snackbar_notify.dart';
import 'child_add.dart';

class ChildrenPage extends StatefulWidget {
  final ChildrenModel children;

  ChildrenPage({super.key, required this.children});

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  ChildrenService childrenService = ChildrenService();
  AnswerService answerService = AnswerService();
  QrCodeScanner qrCodeScanner = QrCodeScanner();
  List<AnswerModel> answersList = [];

  @override
  void initState(){
    _refreshPage();
    super.initState();
  }

  Future<void> _refreshPage() async {
    try{
      List<AnswerModel> listResponse = await answerService.getAll(widget.children.key.toString());
      setState(() {
        answersList = listResponse;
      });
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  void dispose() async{
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF184F49),
        title: const Text("Perfil da criança", style: TextStyle(fontSize: 20, color: Colors.white)),
        actions: [
          Container(
            width: 50,
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.white,),
              onPressed: () async {
                bool resultOptions = false;
                bool? responseChildrenDelete = false;
                bool? responseAnswersListDelete = false;

                try {
                  resultOptions = await SnackbarDialogYesNo.exibirModalDialog(context, 'Confirmar exclusão do perfil da criança?', 'Isso irá apagar todas as respostas cadastradas junto ao perfil!');

                  if(resultOptions){
                    responseChildrenDelete = await childrenService.delete(widget.children.key);
                    responseAnswersListDelete = await answerService.deleteList(answersList);

                    Navigator.pop(context, {"message": "Perfil deletado com sucesso!", "type": "success"});
                  }
                } catch (error) {
                  if(responseChildrenDelete == null){
                    SnackbarNotify.createSnackBar(context, {"message": "Não foi possível excluir a criança!", "type": "error"});
                  }else
                  if(responseAnswersListDelete == null){
                    SnackbarNotify.createSnackBar(context, {"message": "Não foi possível excluir as respostas!", "type": "error"});
                  }
                  throw Exception(error);
                }
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              topInfos(),
              listAnswers(context, screenH, screenW)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () async {
          Map<String, dynamic> qrCodeInfo = {};
          Map<String, dynamic>? responseAddAnswer = {};

          try{
            qrCodeInfo = await qrCodeScanner.readQRcode();

            if(qrCodeInfo['result'] != 'Não validado'){
              responseAddAnswer = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      AnswerAdd(edit: false, answerModel: AnswerModel(fkchildren: widget.children.key.toString(), dateregister: '', risk: qrCodeInfo['risk'], punctuation: qrCodeInfo['punctuation'], kinship: '', name: ''),)
                  )
              );

              if(responseAddAnswer != null && responseAddAnswer.isNotEmpty){
                SnackbarNotify.createSnackBar(context, responseAddAnswer);
                await Future.delayed(const Duration(seconds: 2));
                await childrenService.updatePunctuationChildren(widget.children);
                SnackbarNotify.createSnackBar(context, {"message": "Média de risco atualizada!", "type": "success"});
              }
            }else {
              SnackbarNotify.createSnackBar(context, {"message": "QRcode não escaneado!", "type": "warning"});
            }
          }catch(error){
            SnackbarNotify.createSnackBar(context, {"message": "Não foi possível atualizar a média de risco!", "type": "error"});
            throw Exception(error);
          }finally{
            if(responseAddAnswer != null){
              _refreshPage();
            }
          }
        },
      ),
    );
  }

  Widget topInfos(){
    return Container(
      height: 200,
      width: double.infinity,
      color: const Color(0xFF23645D),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.children.name, style: const TextStyle(fontSize: 20, color: Colors.white),),
                IconButton(
                    onPressed: () async{
                      Map<String, dynamic>? resultChildrenPage = {};

                      try{
                        resultChildrenPage = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                ChildrenAdd(edit: true, childrenModel: widget.children)
                            )
                        );
                        if(resultChildrenPage != null && resultChildrenPage.isNotEmpty){
                          SnackbarNotify.createSnackBar(context, resultChildrenPage);
                        }
                      }catch(error){
                        throw Exception(error);
                      }finally{
                        _refreshPage();
                      }
                    },
                    icon: const Icon(Icons.edit, size: 25, color: Colors.white70,)
                ),
              ],
            ),
          ),
          infosChildren()
        ],
      ),
    );
  }

  Widget infosChildren(){
    return Container(
      height: 130,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF9FF),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Data de Nasc:", style: TextStyle(fontSize: 14, color: Colors.black54)),
                        Text(widget.children.dataNasc, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Idade:", style: TextStyle(fontSize: 14, color: Colors.black54)),
                        Text("${calcAge(widget.children.dataNasc)} anos", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Sexo:", style: TextStyle(fontSize: 14, color: Colors.black54)),
                        Text(widget.children.sex, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Média:", style: TextStyle(fontSize: 14, color: Colors.black54)),
                        Text(widget.children.risk == ''? '---': widget.children.risk, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: getColor(widget.children.risk)))
                      ],
                    ),
                  )
                ],
              )
          ),
          SizedBox(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Responsável: ", style: TextStyle(fontSize: 14, color: Colors.black54)),
                      Text(widget.children.responsible, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

  String calcAge(String dateNasc) {
    int age = 0;
    List<String> partes = dateNasc.split('/');
    int dia = int.parse(partes[0]);
    int mes = int.parse(partes[1]);
    int ano = int.parse(partes[2]);

    DateTime dataNasc = DateTime(ano, mes, dia);
    DateTime dataAtual = DateTime.now();

    age = dataAtual.year - dataNasc.year;

    if (dataAtual.month < dataNasc.month || (dataAtual.month == dataNasc.month && dataAtual.day < dataNasc.day)) {
      age--;
    }

    return age.toString();
  }

  Widget listAnswers(BuildContext context, num sH, num sW){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          filter(),
          answersList.isNotEmpty?
          list(context, sH) :
          Container(
            height: 40,
            width: sW * 0.9,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.only(top: 80, bottom: 30),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Não existem respostas cadastradas!", style: TextStyle(fontSize: 14), textAlign: TextAlign.center,),
              ],
            )
          )
        ],
      ),
    );
  }

  Widget filter(){
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey.shade200, width: 2.0
              )
          )
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Row(
            children: [
              Text("Resultado dos questionários", style: TextStyle(fontSize: 14),),
            ],
          )
        ],
      ),
    );
  }

  Widget list(BuildContext context, num sH){
    return SizedBox(
      height: sH * 0.55,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: answersList.length,
          itemBuilder: (_, index) {
            final AnswerModel item = answersList[index];
            return card(context, item);
          }
      ),
    );
  }

  Widget card(BuildContext context, AnswerModel answer){
    return GestureDetector(
      onTap: () async{
        Map<String, dynamic>? resultUpdateAnswer = {};

        try{
          resultUpdateAnswer = await Navigator.push(context, MaterialPageRoute(builder: (context) => AnswerAdd(edit: true, answerModel: answer)));

          if(resultUpdateAnswer != null && resultUpdateAnswer.isNotEmpty){
            SnackbarNotify.createSnackBar(context, resultUpdateAnswer);
            await Future.delayed(const Duration(seconds: 1));
            if(resultUpdateAnswer['message'] == 'Resposta deletada!'){
              await childrenService.updatePunctuationChildren(widget.children);
              SnackbarNotify.createSnackBar(context, {"message": "Média de risco atualizada!", "type": "success"});
            }
          }
        }catch(error){
          SnackbarNotify.createSnackBar(context, {"message": "Não foi possível atualizar a média de risco!", "type": "error"});
          throw Exception(error);
        }finally{
          if(resultUpdateAnswer != null){
            _refreshPage();
          }
        }
      },
      child: Container(
        height: 110,
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
        margin:  const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: const Offset(2, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                height: 20,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(answer.dateregister, style: const TextStyle(fontSize: 12, color: Colors.black)),
                  ],
                )
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Resultado: ', style: TextStyle(fontSize: 14, color: Colors.black54)),
                      Text(answer.risk, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: getColor(answer.risk)))
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Parentesco: ', style: TextStyle(fontSize: 14, color: Colors.black54)),
                      Text(answer.kinship, style: const TextStyle(fontSize: 14, color: Colors.black87))
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Nome: ', style: TextStyle(fontSize: 14, color: Colors.black54)),
                      Text(answer.name, style: const TextStyle(fontSize: 14, color: Colors.black87))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(String risk){
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

