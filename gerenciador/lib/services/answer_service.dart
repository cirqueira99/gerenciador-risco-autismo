import 'package:hive/hive.dart';
import '../models/answer_model.dart';


class AnswerService {
  Future<bool> create(AnswerModel answer) async{
    late Box boxAnswers;

    try{
      boxAnswers = await Hive.openBox<AnswerModel>('answers');
      await boxAnswers.add(answer);

      return true;
    }on HiveError catch (error) {
      throw Exception(error);
    } finally{
      await boxAnswers.close();
    }
  }

  Future<List<AnswerModel>> getAll(String fkChildren) async{
    late Box boxAnswers;
    List<AnswerModel> answers = [];

    try{
      boxAnswers = await Hive.openBox('answers');
      answers = boxAnswers.values.where((a) => a.fkChildren == fkChildren).toList().cast<AnswerModel>();

      answers = executeOrder(answers);

    }on HiveError catch (error) {
      throw Exception(error);
    }finally{
      await boxAnswers.close();
    }

    return answers;
  }

  List<AnswerModel> executeOrder(List<AnswerModel> answersList){
    answersList.sort((a1, a2) => a1.dateRegister.compareTo(a2.dateRegister));

    return answersList;
  }

  Future<bool> update(AnswerModel answerModel) async {
    late Box boxAnswers;
    AnswerModel answerModelUpdate = AnswerModel(
        fkChildren: answerModel.fkChildren,
        dateRegister: answerModel.dateRegister,
        risk: answerModel.risk,
        punctuation: answerModel.punctuation,
        kinship: answerModel.kinship,
        name: answerModel.name
    );

    try {
      boxAnswers = await Hive.openBox<AnswerModel>('answers');
      await boxAnswers.put(answerModel.key, answerModelUpdate);

      return true;
    } on HiveError catch (error) {
      throw Exception(error);
    }finally{
      await boxAnswers.close();
    }
  }

  Future<bool> delete(num key) async {
    late Box boxAnswers;

    try {
      boxAnswers = await Hive.openBox('answers');
      await boxAnswers.delete(key);

      return true;
    } on HiveError catch (error) {
      throw Exception(error);
    }finally{
      await boxAnswers.close();
    }
  }

  Future<bool> deleteList(List<AnswerModel> answers) async {
    late Box boxAnswers;

    try {
      boxAnswers = await Hive.openBox('answers');
      await boxAnswers.deleteAll(answers);

      return true;
    } on HiveError catch (error) {
      throw Exception(error);
    }finally{
      await boxAnswers.close();
    }
  }
}