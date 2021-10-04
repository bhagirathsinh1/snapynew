// To parse this JSON data, do
//
//     final eventRegisterModel = eventRegisterModelFromJson(jsonString);

import 'dart:convert';

EventRegisterModel eventRegisterModelFromJson(String str) =>
    EventRegisterModel.fromJson(json.decode(str));

String eventRegisterModelToJson(EventRegisterModel data) =>
    json.encode(data.toJson());

class EventRegisterModel {
  EventRegisterModel({
    this.userid,
    this.eventTitle,
    this.startTime,
    this.endTime,
    this.location,
    this.description,
    this.startDate,
    this.endDate,
    this.eventType,
    this.status,
    this.notify,
  });

  String? userid;
  String? eventTitle;
  String? startTime;
  String? endTime;
  String? location;
  String? description;
  String? startDate;
  String? endDate;
  int? eventType;
  int? status;
  bool? notify;

  factory EventRegisterModel.fromJson(Map<String, dynamic> json) =>
      EventRegisterModel(
        userid: json["userid"] == null ? null : json["userid"],
        eventTitle: json["event_title"] == null ? null : json["event_title"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        location: json["location"] == null ? null : json["location"],
        description: json["description"] == null ? null : json["description"],
        startDate: json["start_date"] == null ? null : json["start_date"],
        endDate: json["end_date"] == null ? null : json["end_date"],
        eventType: json["event_type"] == null ? null : json["event_type"],
        status: json["status"] == null ? null : json["status"],
        notify: json["notify"] == null ? null : json["notify"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid == null ? null : userid,
        "event_title": eventTitle == null ? null : eventTitle,
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "location": location == null ? null : location,
        "description": description == null ? null : description,
        "start_date": startDate == null ? null : startDate,
        "end_date": endDate == null ? null : endDate,
        "event_type": eventType == null ? null : eventType,
        "status": status == null ? null : status,
        "notify": notify == null ? null : notify,
      };
}
