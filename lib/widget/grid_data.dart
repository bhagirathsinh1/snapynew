import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridData extends StatefulWidget {
  final String image;
  final String id;
  final Function callback;
  final Function callbackonpress;
  final bool isLongPress;
  final int index;
  final bool isSelected;

  GridData(
      {Key? key,
      required this.image,
      required this.id,
      required this.callback,
      required this.callbackonpress,
      required this.isLongPress,
      required this.index,
      required this.isSelected})
      : super(key: key);

  @override
  _GridDataState createState() => _GridDataState();
}

class _GridDataState extends State<GridData> {
  var mode = BlendMode.color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        focusColor: Colors.red,
        onLongPress: () {
          if (widget.isLongPress == false) {
            widget.callback();
            widget.callbackonpress(widget.index);
          }
        },
        onTap: () {
          if (widget.isLongPress == true) {
            widget.callbackonpress(widget.index);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          transform: widget.index.isOdd
              ? Matrix4.translationValues(0.0, 20.0, 0.0)
              : Matrix4.translationValues(0.0, -20.0, 0.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              widget.isSelected
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(widget.image),
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                  Colors.white70.withOpacity(0.9), mode))),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          // color: Colors.blue,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(widget.image),
                              fit: BoxFit.fill)),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
              Positioned(
                top: 10,
                right: 10,
                child: AnimatedContainer(
                  height: widget.isSelected ? 27 : 20,
                  width: widget.isSelected ? 27 : 20,
                  duration: Duration(milliseconds: 1000),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: Offset(5, 10),
                      ),
                    ],
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: widget.isSelected
                      ? Icon(
                          Icons.done_rounded,
                          size: 22,
                          color: Colors.blue,
                        )
                      : null,
                ),
              ),
            ],
          ),
        ));
  }
}
