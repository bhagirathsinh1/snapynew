import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:photos_by_snappy/ApiManager/http_config.dart';
import 'package:photos_by_snappy/model/event_model.dart';
import 'package:photos_by_snappy/widget/grid_data.dart';

class PhotoGridWidget extends StatefulWidget {
  PhotoGridWidget({
    Key? key,
    this.images,
  }) : super(key: key);

  final List<Images>? images;

  @override
  _PhotoGridWidgetState createState() => _PhotoGridWidgetState();
}

class _PhotoGridWidgetState extends State<PhotoGridWidget> {
  List<bool> isSelectedList = [];

  bool isLongPress = false;
  _unSelectBox() {
    for (int i = 0; i < isSelectedList.length; i++) {
      setState(() {
        isSelectedList[i] = false;
        isLongPress = false;
      });
    }
  }

  void _toggleLongPressPress() {
    setState(() {
      isLongPress = !isLongPress;
    });
  }

  void _toggleIsSelect(int index) {
    var temp = isSelectedList.where((element) => element == false);

    setState(() {
      isSelectedList[index] = !isSelectedList[index];
    });

    if (temp.length == isSelectedList.length) {
      _toggleLongPressPress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _unSelectBox();
      },
      child: widget.images!.isEmpty
          ? _buildNoImageWidget(context, 1)
          : GridView.builder(
              padding: EdgeInsets.only(top: 60, bottom: 30),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: widget.images!.length,
              itemBuilder: (BuildContext context, int index) {
                widget.images!.forEach((e) {
                  isSelectedList.add(false);
                });
                return GridData(
                    image: HttpConfig.IMAGE_BASE_URL +
                        widget.images![index].path.toString(),
                    id: widget.images![index].id.toString(),
                    callback: _toggleLongPressPress,
                    index: index,
                    callbackonpress: _toggleIsSelect,
                    isLongPress: isLongPress,
                    isSelected: isSelectedList[index]);
              },
            ),
    );
  }

  InkWell _buildNoImageWidget(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, Routes.eventDetails);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 20,
        height: MediaQuery.of(context).size.width / 2 - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        transform: index.isOdd
            ? Matrix4.translationValues(0.0, 25.0, 0.0)
            : Matrix4.translationValues(0.0, -25.0, 0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(15),
                  dashPattern: [6, 6],
                  strokeWidth: 2,
                  color: Colors.grey,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Icon(
                            Icons.alarm,
                            size: 40,
                            color: Colors.grey,
                          )),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
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
}
