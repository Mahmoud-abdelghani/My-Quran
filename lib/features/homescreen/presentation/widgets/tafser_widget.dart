import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/tafseer_cubit.dart';
import 'package:quran/features/homescreen/presentation/widgets/tafseer_type_widget.dart';
import 'package:quran/features/tafseer/presentation/pages/surah_tafseer_view.dart';

class TafserWidget extends StatelessWidget {
  const TafserWidget({super.key, required this.context2});
 final BuildContext context2;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TafseerCubit, TafseerState>(
      builder: (context, state) {
        if (state is TafseerTypesLoading) {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        } else if (state is TafseerTypesSuccess) {
          return Expanded(
            child: ListView.separated(
              itemCount: state.tafseerBooks.length,
              itemBuilder: (context, index) => TafseerTypeWidget(
                onTap: () {
                  Navigator.pushNamed(
                    context2,
                    SurahTafseerView.routeName,
                    arguments: state.tafseerBooks[index],
                  );
                },
                num: state.tafseerBooks[index].id,
                languge: state.tafseerBooks[index].language,
                name: state.tafseerBooks[index].name,
                bookName: state.tafseerBooks[index].bookName,
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: ScreenSize.hight * 0.02),
            ),
          );
        } else if (state is TafseerTypesError) {
          return Expanded(child: Center(child: Text(state.message)));
        } else {
          return Expanded(child: Center(child: Text('error in fetching data')));
        }
      },
    );
  }
}
