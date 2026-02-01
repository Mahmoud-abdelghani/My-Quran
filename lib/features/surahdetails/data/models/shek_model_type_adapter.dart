import 'package:hive/hive.dart';
import 'package:quran/features/surahdetails/data/models/shek_model.dart';

class ShekModelTypeAdapter extends TypeAdapter<ShekModel> {
  @override
  ShekModel read(BinaryReader reader) {
    return ShekModel(
      name: reader.readString(),
      originalUrl: reader.readString(),
    );
  }

  @override
  int get typeId => 5;

  @override
  void write(BinaryWriter writer, ShekModel obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.originalUrl);
  }
}