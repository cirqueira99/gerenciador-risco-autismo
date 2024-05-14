
import 'package:gerenciador/models/child_model.dart';
import 'package:hive/hive.dart';

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
}