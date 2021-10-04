import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:photos_by_snappy/ApiManager/http_config.dart';
import 'package:photos_by_snappy/ApiManager/save_data.dart';
import 'package:photos_by_snappy/model/login_model.dart';
import 'package:photos_by_snappy/model/user_model.dart';

import 'package:photos_by_snappy/pages/Auth/validator.dart';

import 'package:photos_by_snappy/routes.dart';

import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/common.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';
import 'package:photos_by_snappy/widget/text_box.dart';

//import 'package:webview_flutter/webview_flutter.dart';
bool isLoading = false;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIcon(context),
                      titleLoginRegisterWidget("Glad to have you back."),
                      SizedBox(
                        height: 15,
                      ),
                      subTitleLoginRegisteWidget(
                          "Welcome back! Enter your credentials to continue."),
                      SizedBox(
                        height: 20,
                      ),
                      _buildTextTitle("Email"),
                      TextBoxRounded(
                        hinttext: "Email",
                        inputType: TextInputType.emailAddress,
                        validator: (value) => Validators.emailValidates(value),
                        icon: Icons.email,
                        controllers: emailController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _buildTextTitle("Password"),
                      TextBoxRounded(
                        validator: (value) => Validators.nameValidator(value),
                        hinttext: "Password",
                        icon: Icons.lock,
                        ispass: true,
                        controllers: passwordController,
                      ),
                      _buildForgetPasswordTitle(),
                      SizedBox(
                        height: 25,
                      ),
                      ButtonWidget(
                        //isLoading: false,
                        color: ThemeClass.greenColor,
                        buttonTitle: "Login",
                        onClick: () {
                          _handleSubmitted(context);
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "OR",
                            style: TextStyle(
                                color: ThemeClass.greyColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _buildButtonTitle(context),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSocialIcon(context, "assets/images/google.png",
                              "https://accounts.google.com/"),
                          _buildSocialIcon(
                              context,
                              "assets/images/facebook.png",
                              'https://www.facebook.com/'),
                          _buildSocialIcon(context, "assets/images/apple.png",
                              'https://accounts.google.com/'),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center _buildButtonTitle(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Don't have an account? ",
              style: TextStyle(color: ThemeClass.greyColor, fontSize: 18),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.registerRoute);
            },
            child: Container(
              child: Text(
                "Register here",
                style: TextStyle(
                    color: ThemeClass.greenColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Align _buildForgetPasswordTitle() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: ThemeClass.greyColor,
            fontSize: 15,
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
        style: TextStyle(color: ThemeClass.greyColor, fontSize: 15),
      ),
    );
  }

  Align _buildIcon(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage(
              "assets/images/main_logo.png",
            ),
          ),
        ),
      ),
    );
  }

  _buildSocialIcon(BuildContext context, String path, String uri) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              // child: WebView(
              //   initialUrl: uri,
              //   javascriptMode: JavascriptMode.unrestricted,
              // ),
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: myBoxDecoration(path),
      ),
    );
  }

  _handleSubmitted(BuildContext context) async {
    if (this._formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      var data = LoingModel(
          username: emailController.text.toString(),
          password: passwordController.text.toString());
      try {
        var response = await HttpConfig.httpPost("auth/user/login", data);

        if (response.statusCode == 200) {
          var userData = UserModel.fromJson(jsonDecode(response.body));

          await SaveData.setUserData(userModel: userData);

          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.mainRoute, (Route<dynamic> route) => false);
          print(userData);
        } else if (response.statusCode == 401) {
          showSnackbarMessageGlobal("invalid email or password", context);
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
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  BoxDecoration myBoxDecoration(String path) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(path),
      ),
      color: Colors.white,
      borderRadius: BorderRadius.all(
          Radius.circular(15.0) //                 <--- border radius here
          ),
      border: Border.all(
          color: ThemeClass.greyColor,
          width: 1.5 //                   <--- border color
          ),
    );
  }
}
