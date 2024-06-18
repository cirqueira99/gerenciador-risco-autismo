import 'package:flutter/material.dart';
import 'package:questionario/views/resultado/resultado_desktop.dart';
import 'package:questionario/views/resultado/resultado_mobile.dart';
import 'package:questionario/views/resultado/resultado_tablet.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Map<String, dynamic> infos = {};
  String text = '';

  @override
  Widget build(BuildContext context) {
    infos = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    calculateResult(infos['result']['answers']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Resultado", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          if(constraints.maxWidth < 510){
            return ResultPageMobile(infos: infos, text: text);
          }else if(constraints.maxWidth < 800){
            return ResultPageTablet(infos: infos, text: text);
          }else {
            return ResultPageDesktop(infos: infos, text: text);
          }
        }),
      ),
    );
  }

  calculateResult(List<String> answers){
    /*
    >>> ALGORITMO DA PONTUAÇÃO
    Para todos os itens, a resposta “NÃO” indica risco de TEA; exceto para os itens 2, 5 e 12, nos
    quais “SIM” indica risco de TEA. O algorítimo a seguir maximiza as propriedades psicométricas da MCHAT-R:

    -- BAIXO RISCO: Pontuação Total entre 0-2; se a criança tem menos de 24 meses, reavaliar após o
    segundo aniversário. Nenhuma outra avaliação será requerida a menos que a
    evolução clínica indique risco de TEA.

    -- RISCO MÉDIO: Pontuação Total entre 3-7; aplicar a consulta de seguimento (segunda etapa do MCHAT-R/F) para obter informações adicionais sobre as respostas de risco.
    Se o escore permanecer maior ou igual a 2, a triagem da criança foi positiva. Deve-se encaminhar a criança para avaliação diagnóstica e de intervenção precoce.
    Se o escore da consulta de seguimento for de 0-1, a triagem da criança foi negativa. Nenhuma outra avaliação será necessária, exceto se a evolução clínica indicar risco
    de TEA. A criança deve ser triada novamente em futuras visitas médicas.

    -- RISCO ELEVADO: Pontuação Total entre 8-20; não é necessário fazer a consulta de seguimento, a
    criança deve ser encaminhada imediatamente para avaliação diagnóstica e intervenção precoce.
    */

    int punctuation = 0;

    // Verifica se o tamanho da lista de respostas é 20
    if (answers.length != 20) {
      print('Erro: A lista de respostas deve conter exatamente 20 respostas.');
      return;
    }

    // Define os índices para os itens com respostas especiais
    List<int> indicesEspeciais = [1, 4, 11];

    // Percorre as respostas e calcula a pontuação
    for (int i = 0; i < answers.length; i++) {
      if (indicesEspeciais.contains(i)) {
        // Para os itens 2, 5 e 12, "SIM" indica risco de TEA
        if (answers[i] == 'sim') {
          punctuation++;
        }
      } else {
        // Para os demais itens, "NÃO" indica risco de TEA
        if (answers[i] == 'não') {
          punctuation++;
        }
      }
    }

    // Verifica a pontuação e imprime o resultado
    if (punctuation >= 0 && punctuation <= 2) {
      infos['result']['risk'] = 'Risco Baixo';
      text = 'O risco de TEA é baixo. No entanto, é importante continuar monitorando o desenvolvimento da criança e realizar avaliações periódicas com um pediatra.';
    } else if (punctuation >= 3 && punctuation <= 7) {
      infos['result']['risk'] = 'Risco Médio';
      text = 'Há um risco moderado de TEA. É recomendado agendar uma consulta com um especialista em desenvolvimento infantil ou um psicólogo para uma segunda reslização do questionário para '
             'obter informações adicionais sobre as respostas de risco.';
    } else if (punctuation >= 8 && punctuation <= 20) {
      infos['result']['risk'] = 'Risco Alto';
      text = 'O risco de TEA é alto. Recomendamos que você procure imediatamente um especialista em desenvolvimento infantil ou um neuropediatra para uma avaliação completa e para discutir possíveis intervenções.';
    } else {
      print('Erro: Pontuação fora do intervalo esperado.');
    }

    infos['result']['punctuation'] = punctuation;
  }
}