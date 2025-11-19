import 'package:flutter/material.dart';
import 'package:quran/core/utils/color_guid.dart';

class AyatMinu extends StatelessWidget {
  const AyatMinu({super.key, required this.value, required this.onTap});
  final int value;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        color: Theme.of(context).primaryColorLight,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$value'),
          IconButton(
            onPressed: onTap,
            icon: Icon(Icons.keyboard_arrow_down),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
