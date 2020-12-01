import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Screens/VerificationScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtMobileNumber = TextEditingController();
  final _formkey = new GlobalKey<FormState>();
  bool isLoading = false;

  saveDataToSession(var data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Session.CustomerId, data["_id"].toString());
    await prefs.setString(Session.CustomerName, data["name"]);
    await prefs.setString(Session.referred_by, data["referred_by"]);
    await prefs.setString(Session.CustomerCompanyName, data["company_name"]);
    await prefs.setString(Session.CustomerEmailId, data["email"]);
    await prefs.setString(Session.CustomerPhoneNo, data["mobile"]);

    Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (route) => false);
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text(
            "You are not register...",
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Ok",
                style: TextStyle(color: appPrimaryMaterialColor),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/RegisterScreen');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 20,
              ),
              Image.asset("assets/splash.png"),
              SizedBox(
                height: MediaQuery.of(context).padding.top + 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: txtMobileNumber,
                  style: TextStyle(fontSize: 15),
                  cursorColor: appPrimaryMaterialColor,
                  maxLength: 10,
                  validator: (phone) {
                    Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                    RegExp regExp = new RegExp(pattern);
                    if (phone.length == 0) {
                      return 'Please enter mobile number';
                    } else if (!regExp.hasMatch(phone)) {
                      return 'Please enter valid mobile number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding:
                        EdgeInsets.only(top: 1.0, bottom: 1, left: 1, right: 1),
                    hintText: "Enter your mobile",
                    hintStyle: TextStyle(
                        color: Colors.grey[400], fontWeight: FontWeight.w500),
                    prefixIcon: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15, left: 15, right: 25),
                        child: Image.asset("assets/mobile.png"),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: appPrimaryMaterialColor[400]),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: appPrimaryMaterialColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: RaisedButton(
                      color: appPrimaryMaterialColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () {
                        if (isLoading == false) _login();
                      },
                      child: isLoading == true
                          ? CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            )
                          : Text("SIGN IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                      child: Text(
                        "forgot password",
                        style: TextStyle(
                            color: appPrimaryMaterialColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/RegisterScreen');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _login() async {
    if (_formkey.currentState.validate()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          var body = {"mobile": txtMobileNumber.text};
          print(body);
          Services.Login(body).then((responselist) async {
            if (responselist.length > 0) {
              setState(() {
                isLoading = false;
              });
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VerificationScreen(
                        mobile: txtMobileNumber.text,
                        logindata: responselist[0],
                        onLoginSuccess: () {
                          saveDataToSession(responselist[0]);
                        },
                      )));
            } else {
              setState(() {
                isLoading = false;
              });
              _showDialog(context);
            }
          }, onError: (e) {
            setState(() {
              isLoading = false;
            });
            print("error on call -> ${e.message}");
            Fluttertoast.showToast(msg: "something went wrong");
          });
        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(msg: "No Internet Connection");
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill mobile number");
    }
  }
}
