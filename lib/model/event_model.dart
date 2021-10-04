// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.membership,
    this.isVerified,
    this.verificationCode,
    this.participant,
  });

  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? profilePicture;
  bool? membership;
  bool? isVerified;
  String? verificationCode;
  List<Participant>? participant;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"] == null ? "" : json["id"],
        email: json["email"] == null ? "" : json["email"],
        firstName: json["first_name"] == null ? "" : json["first_name"],
        lastName: json["last_name"] == null ? "" : json["last_name"],
        profilePicture:
            json["profile_picture"] == null ? "" : json["profile_picture"],
        membership: json["membership"] == null ? "" : json["membership"],
        isVerified: json["is_verified"] == null ? "" : json["is_verified"],
        verificationCode:
            json["verification_code"] == null ? "" : json["verification_code"],
        participant: json["participant"] == null
            ? []
            : List<Participant>.from(
                json["participant"].map((x) => Participant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? "" : id,
        "email": email == null ? "" : email,
        "first_name": firstName == null ? "" : firstName,
        "last_name": lastName == null ? "" : lastName,
        "profile_picture": profilePicture == null ? "" : profilePicture,
        "membership": membership == null ? "" : membership,
        "is_verified": isVerified == null ? "" : isVerified,
        "verification_code": verificationCode == null ? "" : verificationCode,
        "participant": participant == null
            ? []
            : List<dynamic>.from(participant!.map((x) => x.toJson())),
      };
}

class Participant {
  Participant({
    this.id,
    this.userid,
    this.eventid,
    this.userType,
    this.event,
    this.user,
  });

  int? id;
  int? userid;
  int? eventid;
  int? userType;
  Event? event;
  User? user;

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"] == null ? null : json["id"],
        userid: json["userid"] == null ? null : json["userid"],
        eventid: json["eventid"] == null ? null : json["eventid"],
        userType: json["user_type"] == null ? null : json["user_type"],
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userid": userid == null ? null : userid,
        "eventid": eventid == null ? null : eventid,
        "user_type": userType == null ? null : userType,
        "event": event == null ? null : event!.toJson(),
        "user": user == null ? null : user!.toJson(),
      };
}

class Event {
  Event(
      {this.id,
      this.eventTitle,
      this.userid,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.location,
      this.description,
      this.publicEvent,
      this.eventType,
      this.status,
      this.eventCode,
      this.notify,
      this.images,
      this.participant});

  int? id;
  String? eventTitle;
  int? userid;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? location;
  String? description;
  bool? publicEvent;
  int? eventType;
  int? status;
  String? eventCode;
  bool? notify;
  // Images? images;

  List<Images>? images;
  List<Participant>? participant;
  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"] == null ? null : json["id"],
        eventTitle: json["event_title"] == null ? null : json["event_title"],
        userid: json["userid"] == null ? null : json["userid"],
        startDate: json["start_date"] == null ? null : json["start_date"],
        endDate: json["end_date"] == null ? null : json["end_date"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        location: json["location"] == null ? null : json["location"],
        description: json["description"] == null ? null : json["description"],
        publicEvent: json["public_event"] == null ? null : json["public_event"],
        eventType: json["event_type"] == null ? null : json["event_type"],
        status: json["status"] == null ? null : json["status"],
        eventCode: json["event_code"] == null ? null : json["event_code"],
        notify: json["notify"] == null ? null : json["notify"],
        // images: json["images"] == null ? null : Images.fromJson(json["images"]),
        images: json["images"] == null
            ? []
            : List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        participant: json["participant"] == null
            ? []
            : List<Participant>.from(
                json["participant"].map((x) => Participant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "event_title": eventTitle == null ? "" : eventTitle,
        "userid": userid == null ? null : userid,
        "start_date": startDate == null ? null : startDate,
        "end_date": endDate == null ? null : endDate,
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "location": location == null ? null : location,
        "description": description == null ? null : description,
        "public_event": publicEvent == null ? null : publicEvent,
        "event_type": eventType == null ? null : eventType,
        "status": status == null ? null : status,
        "event_code": eventCode == null ? null : eventCode,
        "notify": notify == null ? null : notify,
        // "images": images == null ? null : images!.toJson(),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "participant": participant == null
            ? []
            : List<dynamic>.from(participant!.map((x) => x.toJson())),
      };
}

class Images {
  Images(
      {this.id,
      this.userid,
      this.eventid,
      this.downloadable,
      this.path,
      this.type,
      this.user});

  int? id;
  int? userid;
  int? eventid;
  bool? downloadable;
  String? path;
  String? type;
  User? user;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"] == null ? null : json["id"],
        userid: json["userid"] == null ? null : json["userid"],
        eventid: json["eventid"] == null ? null : json["eventid"],
        downloadable:
            json["downloadable"] == null ? null : json["downloadable"],
        path: json["path"] == null ? null : json["path"],
        type: json["type"] == null ? null : json["type"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userid": userid == null ? null : userid,
        "eventid": eventid == null ? null : eventid,
        "downloadable": downloadable == null ? null : downloadable,
        "path": path == null ? null : path,
        "type": type == null ? null : type,
        "user": user == null ? null : user!.toJson(),
      };
}

// To parse this JSON data, do
//
//     final eventRegisterModel = eventRegisterModelFromJson(jsonString);

class User {
  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.membership,
    this.isVerified,
    this.verificationCode,
  });

  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? profilePicture;
  bool? membership;
  bool? isVerified;
  String? verificationCode;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        profilePicture:
            json["profile_picture"] == null ? null : json["profile_picture"],
        membership: json["membership"] == null ? null : json["membership"],
        isVerified: json["is_verified"] == null ? null : json["is_verified"],
        verificationCode: json["verification_code"] == null
            ? null
            : json["verification_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "profile_picture": profilePicture == null ? null : profilePicture,
        "membership": membership == null ? null : membership,
        "is_verified": isVerified == null ? null : isVerified,
        "verification_code": verificationCode == null ? null : verificationCode,
      };
}
