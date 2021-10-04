import 'package:flutter/material.dart';

import 'package:photos_by_snappy/routes.dart';

import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';

class EventCreatedSuccess extends StatefulWidget {
  EventCreatedSuccess({Key? key}) : super(key: key);

  @override
  _EventCreatedSuccessState createState() => _EventCreatedSuccessState();
}

class _EventCreatedSuccessState extends State<EventCreatedSuccess> {
  final double cardHeight = 300;
  final double cardWidth = 200;
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
                Container(
                  child: Text(
                    "CONGRATULATIONS!",
                    style: ThemeClass.titleTextStyleGrey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "Your event is live now. please invite people to join your great event with you.",
                    style: TextStyle(
                      color: ThemeClass.greyColor.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                // buttonWidget("INVITE", () {
                //   Navigator.pushNamed(
                //       context, Routes.eventCreatedSuccessStartEvent);
                // }, context, ThemeClass.greenColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
