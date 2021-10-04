import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';

class UserList extends StatefulWidget {
  UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<Map<String, String>> user = [
    {
      'image':
          'https://images.unsplash.com/photo-1628336664432-83e2c3b7b176?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyN3x8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'name': 'Mark Cuban',
      'type': 'Owner',
      'email': 'Sammy.g12@gmail.com'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1628499636655-d6f051bbfeae?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1M3x8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'name': 'Sammy George',
      'type': 'Editor',
      'email': 'Sammy George'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1628336664432-83e2c3b7b176?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyN3x8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'name': 'Mark Cuban',
      'type': 'Owner',
      'email': 'Sammy.g12@gmail.com'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1628499636655-d6f051bbfeae?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1M3x8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'name': 'Sammy George',
      'type': 'Editor',
      'email': 'Sammy George'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1628336664432-83e2c3b7b176?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyN3x8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'name': 'Mark Cuban',
      'type': 'Owner',
      'email': 'Sammy.g12@gmail.com'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1628499636655-d6f051bbfeae?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1M3x8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'name': 'Sammy George',
      'type': 'Editor',
      'email': 'Sammy George'
    }
  ];
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
                _buildTitle(context),
                SizedBox(
                  height: 35,
                ),
                _buildSubtitle(context),
                SizedBox(
                  height: 20,
                ),
                _buildUserList(),
                SizedBox(
                  height: 25,
                ),
                _buildCodeSetting(context),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Anyone with the code.",
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: ThemeClass.greyColor),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Anyone on the internet with link can view.",
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 16,
                      color: ThemeClass.greyColor.withOpacity(0.6)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Change",
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: TextStyle(fontSize: 16, color: ThemeClass.greyColor),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.5,
                    color: Colors.white,
                    child: Icon(
                      Icons.qr_code_2,
                      size: MediaQuery.of(context).size.height * 0.20,
                      color: ThemeClass.greyColor.withOpacity(0.5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                // buttonWidget("SAVE", () {
                //   _modalBottomSheetMenu();
                // }, context, ThemeClass.greyColor.withOpacity(0.2)),
                SizedBox(
                  height: 130,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        useRootNavigator: true,
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xffF2F7FC),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            _buildBottomSheetLinkSettings();
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "  Restricted",
                              //textAlign: TextAlign.left,
                              style: TextStyle(color: Color(0xff2F4858)),
                            ),
                          ),
                        ),
                        Text(
                          "  Only people added can open.",
                          style: TextStyle(fontSize: 11.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xffF2F7FC),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        _buildBottomSheetLinkSettings();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "  Mark Cuban",
                          //textAlign: TextAlign.left,
                          style: TextStyle(color: Color(0xff2F4858)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xff1DD05D),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        _buildBottomSheetLinkSettings();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "  Anyone with code",
                          //textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _buildBottomSheetLinkSettings() {
    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xff1DD05D),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "  Viewer",
                          //textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xffF2F7FC),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "  Editor",
                          //textAlign: TextAlign.left,
                          style: TextStyle(color: Color(0xff2F4858)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Container _buildUserList() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: user.length,
        itemBuilder: (context, index) {
          return _buildlistTile(user[index]['name'], user[index]['email'],
              user[index]['type'], user[index]['image']);
        },
      ),
    );
  }

  Padding _buildlistTile(
      String? name, String? email, String? type, String? image) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(image.toString()),
            radius: 40,
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$name",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ThemeClass.greyColor),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "$email",
                style: TextStyle(
                    fontSize: 14, color: ThemeClass.greyColor.withOpacity(0.5)),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "$type",
                style: TextStyle(fontSize: 14, color: ThemeClass.greyColor),
              ),
            ],
          )
        ],
      ),
    );
  }

  Row _buildSubtitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Expanded(
            child: Text(
              "Who has access",
              overflow: TextOverflow.clip,
              softWrap: false,
              style: ThemeClass.titleTextStyleGrey,
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.person_add_alt_1,
              color: ThemeClass.greyColor,
            )),
      ],
    );
  }

  Row _buildCodeSetting(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Expanded(
            child: Text("Code settings",
                overflow: TextOverflow.clip,
                softWrap: false,
                style: TextStyle(
                  color: ThemeClass.greenColor,
                  // fontFamily: "Gilroy",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.share_rounded,
              color: ThemeClass.greyColor,
            )),
      ],
    );
  }

  Row _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          constraints: BoxConstraints(),
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        SizedBox(width: 15),
        Container(
          child: Expanded(
            child: Text(
              "Manage people and link.",
              overflow: TextOverflow.clip,
              softWrap: false,
              style: ThemeClass.titleTextStyleGreen,
            ),
          ),
        ),
      ],
    );
  }
}
