import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/quran_cubit.dart';
import 'package:quran/features/homescreen/presentation/widgets/surah_widget.dart';
import 'package:quran/features/surahdetails/presentation/cubit/full_surah_cubit.dart';
import 'package:quran/features/surahdetails/presentation/pages/surah_view.dart';

class SuratWidget extends StatefulWidget {
  const SuratWidget({super.key});

  @override
  State<SuratWidget> createState() => _SuratWidgetState();
}

class _SuratWidgetState extends State<SuratWidget> {
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
                  BlocProvider.of<FullSurahCubit>(
                    context,
                  ).getFullSurah(index + 1);
                  Navigator.pushNamed(
                    context,
                    SurahView.routeName,
                    arguments: {'surahId': index + 1, 'offset': 0.0},
                  );
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
          return Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(state.message),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<QuranCubit>(context).fetchQuran();
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Expanded(child: Text("error"));
        }
      },
    );
  }
}
