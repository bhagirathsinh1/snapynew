import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photos_by_snappy/ApiManager/http_config.dart';
import 'package:photos_by_snappy/ApiManager/save_data.dart';
import 'package:photos_by_snappy/model/user_model.dart';
import 'package:photos_by_snappy/routes.dart';

import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/event_textbox_widget.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';
import 'package:photos_by_snappy/widget/textbox_title_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final double cardHeight = 300;
  final double cardWidth = 200;

  String _profileImage = "";
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  bool isBuyed = false;
  _toggle() {
    setState(() {
      isBuyed = !isBuyed;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // getData();
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
              _buildTitle(),
              SizedBox(
                height: 40,
              ),
              _buildProfileCircle(),
              SizedBox(
                height: 40,
              ),
              TextBoxTitle(
                text: "First Name",
              ),
              EventTextBoxWidget(
                hintText: "First Name",
                controller: _firstNameController,
                icon: null,
              ),
              SizedBox(
                height: 10,
              ),
              TextBoxTitle(
                text: "Last Name",
              ),
              EventTextBoxWidget(
                hintText: "Last Name",
                controller: _lastNameController,
              ),
              SizedBox(
                height: 10,
              ),
              TextBoxTitle(
                text: "Email",
              ),
              EventTextBoxWidget(
                //hintText: "Email",
                controller: _emailController,
                //  intialvalue: getEmail,
              ),
              SizedBox(
                height: 10,
              ),
              TextBoxTitle(
                text: "Password",
              ),
              EventTextBoxWidget(
                hintText: "Password",
                isPassword: true,
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  child: Text(
                    "Current Membership",
                    style: TextStyle(color: ThemeClass.greyColor, fontSize: 18),
                  ),
                ),
              ),
              isBuyed ? _buildsmily() : _buildsad(context),
              SizedBox(
                height: 110,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Column _buildsad(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(ThemeClass.sadEmoji)),
        ),
        SizedBox(
          height: 50,
        ),
        ButtonWidget(
            buttonTitle: "BUY HERE",
            onClick: () {
              _toggle();
            },
            color: ThemeClass.greenColor),
        SizedBox(
          height: 10,
        ),
        ButtonWidget(
            buttonTitle: "Logout",
            onClick: () {
              _logout();
            },
            color: ThemeClass.lightRedColor),
      ],
    );
  }

  Column _buildsmily() {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(ThemeClass.smilyEmoji)),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Snappyclub Membership",
                      style:
                          TextStyle(color: ThemeClass.greyColor, fontSize: 16)),
                  Text("\$3.99/M",
                      style: TextStyle(
                          color: ThemeClass.greyColor.withOpacity(0.5),
                          fontSize: 12))
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        // buttonWidget("CHANGE MEMBERSHIP", () {
        //   _toggle();
        //   // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => UserProfileTwo(),
        // ));
        //  }, context, ThemeClass.greenColor),
        SizedBox(
          height: 40,
        ),
        Container(
          child: Center(
            child: OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                  //backgroundColor: MaterialStateProperty.all(Color(0xFFE64C4C)),
                  foregroundColor: MaterialStateProperty.all(
                      Color(0xFFE64C4C).withOpacity(0.7)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  side: MaterialStateProperty.all(BorderSide(
                      color: Colors.red.withOpacity(0.7), width: 1))),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 15,
                  top: 15,
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text("Cancel Membership"))),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildProfileCircle() {
    return Container(
      child: Center(
        child: Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new CachedNetworkImageProvider(
                _profileImage == ""
                    ? "https://picsum.photos/536/354"
                    : _profileImage,
              ),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(65),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 15,
                bottom: 2,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: ThemeClass.greenColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {},
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

  Row _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        Container(
          child: Text(
            _firstNameController.text,
            style: ThemeClass.titleTextStyleGrey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.done,
          ),
        ),
      ],
    );
  }

  Container eventTextBoxExpand(String hintText) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white54,
        ),
        child: TextField(
          style: TextStyle(
            color: ThemeClass.greyColor,
            fontSize: 18,
          ),
          keyboardType: TextInputType.multiline,
          minLines: 4,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: hintText,
            prefixStyle: TextStyle(color: ThemeClass.greyColor),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ThemeClass.greyColor,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ThemeClass.greyColor,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  getData() async {
    UserModel userData = await SaveData.getUserData();

    _firstNameController = TextEditingController(text: userData.firstName);

    if (userData.profilePicture != null && userData.profilePicture != "") {
      _profileImage = HttpConfig.IMAGE_BASE_URL + userData.profilePicture;
    }

    _lastNameController = TextEditingController(text: userData.lastName);
    _emailController = TextEditingController(text: userData.email);
  }

  _logout() async {
    await SaveData.removeSharedPrefData();

    Navigator.restorablePushNamedAndRemoveUntil(
        context, Routes.logingRoute, (route) => false);
  }
}
