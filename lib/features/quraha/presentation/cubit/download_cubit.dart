import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran/features/quraha/data/models/downloaded_surah_model.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadInitial());

  bool isDownloading = false;
  Future<void> downloadMp3WithDio({
    required String url,
    required String key,
    required void Function(double progress) onProgress,
    required DownloadedSurahModel downloadedSurahModel,
  }) async {
    isDownloading = true;
    final dio = Dio();
    final audioBox = await Hive.openBox('audioBox');
    final dataBox = await Hive.openBox('dataBox');

    // ✅ استخدم documents directory
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$key.mp3';

    try {
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            onProgress(received / total);
          }
        },
        options: Options(
          receiveTimeout: const Duration(minutes: 10),
          sendTimeout: const Duration(minutes: 10),
        ),
      );

      final file = File(filePath);

      if (!await file.exists()) {
        throw Exception('File not created');
      }

      final bytes = await file.readAsBytes();

      await audioBox.put(key, bytes);
      await dataBox.add(downloadedSurahModel);
      isDownloading = false;
      onProgress(1.0);
    } catch (e, s) {
      log('Download error', error: e, stackTrace: s);
      rethrow;
    }
  }

  List<DownloadedSurahModel> downloadedSurs = [];
  getDownloadedSurahs() async {
    try {
      emit(DownloadedSursloading());
      Box dataBox = await Hive.openBox('dataBox');
      downloadedSurs = dataBox.values
          .toList()
          .cast<DownloadedSurahModel>()
          .toList();
      emit(DownloadedSursSuccess());
    } on Exception catch (e) {
      emit(DownloadedSursFailure(e.toString()));
    }
  }

  cancelDownloading() {
    isDownloading = false;
  }

  deleteSurah(String key, DownloadedSurahModel downloadedSurahModel) async {
    Box audioBox = await Hive.openBox('audioBox');
    Box dataBox = await Hive.openBox('dataBox');

    await audioBox.delete(key);
    await dataBox.deleteAt(downloadedSurs.indexOf(downloadedSurahModel));
  }
}
