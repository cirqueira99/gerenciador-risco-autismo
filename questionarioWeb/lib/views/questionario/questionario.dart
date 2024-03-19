import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questionario/shared/snackbar_notify.dart';
import 'package:questionario/views/questionario/questionario_desktop.dart';
import 'package:questionario/views/questionario/questionario_mobile.dart';
import 'package:questionario/views/questionario/questionario_tablet.dart';


class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Map<String, dynamic> data = {
    'codHash': '111111',
    'result': '',
    'answers': ['Sim', 'Não', 'Sim', 'Sim', 'Não', 'Sim', 'Não', 'Sim', 'Não', 'Sim', 'Não', 'Sim', 'Não', 'Sim', 'Não', 'Não', 'Sim', 'Não', 'Sim', 'Não']
  };

  //'answers': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']
  List<Map<String, dynamic>> questions = [
    {
      'first': 'Se você apontar para algum objeto no quarto, a sua filha olha para este objeto? ',
      'second': '(POR EXEMPLO, se você apontar para um brinquedo ou animal, a sua filha olha para o brinquedo ou para o animal?)'
    },
    {
      'first': 'Alguma vez você se perguntou se a sua filha pode ser surda?',
      'second': ''
    },
    {
      'first': 'A sua filha brinca de faz de contas?',
      'second': '(POR EXEMPLO, faz de conta que bebe em um copo vazio, faz de conta que fala ao telefone, faz de conta que dá comida a uma boneca ou a um bichinho de pelúcia?)'
    },
    {
      'first': 'A sua filha gosta de subir nas coisas?',
      'second': '(POR EXEMPLO, móveis, brinquedos em parques ou escadas)'
    },
    {
      'first': 'A sua filha faz movimentos estranhos com os dedos perto dos olhos?',
      'second': '(POR EXEMPLO, mexe os dedos em frente aos olhos e fica olhando para os mesmos?)'
    },
    {
      'first': 'A sua filha aponta com o dedo para pedir algo ou para conseguir ajuda?',
      'second': '(POR EXEMPLO, aponta para um biscoito ou brinquedo fora do alcance dele?)',
    },
    {
      'first': 'A sua filha aponta com o dedo para mostrar algo interessante para você?',
      'second': '(POR EXEMPLO, aponta para um avião no céu ou um caminhão grande na rua)',
    },
    {
      'first': 'A sua filha se interessa por outras crianças?',
      'second': '(POR EXEMPLO, sua filha olha para outras crianças, sorri para elas ou se aproxima delas?)',
    },
    {
      'first': 'A sua filha traz coisas para mostrar para você ou as segura para que você as veja - não para conseguir ajuda, mas apenas para compartilhar?',
      'second': '(POR EXEMPLO, para mostrar uma flor, um bichinho de pelúcia ou um caminhão de brinquedo)',
    },
    {
      'first': 'A sua filha responde quando você a chama pelo nome? ',
      'second': '(POR EXEMPLO, ela olha para você, fala ou emite algum som, ou para o que está fazendo quando você a chama pelo nome?)'
    },
    {
      'first': 'Quando você sorri para a sua filha, ela sorri de volta para você?',
      'second': ''
    },
    {
      'first': 'A sua filha fica muito incomodada com barulhos do dia a dia?',
      'second': '(POR EXEMPLO, sua filha grita ou chora ao ouvir barulhos como os de liquidificador ou de música alta?)'
    },
    {
      'first': 'A sua filha anda?',
      'second': ''
    },
    {
      'first': 'A sua filha olha nos seus olhos quando você está falando ou brincando com ela, ou vestindo a roupa dela?',
      'second': ''
    },
    {
      'first': 'A sua filha tenta imitar o que você faz?',
      'second': '(POR EXEMPLO, quando você dá tchau, ou bate palmas, ou joga um beijo, ela repete o que você faz?)'
    },
    {
      'first': 'Quando você vira a cabeça para olhar para alguma coisa, a sua filha olha ao redor para ver o que você está olhando?',
      'second': ''
    },
    {
      'first': 'A sua filha tenta fazer você olhar para ela?',
      'second': '(POR EXEMPLO, a sua filha olha para você para ser elogiada/aplaudida, ou diz: “olha mãe!” ou “óh mãe!”)'
    },
    {
      'first': 'A sua filha compreende quando você pede para ela fazer alguma coisa?',
      'second': '(POR EXEMPLO, se você não apontar, a sua filha entende quando você pede: “coloca o copo na mesa” ou “liga a televisão”?)'
    },
    {
      'first': 'Quando acontece algo novo, a sua filha olha para o seu rosto para ver como você se sente sobre o que aconteceu?',
      'second': '(POR EXEMPLO, se ela ouve um barulho estranho ou vê algo engraçado, ou vê um brinquedo novo, será que ela olharia para seu rosto?)'
    },
    {
      'first': 'A sua filha gosta de atividades de movimento?',
      'second': '(POR EXEMPLO, ser balançado ou pular em seus joelhos)'
    },
  ];
  Map<String, dynamic> message = {};


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Questionario", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            print("with: ${constraints.maxWidth}");
            if(constraints.maxWidth < 730){
              return QuizPageMobile();
            }else if(constraints.maxWidth < 1250){
              return QuizPageTablet(constraints.maxWidth);
            }else {
              return QuizPageDesktop();
            }
          }),
      ),
    );
  }

  Widget informHash(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Se você recebeu o código de acesso, informe no campo abaixo.", style: TextStyle(fontSize: 14)),
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
          )
        ],
      ),
    );
  }

  Widget line(){
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
              child: Text("Sim")
          ),
          Container(
              margin: EdgeInsets.only(right: 40),
              child: const Text("Não")
          ),
        ],
      ),
    );
  }

  Widget listQuestions(num screenHeight){

    return Container(
      height: screenHeight * 0.60,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: questions.length,
        itemBuilder: (_, index) {
          final Map<String, dynamic> info = questions[index];
          return cardQuestion(info, index);
        },
      ),
    );
  }

  Widget cardQuestion(Map<String, dynamic> info, int index){
    int q = index+1;
    return Container(
      color: index%2==0? Colors.deepPurple.shade50: Colors.white,
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
                  width: 800,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info['first'], style: const TextStyle(fontSize: 13, color: Colors.black)),
                      info['second'] != ''?
                      Text(info['second'], style: const TextStyle(fontSize: 13, color: Colors.black87)):
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
              child: RadioWidget(index, utpadeAnswers)
          ),
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