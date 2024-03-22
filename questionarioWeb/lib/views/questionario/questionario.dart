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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Questionario", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            print("with: ${constraints.maxWidth}");
            if(constraints.maxWidth < 730){
              return QuizPageMobile(questions: questions);
            }else if(constraints.maxWidth < 1250){
              return QuizPageTablet(questions: questions, maxWith: constraints.maxWidth);
            }else {
              return QuizPageDesktop(questions: questions);
            }
          }),
      ),
    );
  }
}