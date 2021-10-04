import 'package:flutter/material.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';

class EventSubscription extends StatefulWidget {
  EventSubscription({Key? key}) : super(key: key);

  @override
  _EventSubscriptionState createState() => _EventSubscriptionState();
}

class _EventSubscriptionState extends State<EventSubscription> {
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
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Text(
                      "Events",
                      style: TextStyle(
                          color: ThemeClass.greenColor,
                          // fontFamily: "Gilroy",
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Text(
                  "Please choose event type.",
                  style: TextStyle(
                      fontSize: 20,
                      color: ThemeClass.greyColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text(
                        "You can't start event. you need to buy subscription first.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
             // buttonWidget("BUY HERE", () {}, context, ThemeClass.greenColor),
              SizedBox(
                height: 110,
              ),
              _buildButtonTitle(context),
            ],
          ),
        ),
      ),
    ));
  }

  Center _buildButtonTitle(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text("Do you have a code? ",
                style: TextStyle(
                    color: ThemeClass.greyColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, Routes.registerRoute);
              //   Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => AddNewEvent(),
              // ));
            },
            child: Container(
              child: Text(
                "Join Here",
                style: TextStyle(
                    color: ThemeClass.greenColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
