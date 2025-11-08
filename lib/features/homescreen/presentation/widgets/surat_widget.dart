import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/quran_cubit.dart';
import 'package:quran/features/homescreen/presentation/widgets/surah_widget.dart';
import 'package:quran/features/surahdetails/presentation/cubit/full_surah_cubit.dart';
import 'package:quran/features/surahdetails/presentation/pages/surah_view.dart';

class SuratWidget extends StatelessWidget {
  const SuratWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        if (state is QuranFetchingLoading) {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        } else if (state is QuranFetchingSuccess) {
          return Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => SurahWidget(
                onTap: () {
          BlocProvider.of<FullSurahCubit>(context).getFullSurah(index+1);
          Navigator.pushNamed(context, SurahView.routeName);
        },
                num: index + 1,
                title: context.read<QuranCubit>().surs[index].nameInEn,
                ayat: context.read<QuranCubit>().surs[index].ayatnum.toString(),
                nameInArabic: context.read<QuranCubit>().surs[index].nameInAr,
                place: context.read<QuranCubit>().surs[index].place,
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: ScreenSize.hight * 0.02),
              itemCount: context.read<QuranCubit>().surs.length,
            ),
          );
        } else if (state is QuranFetchingError) {
          return Expanded(child: Text(state.message));
        } else {
          return Expanded(child: Text("error"));
        }
      },
    );
  }
}
