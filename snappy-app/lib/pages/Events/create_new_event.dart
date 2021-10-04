import 'package:flutter/material.dart';
import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';

class CreateNewEvent extends StatefulWidget {
  CreateNewEvent({Key? key}) : super(key: key);

  @override
  _CreateNewEventState createState() => _CreateNewEventState();
}

class _CreateNewEventState extends State<CreateNewEvent> {
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
                  height: 40,
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
                Container(
                  child: Text(
                    "Event",
                    style: ThemeClass.titleTextStyleGrey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text("Please enter details to start event.",
                      style: ThemeClass.subTitleStyleGray),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
                Text(
                    "You can't start event. you need to buy subscription first.",
                    style: ThemeClass.subTitleStyleRed),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ButtonWidget(
                  color: ThemeClass.greenColor,
                  buttonTitle: "Login",
                  onClick: () {
                    Navigator.pushNamed(context, Routes.mainRoute);
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "Do you have a code? ",
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
                            "Join Here",
                            style: TextStyle(
                                color: ThemeClass.greenColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
