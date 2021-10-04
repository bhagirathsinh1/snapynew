import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/themeData.dart';

class AddNewEvent extends StatefulWidget {
  AddNewEvent({Key? key}) : super(key: key);

  @override
  _AddNewEventState createState() => _AddNewEventState();
}

class _AddNewEventState extends State<AddNewEvent> {
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
                      onPressed: () {},
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
                        style: ThemeClass.titleTextStyleGreen,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  child: Text(
                    "Please choose event type.",
                    style: ThemeClass.subTitleStyleGray,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                _buildGrid(),
                SizedBox(
                  height: 50,
                ),
                _buildButtonTitle(context),
                SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildButtonTitle(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Do you have a code? ",
              style: TextStyle(
                  color: ThemeClass.greyColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.eventSubscription);
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => EventSubscription(),
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

  Container _buildGrid() {
    return Container(
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(top: 60, bottom: 30),
        crossAxisCount: 4,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 2 - 1) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              transform: index.isOdd
                  ? Matrix4.translationValues(0.0, 25.0, 0.0)
                  : Matrix4.translationValues(0.0, -25.0, 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.eventSchedualed);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => EventSchedualed(),
                        // ));
                      },
                      child: Container(
                        width: cardWidth,
                        height: cardHeight,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(15),
                          dashPattern: [6, 6],
                          strokeWidth: 3,
                          color: Colors.grey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        "SCHEDULED EVENT",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => EventEmmediate(),
                // ));
                Navigator.of(context).pushNamed(Routes.eventEmmediate);
                // Navigator.of(context).pushNamed(Routes.eventSubscription);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                transform: index.isOdd
                    ? Matrix4.translationValues(0.0, 25.0, 0.0)
                    : Matrix4.translationValues(0.0, -25.0, 0.0),
                child: Stack(
                  children: [
                    Container(
                      height: cardHeight,
                      width: cardWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              "https://images.unsplash.com/photo-1488330890490-c291ecf62571?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Color.fromRGBO(41, 39, 39, 0.5),
                              BlendMode.darken),
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 20,
                        left: 14,
                        child: Text(
                          "IMMEDIATE EVENT",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
              ),
            );
          }
        },
        staggeredTileBuilder: (int index) {
          return StaggeredTile.count(2, 2.65);
        },
        mainAxisSpacing: 20,
        crossAxisSpacing: 20.0,
      ),
    );
  }
}
