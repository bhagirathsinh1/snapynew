import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageDisplayScreen extends StatefulWidget {
  ImageDisplayScreen({Key? key, required this.image}) : super(key: key);
  final XFile image;
  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen>
    with TickerProviderStateMixin {
  late Timer timer;
  int _start = 2;

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (_start == 1) {
          //  await photoClick();
          setState(() {
            timer.cancel();
            _start = 2;
            Navigator.pop(context, true);
            print("Photo Clicked");
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(
                    File(widget.image.path),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Center(
                                child: Text(
                                  "$_start",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
