
import 'package:gerenciador/models/child_model.dart';
import 'package:hive/hive.dart';

class ChildrenService {

  Future<List<ChildrenModal>> getAll() async{
    late Box boxChildren;
    List<ChildrenModal> childrensList = [];

    try{
      boxChildren = await Hive.openBox('childrens');
      childrensList = boxChildren.values.toList().cast<ChildrenModal>();
    } catch (e) {
      print('Erro ao inicializar a caixa Hive: $e');
    }finally{
      await boxChildren.close();
    }

    return childrensList;
  }
}