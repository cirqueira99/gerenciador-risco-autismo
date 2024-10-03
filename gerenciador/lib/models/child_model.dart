import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ChildrenModel extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String dateNasc;
  @HiveField(2)
  late String sex;
  @HiveField(3)
  late String responsible;
  @HiveField(4)
  late String risk;
  @HiveField(5)
  late double punctuation;

  ChildrenModel({
    required this.name,
    required this.dateNasc,
    required this.sex,
    required this.responsible,
    required this.risk,
    required this.punctuation,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dataNasc': dateNasc,
      'sex': sex,
      'responsible': responsible,
      'risk': risk,
      'punctuation': punctuation,
    };
  }
}
