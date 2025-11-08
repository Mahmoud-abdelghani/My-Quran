import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/tafseer_cubit.dart';
import 'package:quran/features/surahdetails/presentation/widgets/aya_widget.dart';
import 'package:quran/features/tafseer/data/models/aya_tafseer.dart';
import 'package:quran/features/tafseer/presentation/cubit/get_tafseer_cubit.dart';

class FullTafseer extends StatefulWidget {
  const FullTafseer({super.key});
  static const String routeName = 'fullTafseer';
  @override
  State<FullTafseer> createState() => _FullTafseerState();
}

class _FullTafseerState extends State<FullTafseer> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> argu =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return BlocBuilder<GetTafseerCubit, GetTafseerState>(
      builder: (context, state) {
        if (state is GetTafseerLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is GetTafseerSuccess) {
          List<AyaTafseer> show = state.tafseerOfAyats.reversed.toList();
          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: ScreenSize.hight * 0.077,
                      left: ScreenSize.width * 0.146,
                    ),
                    child: Text(
                      argu['name']!,
                      style: TextStyle(
                        color: ColorGuid.mainColor,
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
                      argu['place']!,
                      style: TextStyle(
                        color: Colors.black,
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
                          color: ColorGuid.mainColor,
                          fontSize: ScreenSize.hight * 0.04,
                          fontFamily: FontsGuid.quranFont,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "In the name of Allah, the Most Gracious, the Most Merciful",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenSize.hight * 0.03,
                          fontFamily: FontsGuid.quranFont,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList.separated(
                  itemBuilder: (context, index) => AyaWidget(
                    tafseer: true,
                    ayaAr: show[index].aya,
                    ayaEn: show[index].text,
                    num: int.parse(show[index].ayaNum),
                  ),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: ScreenSize.hight * 0.05),
                  itemCount: state.tafseerOfAyats.length,
                ),
              ],
            ),
          );
        } else if (state is GetTafseerError) {
          return Scaffold(body: Text('error'));
        } else {
          return Scaffold(body: Text('error'));
        }
      },
    );
  }
}
