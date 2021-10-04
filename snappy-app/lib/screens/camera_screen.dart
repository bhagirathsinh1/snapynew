import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:photos_by_snappy/pages/camera/normal_camera.dart';
import 'package:photos_by_snappy/pages/camera/slatter_camera.dart';

import 'package:photos_by_snappy/themeData.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();
  }

  // _imgFromCamera() async {
  //   PickedFile? image = await ImagePicker.platform.pickImage(
  //       source: ImageSource.camera,
  //       imageQuality: 50,
  //       maxHeight: MediaQuery.of(context).size.height);

  //   setState(() {
  //     //_image = image;
  //   });
  // }

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
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blueAccent.withOpacity(0.5)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              5.0), //                 <--- border radius here
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 8.0),
                              width: MediaQuery.of(context).size.width * 1.0,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: ThemeClass.greenColor,
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  final cameras = await availableCameras();
                                  // Navigator.of(context, rootNavigator: true)
                                  //     .push(
                                  //   MaterialPageRoute(
                                  //     builder: (_) => new NormalCameraScreen(
                                  //       camera: cameras,

                                  //     ),
                                  //   ),
                                  // );
                                  // Navigator.of(context).pop();
                                  // Navigator.of(context, rootNavigator: true)
                                  //     .push(
                                  //   MaterialPageRoute(
                                  //     builder: (_) => new CameraExampleHome(),
                                  //   ),
                                  // );
                                  //  _imgFromCamera();
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Open Camera",
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
                                color: Color(0xffE7F4FC),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  final cameras = await availableCameras();
                                  Navigator.of(context, rootNavigator: true)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (_) => new SlatterImageScreen(
                                        camera: cameras,
                                      ),
                                    ),
                                  );
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Try Photobooth",
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(color: Color(0xff2F4858)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
