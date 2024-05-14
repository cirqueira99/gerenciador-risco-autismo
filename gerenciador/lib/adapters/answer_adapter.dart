import 'package:hive/hive.dart';

import '../models/answer_model.dart';

class AnswersAdapter extends TypeAdapter<AnswerModel> {
  @override
  final int typeId = 1; // Identificador único para a classe

  @override
  AnswerModel read(BinaryReader reader) {
    return AnswerModel(
      fkchildren: reader.readString(),
      dateregister: reader.readString(),
      kinship: reader.readString(),
      name: reader.readString(),
      risk: reader.readString(),
      punctuation: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, AnswerModel obj) {
    writer.writeString(obj.fkchildren);
    writer.writeString(obj.dateregister);
    writer.writeString(obj.kinship);
    writer.writeString(obj.name);
    writer.writeString(obj.risk);
    writer.writeDouble(obj.punctuation);
  }
}