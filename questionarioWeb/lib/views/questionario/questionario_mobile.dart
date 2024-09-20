import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../shared/showDialog_help.dart';
import '../../shared/showdialog_notify.dart';
import '../../shared/showdialog_modal_yes_no.dart';


class QuizPageMobile extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final Map<String, dynamic> infos;

  QuizPageMobile({super.key, required this.questions, required this.infos});

  @override
  State<QuizPageMobile> createState() => _QuizPageMobileState();
}

class _QuizPageMobileState extends State<QuizPageMobile> {
  Map<String, dynamic> message = {};
  num answeredTotal = 0;
  bool checking = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: screenWidth * 0.8,
            margin: const EdgeInsets.only(top: 10),
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${answeredTotal.toString()}/20", style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
          listQuestions(screenHeight, screenWidth),
          butFinished()
        ],
      ),
    );
  }

  Widget listQuestions(num screenHeight, num screenWidth){
    return Container(
      height: screenHeight * 0.75,
      width: 400,
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: widget.questions.length,
        itemBuilder: (_, index) {
          final Map<String, dynamic> info = widget.questions[index];
          return cardQuestion(info, index);
        },
      ),
    );
  }

  Widget cardQuestion(Map<String, dynamic> info, int index){
    bool isAnswered = widget.infos['result']['answers'][index] != "";
    int q = index+1;

    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.deepPurple.shade100, width: 1.0
              )
          )
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10, top: 2),
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.deepPurple
                  ),
                  child: Text(q<10? "0${q.toString()}" : q.toString(), style: const TextStyle(fontSize: 10, color: Colors.white)),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info['first'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0XFF535353)), textAlign: TextAlign.start,),
                      const SizedBox(height: 1)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              color: Colors.white,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RadioWidget(index, widget.infos['result']['answers'][index], isAnswered, checking, updateAnswers),
                  info['second'] != ""? iconHelp(info['second']) : const SizedBox(height: 2,),
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget iconHelp(String txtHelp){
    return SizedBox(
      child: IconButton(
        onPressed: () async {
          try{
             await ShowDialogHelp.exibirModalDialog(context, txtHelp);
          }catch(e){
            throw Exception(e);
          }
        },
        icon: const Icon(Icons.help, color: Colors.amber, size: 20,),
      ),
    );
  }

  Widget butFinished(){
    return Container(
      height: 60,
      width: 180,
      padding: const EdgeInsets.only(top: 30),
      child: ElevatedButton(
          onPressed:  () async{
            String option = "";

            if(widget.infos['result']['answers'].contains("")){
              message = {"message": "Responda todas as perguntas \n restantes em vermelho!", "type": "warning"};
              SnackBarNotify.createSnackBar(context, message);
              setState(() {
                checking = true;
              });
            }else{
              try{
                option = await ShowDialogYesNo.exibirModalDialog(context, 'Atenção', 'Você deseja gerar QRcode das respostas?');

                if(option == "Yes" || option == "No" ){
                  widget.infos['viewQrcode'] = option;
                  Navigator.pushReplacementNamed(context, '/resultado', arguments: widget.infos);
                }
              }catch(e){
                throw Exception(e);
              }
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(Icons.send, size: 12, color: Colors.white)
              ),
              const Text("Enviar respostas", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white))
            ],
          )
      ),
    );
  }

  void updateAnswers(int index, String answer){
    setState(() {
      if(widget.infos['result']['answers'][index] == ""){
        answeredTotal += 1;
      }
      widget.infos['result']['answers'][index] = answer;
    });
  }
}

class RadioWidget extends StatefulWidget {
  final int index;
  String valueAnswer;
  final bool isAnswered;
  final bool checking;
  final Function(int index, String answer) updateAnswers;

  RadioWidget(this.index, this.valueAnswer, this.isAnswered, this.checking, this.updateAnswers, {Key? key}) : super(key: key);

  @override
  _RadioWidgetState createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {

  @override
  Widget build(BuildContext context) {
    String? selectedOption = widget.valueAnswer;

    return Container(
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        border: widget.checking? widget.isAnswered ? null :  Border.all(color: Colors.red, width: 1) : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'sim',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                      widget.updateAnswers(widget.index, selectedOption!);
                    });
                  },
                ),
                const Text("Sim", style: TextStyle(fontSize: 12, color: Colors.black54),)
              ],
            ),
          ),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'não',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                      widget.updateAnswers(widget.index, selectedOption!);
                    });
                  },
                ),
                const Text("Não", style: TextStyle(fontSize: 12, color: Colors.black54),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}