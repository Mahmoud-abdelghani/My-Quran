import 'package:hive/hive.dart';
import 'package:quran/features/homescreen/data/models/surah_model.dart';

class SurahModelTypeAdaptive extends TypeAdapter<SurahModel> {
  @override
  SurahModel read(BinaryReader reader) {
    return SurahModel(
      nameInAr: reader.readString(),
      nameInEn: reader.readString(),
      ayatnum: reader.readInt(),
      place: reader.readString(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, SurahModel obj) {
    writer.writeString(obj.nameInAr);
    writer.writeString(obj.nameInEn);
    writer.writeInt(obj.ayatnum);
    writer.writeString(obj.place);
  }
}
