import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/data/models/tafseer_type_model.dart';
import 'package:quran/features/homescreen/presentation/cubit/quran_cubit.dart';
import 'package:quran/features/homescreen/presentation/widgets/surah_widget.dart';
import 'package:quran/features/tafseer/presentation/widgets/custom_dialog.dart';

class SurahTafseerView extends StatefulWidget {
  const SurahTafseerView({super.key});
  static const String routeName = "SurahTafseerView";

  @override
  State<SurahTafseerView> createState() => _SurahViewState();
}

class _SurahViewState extends State<SurahTafseerView> {
  @override
  Widget build(BuildContext context) {
    TafseerTypeModel tafseerTypeModel =
        ModalRoute.of(context)!.settings.arguments as TafseerTypeModel;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(
          tafseerTypeModel.bookName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: FontsGuid.quranFont,
            fontSize: ScreenSize.hight * 0.03,
          ),
        ),
      ),
      body: Expanded(
        child: ListView.separated(
          itemBuilder: (context, index) => SurahWidget(
            onTap: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) => CustomDialog(
                  location: context.read<QuranCubit>().surs[index].place,
                  nameInEng: context.read<QuranCubit>().surs[index].nameInEn,
                  bookId: int.parse(tafseerTypeModel.id),
                  surahId: index + 1,
                  ayatNum: context.read<QuranCubit>().surs[index].ayatnum,
                ),
              );
              
            },
            title: context.read<QuranCubit>().surs[index].nameInEn,
            ayat: context.read<QuranCubit>().surs[index].ayatnum.toString(),
            nameInArabic: context.read<QuranCubit>().surs[index].nameInAr,
            place: context.read<QuranCubit>().surs[index].place,
            num: index + 1,
          ),
          separatorBuilder: (context, index) =>
              SizedBox(height: ScreenSize.hight * 0.02),
          itemCount: context.read<QuranCubit>().surs.length,
        ),
      ),
    );
  }
}
