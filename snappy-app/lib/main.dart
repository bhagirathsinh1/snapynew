import 'package:flutter/material.dart';
import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var intialroutes;

  @override
  void initState() {
    super.initState();
    // checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // canvasColor: Colors.transparent,
        accentColor: ThemeClass.greyColor,
        fontFamily: 'Gilroy',
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.loadingScreen,
      routes: Routes.globalRoutes,
    );
  }
}
