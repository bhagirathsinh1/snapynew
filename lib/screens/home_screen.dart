import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:photos_by_snappy/ApiManager/http_config.dart';
import 'package:photos_by_snappy/ApiManager/save_data.dart';
import 'package:photos_by_snappy/model/event_model.dart';
import 'package:photos_by_snappy/pages/Home/event_details.dart';

import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/services/common_method.dart';
import 'package:photos_by_snappy/services/image_url.dart';
import 'package:photos_by_snappy/themeData.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        // child: Text("asd"),
        child: FutureBuilder(
          future: getAllEvent(),
          builder: (context, AsyncSnapshot<EventModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!.email != null) {
                  if (snapshot.data!.participant!.length > 0) {
                    return _buildView(snapshot.data);
                  } else {
                    return _errorInternalWidget("No event found");
                  }
                } else {
                  return _errorInternalWidget(
                      "Something went wrong please try again.");
                }
                // return _buildView();
              }
              if (snapshot.hasError) {
                return _errorInternalWidget(snapshot.error.toString());
              } else {
                return _errorInternalWidget("Something went wrong");
              }
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ThemeClass.greenColor,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _errorInternalWidget(String e) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(child: Text(e)),
    );
  }

  SingleChildScrollView _buildView(EventModel? event) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Welcome ${event!.firstName}.",
                    style: ThemeClass.titleTextStyleGreen,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // getAllEvent();
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            _buildGrid(event.participant),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Container _buildGrid(List<Participant>? participant) {
    return Container(
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(top: 60, bottom: 30),
        crossAxisCount: 4,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: participant!.length,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        itemBuilder: (BuildContext context, int index) {
          return _buildingEventList(participant, index);
        },
        staggeredTileBuilder: (int index) {
          return StaggeredTile.count(2, 2.65);
        },
      ),
    );
  }

  _buildingEventList(List<Participant> participant, int index) {
    if (participant[index].event!.status == 2) {
      return _buildSchedualEvent(participant[index], context, index);
    } else {
      return _buildEventCard(participant[index], index);
    }
  }

  InkWell _buildSchedualEvent(
      Participant participant, BuildContext context, int index) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, Routes.eventDetails);
      },
      child: Container(
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
              Container(
                padding: EdgeInsets.all(2),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(15),
                  dashPattern: [6, 6],
                  strokeWidth: 2,
                  color: Colors.grey,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Icon(
                            Icons.alarm,
                            size: 40,
                            color: Colors.grey,
                          )),
                          SizedBox(
                            height: 50,
                          ),
                          Wrap(
                            children: [
                              Text(
                                "SCHEDUL EVENT",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Event Start on",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                getFormattedDate(
                                    participant.event!.startDate.toString()),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _buildEventCard(Participant participant, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                EventDetails(eventId: participant.event!.id.toString()),
          ),
        );
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      (participant.event!.images == null ||
                              participant.event!.images!.isEmpty)
                          ? ImageUrls.getImageUrl()
                          : HttpConfig.IMAGE_BASE_URL +
                              participant.event!.images![0].path.toString()),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Color.fromRGBO(41, 39, 39, 0.5), BlendMode.darken),
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  participant.event!.eventTitle.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    );
  }

  InkWell _buildEventCardWithEmptyImage(Participant participant, int index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.eventDetails);
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => EventSubscription(),
        // ));
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(ImageUrls.getImageUrl()),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Color.fromRGBO(41, 39, 39, 0.5), BlendMode.darken),
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  participant.event!.eventTitle.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    );
  }

  Future<EventModel> getAllEvent() async {
    try {
      var user = await SaveData.getUserData();
      var response = await HttpConfig.httpGet("users/event/${user.id}");

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        EventModel event = EventModel.fromJson(body);
        return event;
      } else {
        // return EventModel();
        throw "internal server error";
      }
    } catch (e) {
      if (e is SocketException) {
        debugPrint("socket exception screen :------ $e");

        throw "Socket exception";
      } else if (e is TimeoutException) {
        debugPrint("time out exp :------ $e");

        throw "Time out exception";
      } else {
        debugPrint("home screen :------ $e");

        throw e.toString();
      }
    }
  }
}
