import 'package:flutter/material.dart';
import 'package:photos_by_snappy/themeData.dart';

class EventTextBoxWidget extends StatelessWidget {
  const EventTextBoxWidget({
    Key? key,
    this.hintText,
    this.isSufix = false,
    this.isPassword = false,
    this.callback,
    this.icon,
    this.validator,
    this.controller,
    this.onTap,
    this.isReadOnly = false,
  }) : super(key: key);

  final String? hintText;
  final bool? isSufix;
  final bool isReadOnly;

  final Function? callback;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white54,
      ),
      child: TextFormField(
        readOnly: isReadOnly,
        //  onTap: onTaps,
        controller: controller,
        validator: validator,
        obscureText: isPassword,
        onTap: onTap,
        style: TextStyle(
          color: ThemeClass.greyColor,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          suffixIcon: isSufix!
              ? IconButton(
                  icon: Icon(
                    icon,
                    color: ThemeClass.greenColor,
                  ),
                  onPressed: () {
                    callback!();
                  },
                )
              : null,
          focusColor: ThemeClass.greenColor,
          hintText: hintText,
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
