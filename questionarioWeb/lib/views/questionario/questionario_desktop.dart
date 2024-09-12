import 'package:flutter/material.dart';
import 'package:questionario/shared/showdialog_notify.dart';
import '../../shared/showdialog_modal_yes_no.dart';


class QuizPageDesktop extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final Map<String, dynamic> infos;

  const QuizPageDesktop({super.key, required this.questions, required this.infos});

  @override
  State<QuizPageDesktop> createState() => _QuizPageDesktopState();
}

class _QuizPageDesktopState extends State<QuizPageDesktop> {
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
            width: screenWidth * 0.8,
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("${answeredTotal.toString()}/20", style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
          SizedBox(
            width: screenWidth * 0.8,
            child: Column(
              children: [
                line(),
                listQuestions(screenHeight)
              ],
            ),
          ),
          butFinished()
        ],
      ),
    );
  }

  Widget line(){
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Text("Sim")
          ),
          Container(
              margin: const EdgeInsets.only(right: 40),
              child: const Text("Não")
          ),
        ],
      ),
    );
  }

  Widget listQuestions(num screenHeight){

    return SizedBox(
      height: screenHeight * 0.72,
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
      color: index%2==0? Colors.deepPurple.shade50: Colors.white,
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.deepPurple
                  ),
                  child: Text(q<10? "0${q.toString()}" : q.toString(), style: const TextStyle(fontSize: 12, color: Colors.white)),
                ),
                SizedBox(
                  width: 800,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info['first'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0XFF535353))),
                      info['second'] != ''?
                      Text(info['second'], style: const TextStyle(fontSize: 12, color: Color(0XFF535353))):
                      const SizedBox(height: 1)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: 100,
              margin: const EdgeInsets.only(right: 25),
              child: RadioWidget(index, updateAnswers, isAnswered, checking)
          ),
        ],
      ),
    );
  }

  Widget butFinished(){
    return Container(
      width: 200,
      padding: const EdgeInsets.only(top: 30),
      child: ElevatedButton(
          onPressed:  () async{
            String? option = "";

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
                  child: const Icon(Icons.send, size: 16, color: Colors.white)
              ),
              const Text("Enviar respostas", style: TextStyle(fontSize: 16, color: Colors.white))
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
  final Function(int index, String answer) updateAnswers;
  final bool isAnswered;
  final bool checking;

  const RadioWidget(this.index, this.updateAnswers, this.isAnswered, this.checking, {Key? key}) : super(key: key);

  @override
  _RadioWidgetState createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: widget.checking? widget.isAnswered ? null :  Border.all(color: Colors.red, width: 1) : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
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
        ],
      ),
    );
  }
}