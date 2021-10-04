import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photos_by_snappy/ApiManager/http_config.dart';

class NormalImageDisplayScreen extends StatefulWidget {
  NormalImageDisplayScreen({Key? key, required this.image}) : super(key: key);
  final XFile image;
  @override
  _NormalImageDisplayScreenState createState() =>
      _NormalImageDisplayScreenState();
}

class _NormalImageDisplayScreenState extends State<NormalImageDisplayScreen> {
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[850],
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[850],
                              child: IconButton(
                                onPressed: () {
                                  _uploadImage();
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            )
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

  _uploadImage() async {
    try {
      var file = await HttpConfig.uploadProfilePic(widget.image);
      print(file);
    } catch (e) {
      print(e);
    }
  }

  patchEvent() {}
}
