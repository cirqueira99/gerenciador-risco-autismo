import 'package:hive/hive.dart';

import '../models/answer_model.dart';

class AnswerService {
  Future<List<Answer>> getAll(String fkChildren) async{
    late Box boxAnswers;
    List<Answer> answers = [];

    try{
      boxAnswers = await Hive.openBox('answers');
      answers = boxAnswers.values.where((a) => a.fkchildren == fkChildren).toList().cast<Answer>();

    } catch (e) {
      print('Erro ao inicializar a caixa Hive: $e');
    }finally{
      await boxAnswers.close();
    }

    return answers;
  }
}