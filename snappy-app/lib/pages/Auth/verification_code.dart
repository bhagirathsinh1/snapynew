import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:photos_by_snappy/ApiManager/http_config.dart';
import 'package:photos_by_snappy/model/verification_model.dart';
import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/common.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificatonCode extends StatefulWidget {
  VerificatonCode({Key? key}) : super(key: key);

  // String get var1 => null;

  @override
  _VerificatonCodeState createState() => _VerificatonCodeState();
}

class _VerificatonCodeState extends State<VerificatonCode> {
  TextEditingController otpController = TextEditingController();

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
                        icon: Icon(Icons.arrow_back_ios)),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Verify your email.",
                  style: ThemeClass.titleTextStyleGreen,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  "We have sent code to your registered email. Please enter code to continue.",
                  style: ThemeClass.smallSubTitleStyleGray,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                _buildPinWidget(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                ButtonWidget(
                    buttonTitle: "CONTINUE",
                    onClick: () {
                      verifyData(context);
                    },
                    color: ThemeClass.greenColor),
                // buttonWidget('CONTINUE', () {
                //   verifyData(context);
                // }, context, ThemeClass.greenColor),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Didn't get an email?",
                        style: TextStyle(
                            color: ThemeClass.greyColor, fontSize: 18),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.registerRoute);
                      },
                      child: Container(
                        child: Text(
                          "Resend",
                          style: TextStyle(
                              color: ThemeClass.greenColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildPinWidget(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        pastedTextStyle: TextStyle(
          color: Colors.transparent,
          fontWeight: FontWeight.bold,
        ),
        length: 6,
        obscureText: false,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        validator: (v) {
          if (v!.length < 3) {
            return "Please Enter Vaild data ";
          } else {
            return null;
          }
        },
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 45,
          fieldWidth: 45,
          borderWidth: 1,
          //
          activeColor: Colors.black.withOpacity(0.5),
          activeFillColor: Colors.white70,
          //
          inactiveColor: Colors.black.withOpacity(0.5),
          inactiveFillColor: Colors.transparent,
          //
          selectedFillColor: Colors.transparent,
          errorBorderColor: Colors.black87,
        ),
        cursorColor: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        controller: otpController,
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          // print("Completed+$otpS");
        },
        onChanged: (value) {
          // print(value);
        },
        beforeTextPaste: (text) {
          //  print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    );
  }

  Future<void> verifyData(BuildContext context) async {
    // widget.;
    final email = ModalRoute.of(context)!.settings.arguments as String;
    String otp = otpController.text.toString();

    var verificationData =
        VerificationModel(email: email, verificationCode: otp);

    try {
      var response =
          await HttpConfig.httpPost("auth/userVerification", verificationData);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Navigator.pushNamed(context, Routes.logingRoute);
      } else if (response.statusCode == 422) {
        showSnackbarMessageGlobal("Please enter correct otp", context);
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
