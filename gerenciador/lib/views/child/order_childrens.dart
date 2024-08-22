import '../../models/child_model.dart';

class OrderChildrens{

  List<ChildrenModel> executeOrder(List<ChildrenModel> listCurrent, int orderOption){

    switch(orderOption){
      case 1:
        listCurrent.sort((c1, c2) => c1.name.compareTo(c2.name));
        break;
      case 2:
        listCurrent.sort((c1, c2) => _compareRisk(c1.risk, c2.risk)); // ordena crescente
        break;
      case 3:
        listCurrent.sort((c1, c2) => _compareRisk(c2.risk, c1.risk)); // ordena decrescente
        break;
      default:
        break;
    }

    return listCurrent;
  }

  int _compareRisk(String risk1, String risk2) {
    // Definir a ordem de risco do menor para o maior
    const riskOrder = ['', 'Risco Baixo', 'Risco Médio', 'Risco Alto'];

    // Comparar as posições de risco na lista de prioridade
    int index1 = riskOrder.indexOf(risk1);
    int index2 = riskOrder.indexOf(risk2);

    return index1.compareTo(index2);
  }

}


