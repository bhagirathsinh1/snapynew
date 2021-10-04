import 'dart:async';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photos_by_snappy/ApiManager/http_config.dart';
import 'package:photos_by_snappy/ApiManager/save_data.dart';
import 'package:photos_by_snappy/model/event_register_model.dart';
import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/common.dart';
import 'package:photos_by_snappy/widget/event_textbox_widget.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventEmmediate extends StatefulWidget {
  EventEmmediate({Key? key}) : super(key: key);

  @override
  _EventEmmediateState createState() => _EventEmmediateState();
}

class _EventEmmediateState extends State<EventEmmediate> {
  final double cardHeight = 300;
  final double cardWidth = 200;
  TimeOfDay _time = TimeOfDay.now();
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventMessageController = TextEditingController();
  TextEditingController _endEventTimeController = TextEditingController();

  DateTime _dateTime = DateTime.now();

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
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.all(0),
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Text(
                        "Immediate Event",
                        style: ThemeClass.titleTextStyleGreen,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Text("Please enter details to start event.",
                      style: ThemeClass.subTitleStyleGray),
                ),
                SizedBox(
                  height: 50,
                ),
                _buildTextTitle("Event Name"),
                eventTextBox(
                    "Anthony's wedding", false, _eventNameController, () {}),
                SizedBox(
                  height: 10,
                ),
                _buildTextTitle("End Event"),
                // eventTextBox("Select Time", true, _endEventTimeController, () {
                //   selectTime(context);
                // }),

                EventTextBoxWidget(
                    callback: () {},
                    isReadOnly: true,
                    controller: _endEventTimeController,
                    validator: (value) {},
                    isSufix: true,
                    hintText: "HH:MM",
                    onTap: () {
                      // selectStartDate(context);
                      selectTime(context);
                    },
                    icon: Icons.alarm),

                SizedBox(
                  height: 10,
                ),
                _buildTextTitle("Message"),
                eventTextBoxExpand("Message", _eventMessageController),
                SizedBox(
                  height: 40,
                ),

                ButtonWidget(
                    buttonTitle: "START EVENT",
                    onClick: () {
                      _submitImmediateEvent(context);
                    },
                    color: ThemeClass.greenColor),
                SizedBox(
                  height: 110,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  Container eventTextBox(String hintText, bool isalarm,
      TextEditingController controller, final Function()? onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white54,
      ),
      child: TextField(
        controller: controller,
        onTap: onTap,
        style: TextStyle(
          color: ThemeClass.greyColor,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          suffixIcon: isalarm
              ? IconButton(
                  icon: Icon(
                    Icons.alarm,
                    color: ThemeClass.greenColor,
                  ),
                  onPressed: () {
                    _selectTime();
                  },
                )
              : null,
          focusColor: ThemeClass.greenColor,
          hintText: hintText,
          prefixStyle: TextStyle(color: ThemeClass.greyColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ThemeClass.greyColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ThemeClass.greyColor,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  void selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        // DateFormat("HH-mm-ss").format(time);
        var hour = selectedTime.hour.toString();
        var minute = selectedTime.minute.toString();

        if (hour.length == 1) {
          hour = "0" + hour;
        }
        if (minute.length == 1) {
          minute = "0" + minute;
        }
        var time = "$hour:$minute";
        _endEventTimeController.text = time;
      });
  }

  Container eventTextBoxExpand(
      String hintText, TextEditingController controller) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white54,
        ),
        child: TextField(
          controller: controller,
          style: TextStyle(
            color: ThemeClass.greyColor,
            fontSize: 18,
          ),
          keyboardType: TextInputType.multiline,
          minLines: 4,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: hintText,
            prefixStyle: TextStyle(color: ThemeClass.greyColor),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ThemeClass.greyColor,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ThemeClass.greyColor,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildTextTitle(String text) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(
        text,
        style: TextStyle(color: ThemeClass.greyColor, fontSize: 16),
      ),
    );
  }

  Future<void> _submitImmediateEvent(BuildContext context) async {
    var user = await SaveData.getUserData();
    var eventName = _eventNameController.text.toString();
    var eventEnd = _endEventTimeController.text.toString();
    var eventMessage = _eventMessageController.text.toString();

    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25

    var events = EventRegisterModel(
        userid: user.id.toString(),
        eventTitle: eventName,
        endTime: eventEnd,
        description: eventMessage,
        startDate: formattedDate,
        eventType: 0,
        notify: false,
        status: 0);

    // try {
    //   showSnackbarMessageGlobal("Event Successfully created.", context);
    // } catch (r) {
    //   print(r);
    // }

    try {
      var response = await HttpConfig.httpPost("events", events);

      if (response.statusCode == 201) {
        Navigator.pushReplacementNamed(context, Routes.eventCreatedSuccess);
        showSnackbarMessageGlobal("Event Successfully created.", context);
      } else if (response.statusCode == 422) {
        showSnackbarMessageGlobal("Something went wrong!", context);
      } else {
        showSnackbarMessageGlobal("Something went wrong!", context);
      }
    } catch (e) {
      if (e is SocketException) {
        showSnackbarMessageGlobal("Socket exception", context);
      } else if (e is TimeoutException) {
        showSnackbarMessageGlobal("Time out exception", context);
      } else {
        showSnackbarMessageGlobal("exception $e", context);
      }
    }
  }
}
