import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ChildrenModel extends HiveObject {
  late String name;
  late String dataNasc;
  late String sex;
  late String responsible;
  late String risk;
  late double punctuation;

  ChildrenModel({
    required this.name,
    required this.dataNasc,
    required this.sex,
    required this.responsible,
    required this.risk,
    required this.punctuation,
  });

  // Método para converter um objeto Children em um mapa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dataNasc': dataNasc,
      'sex': sex,
      'responsible': responsible,
      'risk': risk,
      'punctuation': punctuation,
    };
  }

  // Map<String, dynamic> fromMap() {
  //   return {
  //     'id': id,
  //     'nome': nome,
  //     'idade': idade,
  //     'sexo': sexo,
  //     'responsavel': responsavel,
  //     'medresults': medresults,
  //   };
  // }
}
