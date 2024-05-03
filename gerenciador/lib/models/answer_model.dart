
import 'package:hive/hive.dart';

class AnswerModal extends HiveObject {
  late String id;
  String fkchildren;
  String dateregister;
  String kinship;
  String name;
  String risk;
  double punctuation;

  AnswerModal({
    required this.id,
    required this.fkchildren,
    required this.dateregister,
    required this.kinship,
    required this.name,
    required this.risk,
    required this.punctuation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fkchildren': fkchildren,
      'dateregister': dateregister,
      'kinship': kinship,
      'name': name,
      'risk': risk,
      'punctuation': punctuation
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
