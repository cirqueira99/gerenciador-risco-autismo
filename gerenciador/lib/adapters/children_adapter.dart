import 'package:hive/hive.dart';

import '../models/child_model.dart';

class ChildrenAdapter extends TypeAdapter<ChildrenModel> {
  @override
  final int typeId = 0; // Identificador único para a classe

  @override
  ChildrenModel read(BinaryReader reader) {
    return ChildrenModel(
      name: reader.readString(),
      dataNasc: reader.readString(),
      sex: reader.readString(),
      responsible: reader.readString(),
      risk: reader.readString(),
      punctuation: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, ChildrenModel obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.dataNasc);
    writer.writeString(obj.sex);
    writer.writeString(obj.responsible);
    writer.writeString(obj.risk);
    writer.writeDouble(obj.punctuation);
  }
}