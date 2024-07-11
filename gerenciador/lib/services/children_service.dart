
import 'package:gerenciador/models/child_model.dart';
import 'package:hive/hive.dart';

import '../models/answer_model.dart';
import 'answer_service.dart';

class ChildrenService {

  Future<List<ChildrenModel>> getAll() async{
    late Box boxChildren;
    List<ChildrenModel> childrensList = [];

    try{
      boxChildren = await Hive.openBox('childrens');
      childrensList = boxChildren.values.toList().cast<ChildrenModel>();
    } catch (e) {
      print('Erro ao inicializar a caixa Hive: $e');
    }finally{
      await boxChildren.close();
    }

    return childrensList;
  }

  Future<bool> update(ChildrenModel childrenModel) async {
    late Box boxChildren;
    ChildrenModel childrenModelUpdate = ChildrenModel(
        name: childrenModel.name,
        dataNasc: childrenModel.dataNasc,
        sex: childrenModel.sex,
        responsible: childrenModel.responsible,
        risk: childrenModel.risk,
        punctuation: childrenModel.punctuation
    );

    try {
      boxChildren = await Hive.openBox<ChildrenModel>('childrens');
      await boxChildren.put(childrenModel.key, childrenModelUpdate);

      return true;
    } on HiveError catch (error) {
      print('>>> Erro Hive: $error');

      throw Exception(error);
    }finally{
      await boxChildren.close();
    }
  }

  Future<bool> updatePunctuationChildren(ChildrenModel children) async{
    double soma = 0.0;
    AnswerService answerService = AnswerService();

    try{
      List<AnswerModel> list = await answerService.getAll(children.key.toString());

      if(list.isEmpty){
        children.risk = '';

      }else {
        for (AnswerModel answer in list) {
          soma += answer.punctuation;
        }

        children.punctuation = soma / list.length;

        // Verifica a pontuação e imprime o resultado
        if (children.punctuation >= 0 && children.punctuation < 3) {
          children.risk = 'Risco Baixo';
        } else if (children.punctuation >= 3 && children.punctuation < 8) {
          children.risk = 'Risco Médio';
        } else if (children.punctuation >= 8 && children.punctuation <= 20) {
          children.risk = 'Risco Alto';
        }
      }

      bool? response = await update(children);

      return true;
    }catch(error){
      throw Exception(error);
    }
  }
}