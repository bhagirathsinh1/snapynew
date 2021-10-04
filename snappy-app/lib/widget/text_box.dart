import 'package:flutter/material.dart';
import 'package:photos_by_snappy/themeData.dart';

class TextBoxRounded extends StatelessWidget {
  const TextBoxRounded(
      {Key? key,
      required this.hinttext,
      this.icon,
      this.ispass = false,
      required this.controllers,
      this.validator, this.errorText, this.inputType})
      : super(key: key);
  final String hinttext;
  final IconData? icon;
  final String? errorText;
  final TextInputType? inputType ;
  final bool ispass;
  final TextEditingController controllers;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: TextFormField(
      keyboardType: inputType,
        controller: controllers,
        validator: validator,
        obscureText: ispass,
        
        style: TextStyle(
          color: ThemeClass.greyColor,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          hintText: hinttext,
          prefixIcon: Icon(
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
