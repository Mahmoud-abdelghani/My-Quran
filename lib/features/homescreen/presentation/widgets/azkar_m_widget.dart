import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/zekr_cubit.dart';
import 'package:quran/features/homescreen/presentation/widgets/azkar_widget.dart';

class AzkarMWidget extends StatelessWidget {
  const AzkarMWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZekrCubit, ZekrState>(
      builder: (context, state) {
        if (state is ZekrLoading) {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        } else if (state is ZekrSuccess) {
          return Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => AzkarWidget(
                zekr: context.read<ZekrCubit>().azkarmassa!.azkar[index].zekr,
                num: (context.read<ZekrCubit>().azkarmassa!.azkar[index].count),
                title: context.read<ZekrCubit>().azkarmassa!.type,
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: ScreenSize.hight * 0.02),
              itemCount: context.read<ZekrCubit>().azkarmassa!.azkar.length,
            ),
          );
        } else if (state is ZekrError) {
          return Expanded(child: Text(state.message));
        } else {
          return Expanded(child: Text("error"));
        }
      },
    );
  }
}
