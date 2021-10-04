import 'package:flutter/material.dart';

import 'package:photos_by_snappy/pages/Auth/create_new_password.dart';
import 'package:photos_by_snappy/pages/Auth/email_verification.dart';
import 'package:photos_by_snappy/pages/Auth/reset_password.dart';
import 'package:photos_by_snappy/pages/Auth/verification_code.dart';
import 'package:photos_by_snappy/pages/Events/event_created_success.dart';
import 'package:photos_by_snappy/pages/Events/event_created_success_start_event.dart';
import 'package:photos_by_snappy/pages/Events/event_immediate.dart';
import 'package:photos_by_snappy/pages/Events/event_join_other_event.dart';
import 'package:photos_by_snappy/pages/Events/event_schedualed.dart';
import 'package:photos_by_snappy/pages/Events/event_subscription.dart';
import 'package:photos_by_snappy/pages/Events/start_event.dart';
import 'package:photos_by_snappy/pages/Home/event_details.dart';
import 'package:photos_by_snappy/pages/Home/user_list.dart';
import 'package:photos_by_snappy/pages/loading_screen.dart';
import 'package:photos_by_snappy/screens/event_add.dart';
import 'package:photos_by_snappy/pages/login_page.dart';

import 'package:photos_by_snappy/screens/main_screen.dart';
import 'package:photos_by_snappy/pages/register_page.dart';
import 'package:photos_by_snappy/screens/user_profile.dart';

class Routes {
  static final String mainRoute = "/";

  static final String logingRoute = "/login";
  static final String registerRoute = "/register";

  static final String addNewEvent = "/event";
  static final String eventSubscription = "/eventSubscription";
  static final String eventEmmediate = "/eventEmmediate";
  static final String eventDetails = "/eventDetails";
  static final String userList = "/userList";
  static final String eventSchedualed = "/eventSchedualed";
  static final String eventCreatedSuccess = "/eventCreatedSuccess";
  static final String eventCreatedSuccessStartEvent =
      "/eventCreatedSuccessStartEvent";
  static final String eventJoinOtherEvent = "/eventJoinOtherEvent";
  static final String startevent = "/startEvent";
  static final String verificatonCode = "/VerificatonCode";
  static final String resetPassword = "/ResetPassword";
  static final String emailVerification = "/emailVerification";
  static final String createNewPassword = "/createNewPassword";
  static final String userProfile = "/userProfile";
  static final String loadingScreen = "/LoadingScreen";

  static Map<String, Widget Function(BuildContext)> globalRoutes = {
    loadingScreen: (context) => LoadingScreen(),
    logingRoute: (context) => LoginPage(),
    mainRoute: (context) => MainScreen(),
    registerRoute: (context) => RegisterScreen(),
    addNewEvent: (context) => AddNewEvent(),
    eventSubscription: (context) => EventSubscription(),
    eventEmmediate: (context) => EventEmmediate(),
    eventDetails: (context) => EventDetails(),
    userList: (context) => UserList(),
    eventSchedualed: (context) => EventSchedualed(),
    eventCreatedSuccess: (context) => EventCreatedSuccess(),
    eventCreatedSuccessStartEvent: (context) => EventCreatedSuccessStartEvent(),
    eventJoinOtherEvent: (context) => EventJoinOtherEvent(),
    startevent: (context) => StartEvent(),
    verificatonCode: (context) => VerificatonCode(),
    resetPassword: (context) => ResetPassword(),
    emailVerification: (context) => EmailVerification(),
    createNewPassword: (context) => CreateNewPassword(),
    userProfile: (context) => UserProfile(),
  };

  static Map<String, WidgetBuilder> getAllNavigator1(int index) {
    Map<String, WidgetBuilder> globalRoutesForNav = {
      userList: (context) => UserList(),
      eventDetails: (context) => EventDetails(),
      eventSchedualed: (context) => EventSchedualed(),
      eventEmmediate: (context) => EventEmmediate(),
      eventSubscription: (context) => EventSubscription(),
      eventCreatedSuccess: (context) => EventCreatedSuccess(),
      eventCreatedSuccessStartEvent: (context) =>
          EventCreatedSuccessStartEvent(),
      eventJoinOtherEvent: (context) => EventJoinOtherEvent(),
    };

    return globalRoutesForNav;
  }

  // static Map<String, WidgetBuilder> getAllNavigator(int index) {
  //   Map<String, WidgetBuilder> globalRoutesForNav = {
  //     userList: (context) => [UserList()].elementAt(index),
  //     eventDetails: (context) => [EventDetails()].elementAt(index),
  //     eventSchedualed: (context) => [EventSchedualed()].elementAt(index),
  //   };

  //   return globalRoutesForNav;
  // }
}
