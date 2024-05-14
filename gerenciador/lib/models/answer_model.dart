
import 'package:hive/hive.dart';

class AnswerModel extends HiveObject {
  @HiveField(0)
  String fkchildren;
  @HiveField(1)
  String dateregister;
  @HiveField(2)
  String risk;
  @HiveField(3)
  double punctuation;
  @HiveField(4)
  String kinship;
  @HiveField(5)
  String name;

  AnswerModel({
    required this.fkchildren,
    required this.dateregister,
    required this.risk,
    required this.punctuation,
    required this.kinship,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
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
