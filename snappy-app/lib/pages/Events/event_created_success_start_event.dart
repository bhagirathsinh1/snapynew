import 'package:flutter/material.dart';

import 'package:photos_by_snappy/routes.dart';
import 'package:share/share.dart';

import 'package:photos_by_snappy/themeData.dart';

class EventCreatedSuccessStartEvent extends StatefulWidget {
  EventCreatedSuccessStartEvent({Key? key}) : super(key: key);

  @override
  _EventCreatedSuccessStartEventState createState() =>
      _EventCreatedSuccessStartEventState();
}

class _EventCreatedSuccessStartEventState
    extends State<EventCreatedSuccessStartEvent> {
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
                  height: 90,
                ),
                _buildButton(context, "INVITE", shareApplication),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "OR",
                      style: TextStyle(
                          color: ThemeClass.greyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                _buildButton(context, "START NEW EVENT", cretaeNewEvents)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildButton(BuildContext context, String title, Function callback) {
    return Center(
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: "Gilroy",
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        color: ThemeClass.greenColor,
        onPressed: () {
          Navigator.pushNamed(context, Routes.eventJoinOtherEvent);
        },
      ),
    );
  }

  cretaeNewEvents() {
    return Navigator.pushNamed(context, Routes.eventJoinOtherEvent);
  }

  shareApplication() {
    return Share.share('check out my website https://example.com',
        subject: 'Look what I made!');
  }
}
