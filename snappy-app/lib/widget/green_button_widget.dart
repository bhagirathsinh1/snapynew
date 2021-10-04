import 'package:flutter/material.dart';
import 'package:photos_by_snappy/pages/login_page.dart';
import 'package:photos_by_snappy/themeData.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.buttonTitle,
    required this.onClick,
    required this.color,
    //required this.isLoading
  }) : super(key: key);

  final String buttonTitle;
  final Function onClick;
  final Color color;
  // final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 15,
          ),
          child: isLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  buttonTitle,
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    color: Colors.white,
                    fontSize: 16,
                    //fontWeight: FontWeight.medium
                  ),
                ),
        ),
        color: color,
        onPressed: () {
          onClick();
        },
      ),
    );
  }
}

//buttonWidget(String buttonTitle, Function onClick, BuildContext context,
//      Color color, bool isLoading) =>
// Center(
//   child: MaterialButton(
//     minWidth: MediaQuery.of(context).size.width * 0.5,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 50,
//         vertical: 15,
//       ),
//       child: isLoading
//           ? CircularProgressIndicator()
//           : Text(
//               buttonTitle,
//               style: TextStyle(
//                 fontFamily: "Gilroy",
//                 color: Colors.white,
//                 fontSize: 16,
//                 //fontWeight: FontWeight.medium
//               ),
//             ),
//     ),
//     color: color,
//     onPressed: () {
//       onClick();
//     },
//   ),
// );

Widget titleLoginRegisterWidget(String text) => Container(
      child: Text(
        text,
        style: ThemeClass.titleTextStyleGreen,
      ),
    );

Widget subTitleLoginRegisteWidget(String text) => Container(
      child: Text(
        text,
        style: ThemeClass.smallSubTitleStyleGray,
      ),
    );
