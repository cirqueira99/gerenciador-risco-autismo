
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerenciador/services/children_service.dart';
import 'package:gerenciador/services/qrcode_scanner.dart';
import 'package:gerenciador/views/answers/answer_add.dart';

import '../../services/answer_service.dart';
import '../../models/answer_model.dart';
import '../../models/child_model.dart';
import '../../shared/snackbar_notify.dart';

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
    print("Pontuação>>>>>> ${widget.children.punctuation}");
    _updatePage();
    super.initState();
  }

  Future<void> _updatePage() async {
    try{
      List<AnswerModel> listResponse = await answerService.getAll(widget.children.key.toString());
      setState(() {
        answersList = listResponse;
      });
    } catch (e) {
      print('Erro ao inicializar a caixa Hive: $e');
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
        backgroundColor: const Color(0xFF148174),
        title: const Text("Perfil da criança", style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            topInfos(),
            listAnswers(context, screenH, screenW)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () async {
          Map<String, dynamic> qrCodeInfo = {};
          Map<String, dynamic>? responseAddAnswer = {};
          bool? responseUpdatePunctuation = false;

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
                responseUpdatePunctuation = await childrenService.updatePunctuationChildren(widget.children);
                SnackbarNotify.createSnackBar(context, {"message": "Média de risco atualizada!", "type": "success"});
              }
            }else {
              SnackbarNotify.createSnackBar(context, {"message": "Erro ao scanear o QRcode!", "type": "error"});
            }
          }catch(error){
            SnackbarNotify.createSnackBar(context, {"message": "Não foi possível atualizar a média de risco!", "type": "error"});
            throw Exception(error);
          }finally{
            if(responseAddAnswer != null){
              _updatePage();
            }
          }
        },
      ),
    );
  }

  Widget topInfos(){
    return Container(
      height: 220,
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
                Text(widget.children.name, style: const TextStyle(fontSize: 18, color: Colors.white),),
                IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.more_vert, size: 30, color: Colors.white70,)
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
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF9FF),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Data de Nascimento: ${widget.children.dataNasc}", style: const TextStyle(fontSize: 12)),
          SizedBox(height: 20,),
          Text("Responsável: ${widget.children.responsible}", style: const TextStyle(fontSize: 12)),
          SizedBox(height: 20,),
          SizedBox(
              child: Row(
                children: [
                  const Text("Média do Risco: ", style: TextStyle(fontSize: 12)),
                  Text(widget.children.risk, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                ],
              )
          ),
        ],
      ),
    );
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Text("Resultado dos questionários", style: TextStyle(fontSize: 14),),
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.filter_alt, size: 25, color: Colors.black54)),
              const SizedBox(width: 10),
              IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_downward, size: 25, color: Colors.black54))
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
        bool? responseUpdatePunctuation = false;

        try{
          resultUpdateAnswer = await Navigator.push(context, MaterialPageRoute(builder: (context) => AnswerAdd(edit: true, answerModel: answer)));

          if(resultUpdateAnswer != null && resultUpdateAnswer.isNotEmpty){
            SnackbarNotify.createSnackBar(context, resultUpdateAnswer);
            await Future.delayed(const Duration(seconds: 2));
            if(resultUpdateAnswer['message'] == 'Resposta deletada!'){
              responseUpdatePunctuation = await childrenService.updatePunctuationChildren(widget.children);
              SnackbarNotify.createSnackBar(context, {"message": "Média de risco atualizada!", "type": "success"});
            }
          }
        }catch(error){
          SnackbarNotify.createSnackBar(context, {"message": "Não foi possível atualizar a média de risco!", "type": "error"});
          throw Exception(error);
        }finally{
          if(resultUpdateAnswer != null){
            _updatePage();
          }
        }
      },
      child: Container(
        height: 110,
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 15),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(answer.risk, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: getColor(answer.risk))),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Parentesco: ', style: TextStyle(fontSize: 14, color: Colors.black54)),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(answer.kinship, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Respondido por: ', style: TextStyle(fontSize: 14, color: Colors.black54)),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(answer.name, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                      )
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
      return const Color(0xFFDDD400);
    }else{
      return const Color(0xFFFF0000);
    }
  }
}

