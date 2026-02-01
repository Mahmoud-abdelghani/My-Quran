import 'package:hive/hive.dart';
import 'package:quran/features/homescreen/data/models/tafseer_type_model.dart';

class TafseerTypeTypeAdapter extends TypeAdapter<TafseerTypeModel> {
  @override
  TafseerTypeModel read(BinaryReader reader) {
    return TafseerTypeModel(
      author: reader.readString(),
      id: reader.readString(),
      bookName: reader.readString(),
      language: reader.readString(),
      name: reader.readString(),
    );
  }

  @override
 
  int get typeId => 3;

  @override
  void write(BinaryWriter writer, TafseerTypeModel obj) {
    writer.writeString(obj.author);
    writer.writeString(obj.id);
    writer.writeString(obj.bookName);
    writer.writeString(obj.language);
    writer.writeString(obj.name);
  }
}
