import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/quran_cubit.dart';

import 'package:quran/features/surahdetails/presentation/cubit/full_surah_cubit.dart';
import 'package:quran/features/surahdetails/presentation/widgets/aya_widget.dart';

class SurahView extends StatefulWidget {
  const SurahView({super.key});
  static const routeName = "surahView";

  @override
  State<SurahView> createState() => _SurahViewState();
}

class _SurahViewState extends State<SurahView> {
  @override
  Widget build(BuildContext context) {
    int surahIndex = ModalRoute.of(context)!.settings.arguments as int;
    return BlocBuilder<FullSurahCubit, FullSurahState>(
      builder: (context, state) {
        if (state is FullSurahLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is FullSurahSuccess) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: ScreenSize.hight * 0.077,
                      left: ScreenSize.width * 0.146,
                    ),
                    child: Text(
                      'سورة ${context.read<QuranCubit>().surs[surahIndex - 1].nameInAr}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: ScreenSize.hight * 0.05,
                        fontFamily: FontsGuid.quranFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: ScreenSize.width * 0.146),
                    child: Text(
                      state.fullSurahModel.translation,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: ScreenSize.hight * 0.03,
                        fontFamily: FontsGuid.quranFont,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: ScreenSize.hight * 0.07),
                      Text(
                        "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيمِ",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: ScreenSize.hight * 0.04,
                          fontFamily: FontsGuid.quranFont,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: ScreenSize.hight * 0.05),
                    ],
                  ),
                ),
                SliverList.builder(
                  itemBuilder: (context, index) => AyaWidget(
                    ayaAr: state.fullSurahModel.ayatInAr[index],
                    ayaEn: state.fullSurahModel.ayatInEn[index],
                    num: index + 1,
                    tafseer: false,
                  ),
                  itemCount: state.fullSurahModel.ayatInAr.length,
                ),
              ],
            ),
          );
        } else if (state is FullSurahconnectionError) {
          return Scaffold(body: Text(state.message));
        } else {
          return Scaffold(body: Text("error while loading"));
        }
      },
    );
  }
}
