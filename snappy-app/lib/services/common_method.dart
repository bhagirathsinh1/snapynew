import 'package:intl/intl.dart';

String getFormattedDate(String date) {
  if (date != "") {
    int date1 = int.parse(date);
    DateFormat formattercurrentDate = new DateFormat('dd/MM/yyyy');
    var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(date1);
    var formatedDate = formattercurrentDate.format(dateFromTimeStamp);
    return formatedDate;
  } else {
    return "";
  }
}
