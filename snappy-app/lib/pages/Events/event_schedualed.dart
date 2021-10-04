
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:photos_by_snappy/ApiManager/http_config.dart';
import 'package:photos_by_snappy/ApiManager/save_data.dart';
import 'package:photos_by_snappy/model/event_register_model.dart';
import 'package:photos_by_snappy/routes.dart';

import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/common.dart';
import 'package:photos_by_snappy/widget/event_textbox_widget.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';


import 'package:shared_preferences/shared_preferences.dart';

class EventSchedualed extends StatefulWidget {
  EventSchedualed({Key? key}) : super(key: key);

  @override
  _EventSchedualedState createState() => _EventSchedualedState();
}

class _EventSchedualedState extends State<EventSchedualed> {

String ?_setTime, _setDate;

  String? hour, minute, time;

  String ?dateTime;

  DateTime selectedDate = DateTime.now();

   
   

  final double cardHeight = 300;
  final double cardWidth = 200;
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventDateController = TextEditingController();
  TextEditingController _eventEndDateController = TextEditingController();
  TextEditingController _eventStartController = TextEditingController();
  TextEditingController _eventEndController = TextEditingController();
  TextEditingController _eventPlaceController = TextEditingController();
  TextEditingController _eventMessageController = TextEditingController();
  String? userid;
  bool _switchValue = true;
  DateTime _dateTime = DateTime.now();

  final _formKey = GlobalKey<FormState>();

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
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.all(0),
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      SizedBox(width: 15),
                      Container(
                        child: Text(
                          "Scheduled Event",
                          style: ThemeClass.titleTextStyleGreen,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Text(
                      "Please enter schedule for event.",
                      style: ThemeClass.subTitleStyleGray,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  _buildTextTitle("Event Name"),
                  EventTextBoxWidget(
                      validator: _notNullValidator,
                      hintText: "Anthony's wedding",
                      isPassword: false,
                      controller: _eventNameController),
                  SizedBox(
                    height: 10,
                  ),
                  _buildTextTitle("Event Start Date"),
                  EventTextBoxWidget(
                      onTap: () {
                        selectStartDate(context);
                      },
                      callback:(){
                        //  selectStartDate(context);
                      },
                      validator: _notNullValidator,
                      isSufix: true,
                      isReadOnly: true,
                      hintText: "DD-MM-YYYY",
                      controller: _eventDateController,
                      icon: Icons.calendar_today),
                  SizedBox(
                    height: 10,
                  ),
                  //  _buildTextTitle("Event End Date"),
                  // EventTextBoxWidget(
                  //     onTap: () {
                  //       selectStartDate(context);
                  //     },
                  //     callback:(){
                       
                  //     },
                  //     validator: _notNullValidator,
                  //     isSufix: true,
                  //     isReadOnly: true,
                  //     hintText: "DD-MM-YYYY",
                  //     controller: _eventEndDateController,
                  //     icon: Icons.calendar_today),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  _buildRowStartAndEndEvent(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildTextTitle("Event Place"),
                  EventTextBoxWidget(
                      validator: _notNullValidator,
                      hintText: "Location",
                      isSufix: true,
                      callback:(){},
                      controller: _eventPlaceController,
                      icon: Icons.location_on_sharp),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Notify Me When Event Starts",
                            style: TextStyle(
                                color: ThemeClass.greyColor, fontSize: 16)),
                      ),
                      Container(
                        child: Switch(
                            activeColor: ThemeClass.greenColor,
                            activeTrackColor: Color(0xFF2f4858),
                            inactiveTrackColor: Color(0xFF2f4858),
                            value: _switchValue,
                            onChanged: (val) {
                              setState(() {
                                _switchValue = val;
                              });
                            }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildTextTitle("Message"),
                  eventTextBoxExpand(
                      "Type text here...... ", _eventMessageController),
                  SizedBox(
                    height: 40,
                  ),
                   ButtonWidget(
                    buttonTitle: "SCHEDULE EVENT",
                    onClick: () {
                      _schedualEvent(context);
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
      ),
    );
  }

  selectStartDate(BuildContext context) async {
      DateTime? picked = await showDatePicker(
      context: context,
    builder: (BuildContext context, Widget ?child) {
      return Theme(
        data: ThemeData(
          primarySwatch: Colors.grey,
          splashColor: Colors.black,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.black),
            button: TextStyle(color: Colors.black),
          ),
          accentColor: Colors.black,
          colorScheme: ColorScheme.light(
              primary: ThemeClass.greenColor,
              primaryVariant: Colors.black,
              secondaryVariant: Colors.black,
              onSecondary: Colors.black,
              onPrimary: Colors.white,
             
            ),
           dialogBackgroundColor: Colors.white,
        ),
        child: child ??Text(""),
      );

    }
    initialDate: _dateTime,
    firstDate: DateTime.now(),
    lastDate: DateTime(2050, 8)
    );
if (picked != null && picked != _dateTime)
  setState(() {
    _dateTime = picked;
      var date =
          "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
      _eventDateController.text = date;

  });

}

selectEndDate(BuildContext context) async {
      DateTime? picked = await showDatePicker(
      context: context,
    builder: (BuildContext context, Widget ?child) {
      return Theme(
        data: ThemeData(
          primarySwatch: Colors.grey,
          splashColor: Colors.black,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.black),
            button: TextStyle(color: Colors.black),
          ),
          accentColor: Colors.black,
          colorScheme: ColorScheme.light(
              primary: ThemeClass.greenColor,
              primaryVariant: Colors.black,
              secondaryVariant: Colors.black,
              onSecondary: Colors.black,
              onPrimary: Colors.white,
             
            ),
           dialogBackgroundColor: Colors.white,
        ),
        child: child ??Text(""),
      );

    }
    initialDate: _dateTime,
    firstDate: DateTime(1960, 8),
    lastDate: DateTime.now());
