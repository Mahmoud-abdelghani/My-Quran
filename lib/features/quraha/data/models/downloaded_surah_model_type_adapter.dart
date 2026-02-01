import 'package:hive/hive.dart';
import 'package:quran/features/quraha/data/models/downloaded_surah_model.dart';

class DownloadedSurahModelTypeAdapter
    extends TypeAdapter<DownloadedSurahModel> {
      @override
      DownloadedSurahModel read(BinaryReader reader) {
   return DownloadedSurahModel(
     surahName: reader.readString(),  
     translation: reader.readString(),  
     hiveKey: reader.readString(),  
     shekName: reader.readString(),
    );
      }
    
      @override
     
      int get typeId => 6;
    
      @override
      void write(BinaryWriter writer, DownloadedSurahModel obj) {
    writer.writeString(obj.surahName);
    writer.writeString(obj.translation);
    writer.writeString(obj.hiveKey);
    writer.writeString(obj.shekName);
      }}
