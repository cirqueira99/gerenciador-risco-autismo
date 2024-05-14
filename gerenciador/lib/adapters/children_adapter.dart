import 'package:hive/hive.dart';

import '../models/child_model.dart';

class ChildrenAdapter extends TypeAdapter<ChildrenModel> {
  @override
  final int typeId = 0; // Identificador único para a classe

  @override
  ChildrenModel read(BinaryReader reader) {
    return ChildrenModel(
      id: reader.readString(),
      name: reader.readString(),
      age: reader.readInt(),
      sex: reader.readString(),
      responsible: reader.readString(),
      risk: reader.readString(),
      punctuation: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, ChildrenModel obj) {
    writer.writeString(obj.id ?? '');
    writer.writeString(obj.name);
    writer.writeInt(obj.age);
    writer.writeString(obj.sex);
    writer.writeString(obj.responsible);
    writer.writeString(obj.risk);
    writer.writeDouble(obj.punctuation);
  }
}