if (picked != null && picked != _dateTime)
  setState(() {
    _dateTime = picked;
      var date =
          "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
      _eventEndDateController.text = date;

  });

}

  Row _buildRowStartAndEndEvent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextTitle("Event Starts"),
                EventTextBoxWidget(
                    callback: () {},
                    isReadOnly: true,
                    controller: _eventStartController,
                    validator: (value) {},
                    isSufix: true,
                    hintText: "HH:MM",
                    onTap: () {
                      selectTime(context,true);
                    },
                    icon: Icons.alarm),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextTitle("Event Ends"),
                EventTextBoxWidget(
                    callback: () {},
                    isReadOnly: true,
                    controller: _eventEndController,
                    validator: (value) {},
                    isSufix: true,
                    onTap: () {
                      print("object");
                      selectTime(context,false);
                    },
                    hintText: "HH:MM",
                    icon: Icons.alarm),
              ],
            ),
          ),
        )
      ],
    );
  }


Container eventTextBoxExpand(
    String hintText, TextEditingController controller) {
  return Container(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white54,
      ),
      child: TextFormField(
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
    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
    child: Text(
      text,
      style: TextStyle(color: ThemeClass.greyColor, fontSize: 16),
    ),
  );
}


  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  selectTime(BuildContext context ,bool isStartDAte) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        // DateFormat("HH-mm-ss").format(time);
       var  hour = selectedTime.hour.toString();
       var  minute = selectedTime.minute.toString();

        if(hour.length == 1){
          hour = "0"+hour;
        }

         if(minute.length == 1){
          minute = "0"+minute;
        }

        var time = "$hour:$minute";
        if(isStartDAte){
        _eventStartController.text = time;
        }else{
          _eventEndController.text = time;

        }
      });
  }

  

  Future<void> _schedualEvent(BuildContext context) async {
    if (this._formKey.currentState!.validate()) {
     var user = await SaveData.getUserData();
      var eventName = _eventNameController.text.toString();
      var eventDate = _eventDateController.text.toString();
      var eventEndDate = _eventEndDateController.text.toString();
      
      var eventEnd = _eventEndController.text.toString();
      var eventMessage = _eventMessageController.text.toString();
      var eventPlace = _eventPlaceController.text.toString();
      var eventStart = _eventStartController.text.toString();

      
       var events = EventRegisterModel(
      userid: user.id.toString(),
      eventTitle: eventName,
      startTime: eventStart,
      endTime: eventEnd,
      description: eventMessage,
      eventType: 1,
      location: eventPlace,
      notify: _switchValue,
      startDate:eventDate,
      endDate: eventEndDate,
      
      status:  2
    );

    

      try{
        var response = await HttpConfig.httpPost("events", events);

         if (response.statusCode == 201) {
        Navigator.pushReplacementNamed(context, Routes.eventCreatedSuccess);
        showSnackbarMessageGlobal("Event Successfully created.", context);
      } else if (response.statusCode == 422) {
        showSnackbarMessageGlobal("Something went wrong!", context);
      } else {
        showSnackbarMessageGlobal("Something went wrong!", context);
      }
        
      }catch(e){
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

  String? _notNullValidator(String? input) {
    input = _eventNameController.text.toString();
    input = _eventDateController.text.toString();
    input = _eventEndController.text.toString();
    input = _eventMessageController.text.toString();
    input = _eventPlaceController.text.toString();
    input = _eventStartController.text.toString();

    if (input.isEmpty) {
      return 'Please Enter Valid Input';
    }
  }



  
}
