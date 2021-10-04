import 'package:flutter/material.dart';

void buildBottomSheet({
  required BuildContext context,
  required String firsttitle,
  required String secondTitle,
  required Function firstCallBack,
  required Function secondCallBack,
}) {
  showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
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
                    onPressed: () async {
                      // var pickedImage =
                      //     await _picker.pickImage(source: ImageSource.gallery);
                      // setState(() {
                      //   image = File(pickedImage!.path);
                      //   isSelected = true;
                      // });
                      firstCallBack();
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        firsttitle,
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
                    onPressed: () async {
                      // var pickedImage =
                      //     await _picker.pickImage(source: ImageSource.camera);
                      // setState(() {
                      //   image = File(pickedImage!.path);
                      //   isSelected = true;
                      // });
                      secondCallBack();
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        secondTitle,
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
