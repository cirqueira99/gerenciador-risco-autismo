import 'package:flutter/material.dart';
import 'package:questionario/shared/showdialog_notify.dart';
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
  Map<String, dynamic> infos = {
    'viewQrcode': false,
    'answer': {
      'result': '',
      'answers': ['Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim', 'Sim']
    }
  };
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
      height: screenHeight * 0.72,
      width: 400,
      margin: const EdgeInsets.only(top: 25),
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
    int q = index+1;
    return Container(
      color: index%2==0? Colors.deepPurple.shade50: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 2),
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.deepPurple
                  ),
                  child: Text(q.toString(), style: const TextStyle(fontSize: 12, color: Colors.white)),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(info['first'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0XFF535353)), textAlign: TextAlign.center,),
                      info['second'] != ''?
                      Text(info['second'], style: const TextStyle(fontSize: 12, color: Color(0XFF535353)), textAlign: TextAlign.center):
                      const SizedBox(height: 1)
                    ],
                  ),
                ),
              ],
            ),
          ),
          RadioWidget(index, updateAnswers),
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

            if(infos['answer']['answers'].contains("")){
              message = {"message": "Responda todas as perguntas!", "type": "warning"};
              SnackBarNotify.createSnackBar(context, message);
            }else{
              try{
                option = await ShowDialogYesNo.exibirModalDialog(context, 'Atenção', 'Você deseja gerar QRcode das respostas?');

                if(option == "Yes" || option == "No" ){
                  infos['viewQrcode'] = option;
                  Navigator.pushReplacementNamed(context, '/resultado', arguments: infos);
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
      if(infos['answer']['answers'][index] == ""){
        answeredTotal += 1;
      }
      infos['answer']['answers'][index] = answer;
    });
  }
}

class RadioWidget extends StatefulWidget {
  final int index;
  final Function(int index, String answer) updateAnswers;

  const RadioWidget(this.index, this.updateAnswers, {Key? key}) : super(key: key);

  @override
  _RadioWidgetState createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 200,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'Sim',
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
          Container(
            width: 200,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'Não',
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