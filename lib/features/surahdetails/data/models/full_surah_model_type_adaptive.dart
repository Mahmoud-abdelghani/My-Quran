import 'package:hive/hive.dart';
import 'package:quran/features/surahdetails/data/models/full_surah_model.dart';
import 'package:quran/features/surahdetails/data/models/shek_model.dart';

class FullSurahModelTypeAdaptive extends TypeAdapter<FullSurahModel>{
  @override
  FullSurahModel read(BinaryReader reader) {
    return FullSurahModel(
      translation: reader.readString(),
      mashaih: reader.readList().cast<ShekModel>(),
      name: reader.readString(),
      ayatInAr: reader.readList(),
      ayatInEn: reader.readList(),
    );
  }

  @override
 
  int get typeId => 4;

  @override
  void write(BinaryWriter writer, FullSurahModel obj) {
    writer.writeString(obj.translation);
    writer.writeList(obj.mashaih);
    writer.writeString(obj.name);
    writer.writeList(obj.ayatInAr);
    writer.writeList(obj.ayatInEn);
  }

}