import 'package:flutter/material.dart';
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
      'first': 'Se você apontar para algum objeto no quarto, a seu(sua) filho(a) olha para este objeto? ',
      'second': '(POR EXEMPLO, se você apontar para um brinquedo ou animal, a seu(sua) filho(a) olha para o brinquedo ou para o animal?)'
    },
    {
      'first': 'Alguma vez você se perguntou se a seu(sua) filho(a) pode ser surda?',
      'second': ''
    },
    {
      'first': 'A seu(sua) filho(a) brinca de faz de contas?',
      'second': '(POR EXEMPLO, faz de conta que bebe em um copo vazio, faz de conta que fala ao telefone, faz de conta que dá comida a uma boneca ou a um bichinho de pelúcia?)'
    },
    {
      'first': 'A seu(sua) filho(a) gosta de subir nas coisas?',
      'second': '(POR EXEMPLO, móveis, brinquedos em parques ou escadas)'
    },
    {
      'first': 'A seu(sua) filho(a) faz movimentos estranhos com os dedos perto dos olhos?',
      'second': '(POR EXEMPLO, mexe os dedos em frente aos olhos e fica olhando para os mesmos?)'
    },
    {
      'first': 'A seu(sua) filho(a) aponta com o dedo para pedir algo ou para conseguir ajuda?',
      'second': '(POR EXEMPLO, aponta para um biscoito ou brinquedo fora do alcance dele?)',
    },
    {
      'first': 'A seu(sua) filho(a) aponta com o dedo para mostrar algo interessante para você?',
      'second': '(POR EXEMPLO, aponta para um avião no céu ou um caminhão grande na rua)',
    },
    {
      'first': 'A seu(sua) filho(a) se interessa por outras crianças?',
      'second': '(POR EXEMPLO, seu(sua) filho(a) olha para outras crianças, sorri para elas ou se aproxima delas?)',
    },
    {
      'first': 'A seu(sua) filho(a) traz coisas para mostrar para você ou as segura para que você as veja - não para conseguir ajuda, mas apenas para compartilhar?',
      'second': '(POR EXEMPLO, para mostrar uma flor, um bichinho de pelúcia ou um caminhão de brinquedo)',
    },
    {
      'first': 'A seu(sua) filho(a) responde quando você a chama pelo nome? ',
      'second': '(POR EXEMPLO, ela olha para você, fala ou emite algum som, ou para o que está fazendo quando você a chama pelo nome?)'
    },
    {
      'first': 'Quando você sorri para a seu(sua) filho(a), ela sorri de volta para você?',
      'second': ''
    },
    {
      'first': 'A seu(sua) filho(a) fica muito incomodada com barulhos do dia a dia?',
      'second': '(POR EXEMPLO, seu(sua) filho(a) grita ou chora ao ouvir barulhos como os de liquidificador ou de música alta?)'
    },
    {
      'first': 'A seu(sua) filho(a) anda?',
      'second': ''
    },
    {
      'first': 'A seu(sua) filho(a) olha nos seus olhos quando você está falando ou brincando com ela, ou vestindo a roupa dela?',
      'second': ''
    },
    {
      'first': 'A seu(sua) filho(a) tenta imitar o que você faz?',
      'second': '(POR EXEMPLO, quando você dá tchau, ou bate palmas, ou joga um beijo, ela repete o que você faz?)'
    },
    {
      'first': 'Quando você vira a cabeça para olhar para alguma coisa, a seu(sua) filho(a) olha ao redor para ver o que você está olhando?',
      'second': ''
    },
    {
      'first': 'A seu(sua) filho(a) tenta fazer você olhar para ela?',
      'second': '(POR EXEMPLO, a seu(sua) filho(a) olha para você para ser elogiada/aplaudida, ou diz: “olha mãe!” ou “óh mãe!”)'
    },
    {
      'first': 'A seu(sua) filho(a) compreende quando você pede para ela fazer alguma coisa?',
      'second': '(POR EXEMPLO, se você não apontar, a seu(sua) filho(a) entende quando você pede: “coloca o copo na mesa” ou “liga a televisão”?)'
    },
    {
      'first': 'Quando acontece algo novo, a seu(sua) filho(a) olha para o seu rosto para ver como você se sente sobre o que aconteceu?',
      'second': '(POR EXEMPLO, se ela ouve um barulho estranho ou vê algo engraçado, ou vê um brinquedo novo, será que ela olharia para seu rosto?)'
    },
    {
      'first': 'A seu(sua) filho(a) gosta de atividades de movimento?',
      'second': '(POR EXEMPLO, ser balançado ou pular em seus joelhos)'
    },
  ];
  Map<String, dynamic> message = {};
  Map<String, dynamic> infos = {
    'viewQrcode': '',
    'result': {
      'risk': '',
      'punctuation': 0,
      'answers': ['Não', 'Sim', 'Sim', 'Sim', 'Não', 'Não', 'Sim', 'Sim', 'Sim', 'Sim', 'Não', 'Não', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sim', 'Sim', 'Não']
    }
  };
  //'answers': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Questionario", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            if(constraints.maxWidth < 730){
              return QuizPageMobile(questions: questions, infos: infos,);
            }else if(constraints.maxWidth < 1250){
              return QuizPageTablet(questions: questions, infos: infos, maxWith: constraints.maxWidth);
            }else {
              return QuizPageDesktop(questions: questions, infos: infos);
            }
          }),
      ),
    );
  }
}