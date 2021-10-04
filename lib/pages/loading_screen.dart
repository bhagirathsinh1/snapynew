import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photos_by_snappy/ApiManager/save_data.dart';
import 'package:photos_by_snappy/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pass/routes.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // startTime();
    super.initState();
    _checkUserExist();
  }

  void _checkUserExist() async {
    try {
      var user = await SaveData.getUserData();
      if (user.accessToken != null) {
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        Navigator.pushReplacementNamed(context, Routes.logingRoute);
      }
    } catch (e) {
      Navigator.pushReplacementNamed(context, Routes.logingRoute);
    }
  }

  startTime() async {
    var duration = Duration(seconds: 1);
    return Timer(duration, _checkUserExist);
  }

  void navigationPage() {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.logingRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: CircularProgressIndicator(),
      ),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/driver_app_splace_screen.png'),
      //     fit: BoxFit.fill,
      //   ),
      // ),
    );
  }
}
