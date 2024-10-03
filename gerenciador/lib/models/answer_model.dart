
import 'package:hive/hive.dart';

class AnswerModel extends HiveObject {
  @HiveField(0)
  String fkChildren;
  @HiveField(1)
  String dateRegister;
  @HiveField(2)
  String risk;
  @HiveField(3)
  double punctuation;
  @HiveField(4)
  String kinship;
  @HiveField(5)
  String name;

  AnswerModel({
    required this.fkChildren,
    required this.dateRegister,
    required this.risk,
    required this.punctuation,
    required this.kinship,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'fkchildren': fkChildren,
      'dateregister': dateRegister,
      'risk': risk,
      'punctuation': punctuation,
      'kinship': kinship,
      'name': name,
    };
  }
}
