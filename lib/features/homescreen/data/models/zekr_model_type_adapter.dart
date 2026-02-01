import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran/features/homescreen/data/models/zekr_model.dart';

class ZekrModelTypeAdapter extends TypeAdapter<ZekrModel> {
  @override
  ZekrModel read(BinaryReader reader) {
    return ZekrModel(
      bless: reader.readString(),
      count: reader.readInt(),
      zekr: reader.readString(),
    );
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, ZekrModel obj) {
    writer.writeString(obj.bless);
    writer.writeInt(obj.count);
    writer.writeString(obj.zekr);
  }
}
