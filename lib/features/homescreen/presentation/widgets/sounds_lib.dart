import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/features/homescreen/presentation/widgets/sounds_custom_container.dart';
import 'package:quran/features/quraha/presentation/cubit/download_cubit.dart';
import 'package:quran/features/quraha/presentation/pages/downloaded_surs_screen.dart';
import 'package:quran/features/quraha/presentation/pages/surs_selsection_screen.dart';

class SoundsLib extends StatelessWidget {
  const SoundsLib({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SoundsCustomContainer(
            onTap: () {
              Navigator.pushNamed(context, SursSelsectionScreen.routeName);
            },
            path: 'assets/images/radio.png',
            txt: 'الِاسْتِمَاعُ الْمُبَاشِرُ',
          ),
          SoundsCustomContainer(
            onTap: () async {
              await BlocProvider.of<DownloadCubit>(
                context,
              ).getDownloadedSurahs();
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, DownloadedSursScreen.routeName);
            },
            path: 'assets/images/reading.png',
            txt: 'اَلتَّنْزِيلَاتُ الْمُسَجَّلَةُ',
          ),
        ],
      ),
    );
  }
}
