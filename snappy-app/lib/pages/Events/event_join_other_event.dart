import 'package:flutter/material.dart';
import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/event_textbox_widget.dart';

class EventJoinOtherEvent extends StatefulWidget {
  EventJoinOtherEvent({Key? key}) : super(key: key);

  @override
  _EventJoinOtherEventState createState() => _EventJoinOtherEventState();
}

class _EventJoinOtherEventState extends State<EventJoinOtherEvent> {
  TextEditingController _controller = TextEditingController();
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
                    "JOIN OTHER EVENT.",
                    style: ThemeClass.titleTextStyleGrey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "Please enter link or code to join event.",
                    style: TextStyle(
                      color: ThemeClass.greyColor.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: EventTextBoxWidget(
                      hintText: "654654 654654 ",
                      isSufix: false,
                      controller: _controller),
                ),
                SizedBox(
                  height: 40,
                ),
                _buildButton(context, "JOIN EVENT"),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildButton(BuildContext context, String title) {
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
           Navigator.pushNamed(context, Routes.userList);
        },
      ),
    );
  }
}
