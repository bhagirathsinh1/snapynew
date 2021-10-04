import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photos_by_snappy/ApiManager/http_config.dart';
import 'package:photos_by_snappy/ApiManager/save_data.dart';
import 'package:photos_by_snappy/model/event_model.dart';
import 'package:photos_by_snappy/pages/camera/camera_from_evet_details.dart';
import 'package:photos_by_snappy/pages/camera/normal_camera.dart';

import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/services/image_url.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/Photo_grid_widget.dart';
import 'package:photos_by_snappy/widget/bottom_sheet_widget.dart';
import 'package:photos_by_snappy/widget/event_textbox_widget.dart';

import 'package:photos_by_snappy/widget/grid_data.dart';

class EventDetails extends StatefulWidget {
  EventDetails({Key? key, this.eventId}) : super(key: key);
  final String? eventId;

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  List<bool> isSelectedList = [];
  bool isLongPress = false;
  final double cardHeight = 270;
  final double cardWidth = 200;
  double i = 0;
  final ImagePicker _picker = ImagePicker();
  File? image;
  String eventID = "";

  @override
  void initState() {
    // print(widget.eventId.toString());
    eventID = widget.eventId.toString();

    super.initState();
    // getAllEvent();
  }

  Future<Event> getAllEvent() async {
    try {
      var user = await SaveData.getUserData();
      var response = await HttpConfig.httpGet("events/$eventID");

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        Event event = Event.fromJson(body);

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

  _pickImage(ImageSource source) async {
    var pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        print("object event details close back press");
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage(ThemeClass.appIconBackground),
              fit: BoxFit.fill,
            ),
          ),
          child: FutureBuilder(
              future: getAllEvent(),
              builder: (context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    // isSelectedList
                    return _buildView(context, snapshot.data);

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
              }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
          child: FloatingActionButton(
            // isExtended: true,
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () {
              buildBottomSheet(
                  context: context,
                  firsttitle: "Camera",
                  secondTitle: "gallery",
                  firstCallBack: () async {
                    // _pickImage(ImageSource.camera);
                    var cameras = await availableCameras();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           NormalCameraScreen(camera: cameras)),
                    // );

                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => CameraFromEventDetails(
                              camera: cameras,
                              eventId: widget.eventId.toString())),
                    );
                  },
                  secondCallBack: () {
                    _pickImage(ImageSource.gallery);
                  });
            },
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _buildView(BuildContext context, Event? event) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            _buildTitle(context, event!.eventTitle.toString()),
            SizedBox(
              height: 30,
            ),
            _buildSubtitle(),
            SizedBox(
              height: 20,
            ),
            _buildLikedImage(context, event.participant),
            Text(
              "Description",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: ThemeClass.greyColor),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              event.description.toString(),
              style: ThemeClass.smallSubTitleStyleGray.copyWith(
                  fontSize: 18, color: ThemeClass.greyColor.withOpacity(0.6)),
            ),
            SizedBox(
              height: 15,
            ),
            _buildTitleWidthIcons(),
            SizedBox(
              height: 15,
            ),
            Text(
              "Long press on a photo to add edit photos. Or just press the delete icon.",
              style: ThemeClass.smallSubTitleStyleGray.copyWith(
                  fontSize: 14, color: ThemeClass.greyColor.withOpacity(0.6)),
            ),
            SizedBox(
              height: 10.0,
            ),
            PhotoGridWidget(
              images: event.images,
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 80.0,
            ),
          ],
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

  Row _buildTitleWidthIcons() {
    return Row(
      children: [
        Container(
            child: Expanded(
                child: Text(
          "Photos",
          overflow: TextOverflow.clip,
          softWrap: false,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: ThemeClass.greyColor),
        ))),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.only(left: 5, right: 5),
                  onPressed: () {},
                  icon: Icon(Icons.download)),
              IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.only(left: 5, right: 5),
                  onPressed: () {},
                  icon: Icon(Icons.share)),
              IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.only(left: 5, right: 5),
                  onPressed: () {},
                  icon: Icon(Icons.delete)),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildLikedImage(
      BuildContext context, List<Participant>? participent) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      child: Stack(
        children: [
          for (var i = 0; i < participent!.length; i++)
            Positioned(
              left: i * 45.0,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(
                    (participent[i].user!.profilePicture == null ||
                            participent[i].user!.profilePicture == "")
                        ? ImageUrls.getImageUrl()
                        : HttpConfig.IMAGE_BASE_URL +
                            participent[i].user!.profilePicture.toString()),
                //backgroundColor: Colors.yellow,
              ),
            )
        ],
      ),
    );
  }

  Container _buildSubtitle() {
    return Container(
      child: Text(
        "People who are linked.",
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: ThemeClass.greyColor),
      ),
    );
  }

  Row _buildTitle(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          width: 15,
        ),
        Container(
          child: Expanded(
            child: Text(
              title,
              overflow: TextOverflow.clip,
              softWrap: false,
              style: ThemeClass.titleTextStyleGreen,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.only(left: 5, right: 5),
                onPressed: () {
                  _showAlertDialog(context);
                },
                constraints: BoxConstraints(),
                icon: Icon(Icons.share),
              ),
              IconButton(
                padding: EdgeInsets.only(left: 5, right: 5),
                onPressed: () {},
                constraints: BoxConstraints(),
                icon: Icon(Icons.edit),
              ),
              IconButton(
                padding: EdgeInsets.only(left: 5, right: 5),
                onPressed: () {},
                constraints: BoxConstraints(),
                icon: Icon(Icons.qr_code),
              ),
            ],
          ),
        )
      ],
    );
  }

  _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Want to save your changes?",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff2F4858),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                            minWidth: 110,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            color: ThemeClass.greyColor.withOpacity(0.5),
                            textColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("CANCEL"),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                            minWidth: 110,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            color: ThemeClass.greenColor,
                            textColor: Colors.white,
                            // height: MediaQuery.of(context).size.height * 0.09,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("SAVE"),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //  contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 15.0, 2.0),
          );
        });
  }
}
