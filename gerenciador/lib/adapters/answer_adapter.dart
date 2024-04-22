import 'package:hive/hive.dart';

import '../models/answer_model.dart';

class AnswersAdapter extends TypeAdapter<Answer> {
  @override
  final int typeId = 1; // Identificador único para a classe

  @override
  Answer read(BinaryReader reader) {
    return Answer(
      fkchildren: reader.readInt(),
      dateregister: reader.readString(),
      kinship: reader.readString(),
      name: reader.readString(),
      risk: reader.readString(),
      punctuation: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Answer obj) {
    writer.writeInt(obj.fkchildren);
    writer.writeString(obj.dateregister);
    writer.writeString(obj.kinship);
    writer.writeString(obj.name);
    writer.writeString(obj.risk);
    writer.writeDouble(obj.punctuation);
  }
}