import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:photos_by_snappy/pages/camera/normal_camera.dart';
import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/screens/camera_screen.dart';

import 'package:photos_by_snappy/screens/event_add.dart';
import 'package:photos_by_snappy/screens/home_screen.dart';
import 'package:photos_by_snappy/screens/user_profile.dart';
import 'package:photos_by_snappy/widget/bottom_bav_bar.dart';
import 'dart:math' as math;

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int currentIndex = 0;
  // var cameras;

  bool isLoading = true;

  late var cameras;
  @override
  void initState() {
    iniCam();
    super.initState();
  }

  iniCam() async {
    cameras = await availableCameras();
    print(cameras);

    setState(() {
      isLoading = false;
    });
  }

  void onTabTapped(int index) async {
    // cameras = await availableCameras();
    setState(() {
      currentIndex = index;
    });
  }

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    Map<String, WidgetBuilder> _tempOne = {
      '/': (context) {
        return [
          HomeScreen(),

          AddNewEvent(),
          // CameraScreen(),
          isLoading ? Container() : NormalCameraScreen(camera: cameras),

          UserProfile(),
        ].elementAt(index);
      }
    };

    Map<String, WidgetBuilder> _tempTwo = Routes.getAllNavigator1(index);

    Map<String, WidgetBuilder> _thirdMap = {};

    _thirdMap.addAll(_tempOne);
    _thirdMap.addAll(_tempTwo);

    return _thirdMap;
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);
    // print("object ${_navigatorKeys[index]}");
    return Offstage(
      offstage: currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              return routeBuilders[routeSettings.name]!(context);
            },
          );
        },
      ),
    );
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Stack(
            children: [
              _buildOffstageNavigator(1),
              _buildOffstageNavigator(2),
              _buildOffstageNavigator(0),
              _buildOffstageNavigator(3),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var isFirstRouteInCurrentTab =
            !await _navigatorKeys[currentIndex].currentState!.maybePop();
        print("ok done $isFirstRouteInCurrentTab");

        if (isFirstRouteInCurrentTab) {
          final value = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Are you sure you want to exit?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: Text('Yes, exit'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              });

          return value == true;
        } else {
          return false;
          // return isFirstRouteInCurrentTab;
        }
      },
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: LayoutBuilder(builder: _buildStack),
          bottomNavigationBar: BottomNev(
            currentIndex: currentIndex,
            onTabTapped: onTabTapped,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
