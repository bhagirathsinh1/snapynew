import 'package:flutter/material.dart';
import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';

class EmailVerification extends StatefulWidget {
  EmailVerification({Key? key}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
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
                  "Check your email.",
                  style: ThemeClass.titleTextStyleGreen,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  "We have sent a password recover instructions to your mail.",
                  style: ThemeClass.smallSubTitleStyleGray,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                // buttonWidget('OPEN MAIL', () {
                //   Navigator.pushNamed(context, Routes.startevent);
                // }, context, ThemeClass.greenColor),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Didn't get code? ",
                        style: TextStyle(
                            color: ThemeClass.greyColor, fontSize: 18),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.registerRoute);
                      },
                      child: Container(
                        child: Text(
                          "Resend",
                          style: TextStyle(
                              color: ThemeClass.greenColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
