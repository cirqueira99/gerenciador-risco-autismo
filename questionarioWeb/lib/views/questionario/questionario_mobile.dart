import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:questionario/shared/snackbar_notify.dart';


class QuizPageMobile extends StatefulWidget {
  late List<Map<String, dynamic>> questions;

  QuizPageMobile({super.key, required this.questions});

  @override
  State<QuizPageMobile> createState() => _QuizPageMobileState();
}

class _QuizPageMobileState extends State<QuizPageMobile> {
  Map<String, dynamic> data = {
    'codHash': '',
    'result': '',
    'answers': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']
  };

  Map<String, dynamic> message = {};

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Text("O que é o código?", style: TextStyle(fontSize: 12),),
                      //Icon(Icons.account_circle_rounded, size: 16, color: Colors.deepPurple,)
                    ],
                  ),
                ),
                informHash()
              ],
            ),
          ),
          listQuestions(screenHeight, screenWidth),
          butFinished()
        ],
      ),
    );
  }

  Widget informHash(){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Se você recebeu o código de acesso, informe no campo abaixo.", style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
          SizedBox(
            width: double.infinity,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 250,
                    margin: const EdgeInsets.only(top: 20, bottom: 5, left: 0, right: 5),
                    child: TextFormField(
                      initialValue: '',
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Informe o código...',
                        labelStyle: const TextStyle(fontSize: 12, color: Colors.black54),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2, color: Colors.black12),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                      style: const TextStyle(fontSize: 14, color: Colors.deepPurple),
                      validator: (String? value){
                        if(value == null || value.isEmpty){
                          return "Preencha o campo descrição!";
                        }
                        return null;
                      },
                      onChanged: (String? value) => setState(() {
                        data['codHash'] = value ?? "";
                      }),
                    ),
                  ),
                  Container(
                      height: 25,
                      width: 25,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple,
                      ),
                      margin: const EdgeInsets.only(left: 10),
                      child: const Icon(Icons.question_mark, size: 20, color: Colors.white,)
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget listQuestions(num screenHeight, num screenWidth){

    return Container(
      height: screenHeight * 0.60,
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
      height: info['second'] != ''? 160: 110,
      color: index%2==0? Colors.deepPurple.shade50: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
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
                  padding: EdgeInsets.only(right: 10),
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(info['first'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black), textAlign: TextAlign.center,),
                      info['second'] != ''?
                      Text(info['second'], style: const TextStyle(fontSize: 12, color: Colors.black87), textAlign: TextAlign.center):
                      const SizedBox(height: 1)
                    ],
                  ),
                ),
              ],
            ),
          ),
          RadioWidget(index, utpadeAnswers),
        ],
      ),
    );
  }

  Widget butFinished(){
    return Container(
      width: 200,
      padding: const EdgeInsets.only(top: 40),
      child: ElevatedButton(
          onPressed: (){
            if(data['answers'].contains("")){
              message = {"message": "Responda todas as perguntas!", "type": "warning"};
              SnackBarNotify.createSnackBar(context, message);
            }else{
              Navigator.pushReplacementNamed(context, '/resultado', arguments: data);
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

  void utpadeAnswers(int index, String answer){
    data['answers'][index] = answer;
    print(data['answers']);
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
    return Container(

      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
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
                      widget.utpadeAnswers(widget.index, selectedOption!);
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
                      widget.utpadeAnswers(widget.index, selectedOption!);
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