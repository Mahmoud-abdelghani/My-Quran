import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/tafseer_cubit.dart';
import 'package:quran/features/tafseer/presentation/cubit/get_tafseer_cubit.dart';
import 'package:quran/features/tafseer/presentation/pages/full_tafseer.dart';
import 'package:quran/features/tafseer/presentation/widgets/ayat_minu.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
    required this.ayatNum,
    required this.surahId,
    required this.bookId,
    required this.nameInEng,
    required this.location,
  });
  final int ayatNum;
  final int surahId;
  final int bookId;
  final String nameInEng;
  final String location;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  int fromValue = 1;
  int toValue = 100;

  GlobalKey fromKey = GlobalKey();
  GlobalKey toKey = GlobalKey();

  void showMyMenu(GlobalKey key, bool isFrom) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final RelativeRect position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + size.height,
      offset.dx + size.width,
      0,
    );
    showMenu(
      context: context,
      position: position,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenSize.width * 0.04),
      ),
      items:
          (isFrom
                  ? List.generate(
                      toValue <= 100 ? toValue : 100,
                      (index) => PopupMenuItem(
                        onTap: () {
                          setState(() {
                            fromValue = toValue - index;
                          });
                        },
                        child: Text("${toValue - index}"),
                      ),
                    )
                  : List.generate(
                      widget.ayatNum <= 100
                          ? widget.ayatNum - fromValue + 1
                          : (100 + fromValue <= widget.ayatNum
                                ? 101
                                : widget.ayatNum - fromValue + 1),
                      (index) => PopupMenuItem(
                        onTap: () {
                          setState(() {
                            toValue = index + fromValue;
                          });
                        },
                        child: Text("${index + fromValue}"),
                      ),
                    ))
              .toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    toValue = widget.ayatNum < 101 ? widget.ayatNum : 101;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'اختر 100 ايه',
            style: TextStyle(
              color: ColorGuid.mainColor,
              fontFamily: FontsGuid.quranFont,
              fontSize: ScreenSize.hight * 0.015,
            ),
          ),
          SizedBox(height: ScreenSize.hight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "من",
                style: TextStyle(
                  fontSize: ScreenSize.hight * 0.02,
                  fontFamily: FontsGuid.quranFont,
                ),
              ),
              Container(
                key: fromKey,
                child: AyatMinu(
                  value: fromValue,
                  onTap: () {
                    showMyMenu(fromKey, true);
                  },
                ),
              ),
              Text(
                "الى",
                style: TextStyle(
                  fontSize: ScreenSize.hight * 0.02,
                  fontFamily: FontsGuid.quranFont,
                ),
              ),
              Container(
                key: toKey,
                child: AyatMinu(
                  value: toValue,
                  onTap: () {
                    showMyMenu(toKey, false);
                  },
                ),
              ),
            ].reversed.toList(),
          ),
        ],
      ),
      title: Text('Choose a range'),
      actions: [
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<GetTafseerCubit>(context).fetchFullSurahTafseer(
              tafseerId: widget.bookId.toString(),
              surahNum: widget.surahId.toString(),
              from: fromValue,
              to: toValue,
            );
            Navigator.pushNamed(
              context,
              FullTafseer.routeName,
              arguments: {'name': widget.nameInEng, 'place': widget.location},
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: ColorGuid.mainColor),
          child: Text(
            'فَسِّرْ',
            style: TextStyle(
              fontSize: ScreenSize.hight * 0.01,
              fontFamily: FontsGuid.quranFont,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
