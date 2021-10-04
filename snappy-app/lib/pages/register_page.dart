import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:photos_by_snappy/ApiManager/http_config.dart';
import 'package:photos_by_snappy/model/Register_model.dart';

import 'package:photos_by_snappy/pages/Auth/validator.dart';

import 'package:photos_by_snappy/routes.dart';
import 'package:photos_by_snappy/themeData.dart';
import 'package:photos_by_snappy/widget/common.dart';
import 'package:photos_by_snappy/widget/green_button_widget.dart';
import 'package:photos_by_snappy/widget/text_box.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String? profilepic;
  File? image;
  bool isSelected = false;
  final ImagePicker _picker = ImagePicker();
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
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.all(1),
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  titleLoginRegisterWidget("Register here."),
                  SizedBox(
                    height: 18,
                  ),
                  _subTitleLoginRegisteWidget(
                      "Create an account to create your memories with your loved ones."),
                  SizedBox(
                    height: 20,
                  ),
                  _buildProfileCircle(context),
                  _buildTextTitle("First Name"),
                  TextBoxRounded(
                      hinttext: "First Name",
                      //validator:Validators.name,
                      icon: Icons.supervised_user_circle_outlined,
                      controllers: _firstNameController),
                  _buildTextTitle("Last Name"),
                  TextBoxRounded(
                      hinttext: "Last Name",
                      validator: (value) => Validators.nameValidator(value),
                      icon: Icons.supervised_user_circle,
                      controllers: _lastNameController),
                  _buildTextTitle("Email"),
                  TextBoxRounded(
                      hinttext: "Email",
                      validator: (value) => Validators.emailValidates(value),
                      icon: Icons.email,
                      controllers: _emailController),
                  _buildTextTitle(" Password"),
                  TextBoxRounded(
                      hinttext: "Password",
                      icon: Icons.lock,
                      ispass: true,
                      // validator: (value) => Validators.passwordValidator(value),
                      validator: (value) => Validators.nameValidator(value),
                      controllers: _passwordController),
                  _buildTextTitle(" Confrom Password"),
                  TextBoxRounded(
                      hinttext: "Confrom Password",
                      icon: Icons.lock,
                      ispass: true,
                      errorText: 'enter data',
                      // validator: (value) =>
                      //     Validators.confirmPasswordValidates(value),
                      validator: (value) => Validators.nameValidator(value),
                      controllers: _confirmPasswordController),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonWidget(
                    color: ThemeClass.greenColor,
                    buttonTitle: "REGISTER",
                    onClick: () {
                      handleSubmitted(context);
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "OR",
                        style: TextStyle(
                            color: ThemeClass.greyColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _buildBottomTitle(context),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget _subTitleLoginRegisteWidget(String text) => Container(
        child: Text(
          text,
          style: ThemeClass.smallSubTitleStyleGray
              .copyWith(color: ThemeClass.greyColor.withOpacity(0.6)),
        ),
      );
  Center _buildBottomTitle(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Already have an account? ",
              style: TextStyle(
                  color: ThemeClass.greyColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.logingRoute);
            },
            child: Container(
              child: Text(
                "Login",
                style: TextStyle(
                    color: ThemeClass.greenColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
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

  Container _buildProfileCircle(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: isSelected
              ? Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          //  borderRadius: BorderRadius.circular(65.0),
                          ),
                      height: 123,
                      width: 123,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(65.0),
                        child: Image.file(
                          image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      bottom: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              color: ThemeClass.greenColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 12,
                            ),
                            onPressed: () {
                              buildBottomSheet(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 123,
                  width: 123,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new CachedNetworkImageProvider(
                          "https://picsum.photos/536/354"),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(65.0),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 15,
                        bottom: 2,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: ThemeClass.greenColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 12,
                              ),
                              onPressed: () {
                                buildBottomSheet(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(65),
              border: Border.all(color: Colors.teal.shade900)),
        ),
      ),
    );
  }

  void buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xff1DD05D),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        var pickedImage = await _picker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          image = File(pickedImage!.path);
                          isSelected = true;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "  Photo Library",
                          //textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xffF2F7FC),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        var pickedImage =
                            await _picker.pickImage(source: ImageSource.camera);
                        setState(() {
                          image = File(pickedImage!.path);
                          isSelected = true;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Add Photo",
                          //textAlign: TextAlign.left,
                          style: TextStyle(color: Color(0xff2F4858)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future handleSubmitted(BuildContext context) async {
    if (this._formKey.currentState!.validate()) {
      var filename = "";
      if (image != null) {
        filename = await HttpConfig.uploadProfilePic(image!);
      }

      var registerData = RegisterModel(
          email: _emailController.text.toString(),
          password: _passwordController.text.toString(),
          firstName: _firstNameController.text.toString(),
          lastName: _lastNameController.text.toString(),
          profilePicture: filename);

      try {
        var response = await HttpConfig.httpPost("auth/register", registerData);

        if (response.statusCode == 201) {
          Navigator.pushNamed(context, Routes.verificatonCode,
              arguments: _emailController.text);
        } else if (response.statusCode == 422) {
          showSnackbarMessageGlobal("User Already Registered", context);
        } else if (response.statusCode == 406) {
          showSnackbarMessageGlobal(
              "User Already Registered but not Verified please verify email.",
              context);

          Navigator.pushNamed(context, Routes.verificatonCode,
              arguments: _emailController.text);
        } else {
          showSnackbarMessageGlobal("Something went wong!", context);
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
}

//xyz01@gmail.com
//Abc1234@
