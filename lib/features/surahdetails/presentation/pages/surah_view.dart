import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/database/cache_helper.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/quran_cubit.dart';

import 'package:quran/features/surahdetails/presentation/cubit/full_surah_cubit.dart';
import 'package:quran/features/surahdetails/presentation/widgets/aya_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurahView extends StatefulWidget {
  const SurahView({super.key});
  static const routeName = "surahView";

  @override
  State<SurahView> createState() => _SurahViewState();
}

class _SurahViewState extends State<SurahView> {
  final ScrollController scrollController = ScrollController();
  late Map<String, dynamic> map;
  bool _didScroll = false;

  @override
  Widget build(BuildContext context) {
    map = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return BlocBuilder<FullSurahCubit, FullSurahState>(
      builder: (context, state) {
        if (state is FullSurahSuccess && !_didScroll) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              scrollController.jumpTo(map['offset']);
              _didScroll = true;
            }
          });
        }

        if (state is FullSurahLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is FullSurahSuccess) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('تم حفظ العلامة')));

                await CacheHelper.storeString(
                  'Alama',
                  scrollController.offset.toString(),
                );
                await CacheHelper.storeString(
                  'SurahNum',
                  map['surahId'].toString(),
                );
              },
              label: Text(
                'حفظ العلامة',
                style: TextStyle(
                  fontSize: ScreenSize.hight * 0.025,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ),
            body: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: ScreenSize.hight * 0.077,
                      left: ScreenSize.width * 0.146,
                    ),
                    child: Text(
                      'سورة ${context.read<QuranCubit>().surs[map['surahId'] - 1].nameInAr}',
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
        }

        if (state is FullSurahconnectionError) {
          return Scaffold(body: Text(state.message));
        }

        return const Scaffold(body: Text("error while loading"));
      },
    );
  }
}
