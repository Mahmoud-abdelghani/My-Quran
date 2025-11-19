import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/tasspeh_cubit.dart';

class SephaWidget extends StatefulWidget {
  const SephaWidget({super.key});

  @override
  State<SephaWidget> createState() => _SephaWidgetState();
}

class _SephaWidgetState extends State<SephaWidget> {
  Widget buildBeads(int index) {
    Color beadColor = index < context.read<TasspehCubit>().counter
        ? Theme.of(context).primaryColor
        : Theme.of(context).splashColor;
    double angle = (index * (360 / 33)) * (pi / 180);
    double x = ScreenSize.hight * 0.12 * cos(angle);
    double y = ScreenSize.hight * 0.12 * sin(angle);
    return Positioned(
      left: ScreenSize.width * 0.485 + x - 7,
      top: ScreenSize.hight * 0.5 * 0.4 + y - 7,
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(color: beadColor, shape: BoxShape.circle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasspehCubit, TasspehState>(
      builder: (context, state) {
        List<Widget> beads = List.generate(33, (index) => buildBeads(index));
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: ScreenSize.width,
                height: ScreenSize.hight * 0.35,
                child: Center(child: Stack(children: beads)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  BlocProvider.of<TasspehCubit>(context).upCount();
                },
                child: state is TasspehCounterUp
                    ? Text(
                        state.txt,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: ScreenSize.hight * 0.025,
                          fontFamily: FontsGuid.quranFont,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        'اِبْدَأْ',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: ScreenSize.hight * 0.025,
                          fontFamily: FontsGuid.quranFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              Spacer(flex: 2),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TasspehCubit>(context).repeat();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorLight,
                ),
                child: Text(
                  'إِعَادَةٌ',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Spacer(flex: 2),
            ],
          ),
        );
      },
    );
  }
}
