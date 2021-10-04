import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNev extends StatefulWidget {
  BottomNev({Key? key, this.currentIndex, this.onTabTapped}) : super(key: key);
  final int? currentIndex;
  final Function? onTabTapped;
  @override
  _BottomNevState createState() => _BottomNevState();
}

class _BottomNevState extends State<BottomNev> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        height: 70,

        decoration: BoxDecoration(
          //  border: Border.all(color: Colors.blueAccent),
          color: Color(0xFF2F4858),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        // borderRadius: BorderRadius.all(Radius.circular(10))),
        child: CustomBottomNavigationBar(
          iconList: [
            Icons.home,
            Icons.card_giftcard,
            Icons.camera,
            Icons.pie_chart,
          ],
          titleList: ['home', 'events', 'camera', ''],
          onChange: (val) {
            // setState(() {
            //   _selectedItem = val;
            // });
            widget.onTabTapped!(val);
          },
          defaultSelectedIndex: 0,
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int)? onChange;
  final List<IconData>? iconList;
  final List<String>? titleList;

  CustomBottomNavigationBar(
      {this.defaultSelectedIndex = 0,
      @required this.iconList,
      @required this.onChange,
      this.titleList});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];
  List<String>? _titlelist = [];
  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList!;
    _titlelist = widget.titleList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], _titlelist![i], i));
    }

    return Row(
      //  mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(IconData icon, String title, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange!(index);
        setState(() {
          // print("index $index");
          _selectedIndex = index;
        });
      },
      child: index == 3
          ? Container(
              height: 60,
              decoration: index == _selectedIndex
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2.0, color: Colors.green),
                      ),
                    )
                  : BoxDecoration(
                      border: Border.all(style: BorderStyle.none),
                    ),
              child: Center(
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: CachedNetworkImageProvider(
                      "https://picsum.photos/536/354"),
                  //backgroundColor: Colors.yellow,
                ),
              ))
          : Container(
              height: 60,
              decoration: index == _selectedIndex
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2.0, color: Colors.green),
                      ),
                    )
                  : BoxDecoration(
                      border: Border.all(style: BorderStyle.none),
                    ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    icon,
                    color:
                        index == _selectedIndex ? Colors.green : Colors.white,
                    size: 20,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      color:
                          index == _selectedIndex ? Colors.green : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
