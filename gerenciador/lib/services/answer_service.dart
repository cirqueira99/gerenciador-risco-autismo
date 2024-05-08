import 'package:hive/hive.dart';

import '../models/answer_model.dart';

class AnswerService {
  Future<bool> create(AnswerModal answer) async{
    late Box boxAnswers;

    try{
      boxAnswers = await Hive.openBox('answers');
      await boxAnswers.add(answer);

      return true;
    }on HiveError catch (error) {
      print('Erro ao inicializar a caixa Hive: $error');

      throw Exception(error);
    } finally{
      await boxAnswers.close();
    }
  }

  Future<List<AnswerModal>> getAll(String fkChildren) async{
    late Box boxAnswers;
    List<AnswerModal> answers = [];

    try{
      boxAnswers = await Hive.openBox('answers');
      answers = boxAnswers.values.where((a) => a.fkchildren == fkChildren).toList().cast<AnswerModal>();

    }on HiveError catch (error) {
      print('Erro ao inicializar a caixa Hive: $error');
    }finally{
      await boxAnswers.close();
    }

    return answers;
  }
}