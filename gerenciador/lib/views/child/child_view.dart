
import 'package:flutter/material.dart';
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
  AnswerService answerService = AnswerService();
  QrCodeScanner qrCodeScanner = QrCodeScanner();
  List<AnswerModel> answersList = [];

  @override
  void initState(){
    _getInfosPage();

    super.initState();
  }

  Future<void> _getInfosPage() async {
    try{
      List<AnswerModel> listResponse = await answerService.getAll(widget.children.id!);
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
            listAnswers(screenH, screenW)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () async {
          Map<String, dynamic> qrCodeInfo = {};
          Map<String, dynamic>? resultAddAnswer = {};

          try{
            qrCodeInfo = await qrCodeScanner.readQRcode();

            if(qrCodeInfo['answers'] != 'Não validado'){
                print(qrCodeInfo);
                resultAddAnswer = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        AnswerAdd(
                          edit: false,
                          qrCodeInfo: qrCodeInfo,
                          answerModel: AnswerModel(fkchildren: widget.children.id!, dateregister: '', risk: '', punctuation: 0, kinship: '', name: ''),
                        )
                    )
                );

                if(resultAddAnswer != null){
                  SnackBarNotify.createSnackBar(context, resultAddAnswer);
                  _getInfosPage();
                }
            }
          }catch(error){
            SnackBarNotify.createSnackBar(context, {"message": "Erro ao scanear o QRcode!", "type": "error"});
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
      child: Text("infos", style: TextStyle(fontSize: 12)),
    );
  }

  Widget listAnswers(num sH, num sW){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          filter(),
          list(sH)
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

  Widget list(num sH){
    return SizedBox(
      height: sH * 0.55,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: answersList.length,
          itemBuilder: (_, index) {
            final AnswerModel item = answersList[index];
            return card(item);
          }
      ),
    );
  }

  Widget card(AnswerModel answer){
    return GestureDetector(
      onTap: () async{
        Map<String, dynamic>? resultUpdateAnswer = {};
        try{
          resultUpdateAnswer = await Navigator.push(context, MaterialPageRoute(builder: (context) => AnswerAdd(edit: true, qrCodeInfo: {}, answerModel: answer)));
        }catch(error){
          throw Exception(error);
        }finally{
          if(resultUpdateAnswer != null){
            SnackBarNotify.createSnackBar(context, resultUpdateAnswer);
            _getInfosPage();
          }
        }
      },
      child: Container(
        height: 90,
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 15),
        margin:  const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFF6FFFE),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Parentesco: ', style: TextStyle(fontSize: 12, color: Colors.black45)),
                      Text(answer.kinship, style: const TextStyle(fontSize: 12))
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Nome: ', style: TextStyle(fontSize: 12, color: Colors.black45)),
                      Text(answer.name, style: const TextStyle(fontSize: 12))
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Resultado: ', style: TextStyle(fontSize: 12, color: Colors.black45)),
                      Text('Risco ${answer.risk}', style: const TextStyle(fontSize: 12))
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 100,
              width: 30,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert, size: 25)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

