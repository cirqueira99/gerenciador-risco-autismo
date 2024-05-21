import 'package:flutter/material.dart';
import 'package:questionario/shared/showdialog_notify.dart';
import '../../shared/showdialog_modal_yes_no.dart';


class QuizPageTablet extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final Map<String, dynamic> infos;
  final num maxWith;

  const QuizPageTablet({super.key, required this.questions, required this.infos, required this.maxWith});

  @override
  State<QuizPageTablet> createState() => _QuizPageTabletState();
}

class _QuizPageTabletState extends State<QuizPageTablet> {
  Map<String, dynamic> message = {};
  num answeredTotal = 0;

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

  Widget cardQuestion(Map<String, dynamic> question, int index){
    int q = index+1;
    return Container(
      color: index%2==0? Colors.deepPurple.shade50: Colors.white,
      height: widget.maxWith > 850? 80: 100,
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
                  child: Text(q.toString(), style: const TextStyle(fontSize: 12, color: Colors.white)),
                ),
                SizedBox(
                  width: widget.maxWith > 850? 500: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(question['first'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0XFF535353))),
                      question['second'] != ''?
                      Text(question['second'], style: const TextStyle(fontSize: 12, color: Color(0XFF535353))):
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
              child: RadioWidget(index, updateAnswers)
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
            String option = "";

            if(widget.infos['answer']['answers'].contains("")){
              message = {"message": "Responda todas as perguntas!", "type": "warning"};
              SnackBarNotify.createSnackBar(context, message);
            }else{
              try{
                option = await ShowDialogYesNo.exibirModalDialog(context, 'Atenção', 'Você deseja gerar QRcode das respostas?');

                if(option == "Yes" || option == "No" ){
                  widget.infos['viewQrcode'] = option;
                  Navigator.pushReplacementNamed(context, '/resultado', arguments: widget.infos);
                }
              }catch(e){
                print(e.toString());
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
      if(widget.infos['answer']['answers'][index] == ""){
        answeredTotal += 1;
      }
      widget.infos['answer']['answers'][index] = answer;
    });
  }
}

class RadioWidget extends StatefulWidget {
  int index;
  final Function(int index, String answer) utpadeAnswers;

  RadioWidget(this.index, this.utpadeAnswers, {super.key});

  @override
  _RadioWidgetState createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Radio<String>(
          value: 'Sim',
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
              widget.utpadeAnswers(widget.index, selectedOption!);
            });
          },
        ),
        Radio<String>(
          value: 'Não',
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
              widget.utpadeAnswers(widget.index, selectedOption!);
            });
          },
        ),
      ],
    );
  }
}