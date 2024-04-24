
import 'package:gerenciador/models/child_model.dart';
import 'package:hive/hive.dart';

class ChildrenService {

  Future<List<Children>> getAll() async{
    late Box boxChildren;
    List<Children> childrensList = [];

    try{
      boxChildren = await Hive.openBox('childrens');
      childrensList = boxChildren.values.toList().cast<Children>();
    } catch (e) {
      print('Erro ao inicializar a caixa Hive: $e');
    }finally{
      await boxChildren.close();
    }

    return childrensList;
  }
}