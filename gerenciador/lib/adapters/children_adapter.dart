import 'package:hive/hive.dart';

import '../models/child_model.dart';

class ChildrenAdapter extends TypeAdapter<ChildrenModal> {
  @override
  final int typeId = 0; // Identificador único para a classe

  @override
  ChildrenModal read(BinaryReader reader) {
    return ChildrenModal(
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
  void write(BinaryWriter writer, ChildrenModal obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeInt(obj.age);
    writer.writeString(obj.sex);
    writer.writeString(obj.responsible);
    writer.writeString(obj.risk);
    writer.writeDouble(obj.punctuation);
  }
}