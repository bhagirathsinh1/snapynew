import 'package:flutter/material.dart';
import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';
import 'package:photos_by_snappy/widget/round_textbox.dart';

class CreateNewPassword extends StatefulWidget {
  CreateNewPassword({Key? key}) : super(key: key);

  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage(ThemeClass.appIconBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.all(0),
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.arrow_back_ios)),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Create new password",
                  style: ThemeClass.titleTextStyleGreen,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  "Your new password must be different from previous used passwords.  ",
                  style: ThemeClass.smallSubTitleStyleGray,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                _buildTextTitle("Password"),
                RoundedTextBox(
                  hinttext: "Password",
                  icon: Icons.password,
                  ispass: true,
                  controllers: passwordController,
                ),
                SizedBox(
                  height: 27,
                ),
                _buildTextTitle("Conform Password"),
                RoundedTextBox(
                  hinttext: "Conform Password",
                  icon: Icons.password,
                  ispass: true,
                  controllers: conformpasswordController,
                ),
                SizedBox(
                  height: 33,
                ),
                ButtonWidget(
                  color: ThemeClass.greenColor,
                  buttonTitle: "Login",
                  onClick: () {
                    Navigator.pushNamed(context, Routes.startevent);
                  },
                ),
                //   buttonWidget('RESET PASSWORD', () {
                //     Navigator.pushNamed(context, Routes.startevent);
                //   }, context, ThemeClass.greenColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildTextTitle(String text) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(
        text,
        style: TextStyle(color: ThemeClass.greyColor, fontSize: 15),
      ),
    );
  }
}
