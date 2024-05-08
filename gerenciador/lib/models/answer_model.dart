
import 'package:hive/hive.dart';

class AnswerModal extends HiveObject {
  late String id;
  late String fkchildren;
  late String dateregister;
  late String risk;
  late double punctuation;
  late String kinship;
  late String name;


  AnswerModal({
    required this.id,
    required this.fkchildren,
    required this.dateregister,
    required this.risk,
    required this.punctuation,
    required this.kinship,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fkchildren': fkchildren,
      'dateregister': dateregister,
      'risk': risk,
      'punctuation': punctuation,
      'kinship': kinship,
      'name': name,
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
