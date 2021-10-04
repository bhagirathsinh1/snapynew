import 'package:flutter/material.dart';
import 'package:photos_by_snappy/themeData.dart';

class RoundedTextBox extends StatelessWidget {
  RoundedTextBox(
      {Key? key,
      required this.hinttext,
      this.icon,
      required this.ispass,
      required this.controllers,
      this.validator})
      : super(key: key);
  final String hinttext;
  final IconData? icon;
  final bool ispass;
  final TextEditingController controllers;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: TextFormField(
        controller: controllers,
        validator: validator,
        obscureText: ispass,
        style: TextStyle(
          color: ThemeClass.greyColor,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          hintText: hinttext,
          suffix: Icon(
            icon,
            color: ThemeClass.greyColor,
          ),
          prefixStyle: TextStyle(color: ThemeClass.greyColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ThemeClass.greyColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ThemeClass.greyColor,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
