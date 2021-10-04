import 'package:flutter/material.dart';
import 'package:photos_by_snappy/themeData.dart';

class TextBoxTitle extends StatelessWidget {
  const TextBoxTitle({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: Text(
        text,
        style: TextStyle(
            color: ThemeClass.greyColor.withOpacity(0.8), fontSize: 16),
      ),
    );
  }
}
