import 'package:flutter/material.dart';
import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';

class StartEvent extends StatefulWidget {
  StartEvent({Key? key}) : super(key: key);

  @override
  _StartEventState createState() => _StartEventState();
}

class _StartEventState extends State<StartEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage(ThemeClass.appIconBackground),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Welcome Mark.",
                        style: ThemeClass.titleTextStyleGreen,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.search))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
                BuildCenter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildCenter extends StatelessWidget {
  const BuildCenter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("You don't have any past events. Please start a new event.",
            style: ThemeClass.subTitleStyleRed),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        // buttonWidget('start event ', () {
        //   Navigator.pushNamed(context, Routes.mainRoute);
        // }, context, ThemeClass.greenColor),
      ],
    );
  }
}
