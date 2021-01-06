import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/Components/SocialMediaComponent.dart';
import 'package:the_national_dawn/Screens/UpdateProfileScreen.dart';

class MemberDetailScreen extends StatefulWidget {
  @override
  _MemberDetailScreenState createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  String memberImg = "";
  bool isEditable = false;
  bool isProfileLoading = true;
  Map<String, dynamic> profileList;

  @override
  void initState() {
    //_profile();
    _getUpdatedProfile();
  }

  var _name;
  var _comp_name;
  var _mobileNo;
  var _email;
  var img;
  var company_name;
  var business_category;
  var address;
  var about_business;
  var achievement;

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = profileList["name"];
      _comp_name = profileList["company_name"];
      _email = profileList["email"];
      img = profileList["img"];
      _mobileNo = profileList["mobile"];
      business_category = profileList["business_category"];
      address = profileList["address"];
      about_business = profileList["about_business"];
      achievement = profileList["achievement"];
    });
    /*setState(() {
      qrData =
          _name + "," + _comp_name + "," + _email + "," + img + "," + _mobileNo;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "My Profile Detail",
            style: TextStyle(
              color: appPrimaryMaterialColor,
              fontSize: 18,
              //fontWeight: FontWeight.bold
            ),
          ),
        ),
        leading: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, right: 0, left: 10, bottom: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 20,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[200], width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[600].withOpacity(0.2),
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: Offset(3.0, 5.0))
                  ]),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, right: 18, left: 10, bottom: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new UpdateProfileScreen(
                              updatedProfileData: profileList,
                            )));
                //   Navigator.of(context).pushNamed('/UpdateProfileScreen');
              },
              child: Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey[200], width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[600].withOpacity(0.2),
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          offset: Offset(3.0, 5.0))
                    ]),
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 5,
            ),
            Material(
              color: Colors.white,
              child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: new BubbleTabIndicator(
                    indicatorHeight: 43,
                    indicatorRadius: 6,
                    indicatorColor: appPrimaryMaterialColor[700],
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        'Personal',
                      ),
                    ),
                    Tab(
                      child: Text('Business'),
                    ),
                    Tab(
                      child: Text('More Info'),
                    ),
                  ]),
            ),
            Expanded(
              child: isProfileLoading == true
                  ? LoadingBlueComponent()
                  : TabBarView(
                      children: [
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 15.0,
                                bottom: 25.0),
                            child: Column(
                              children: <Widget>[
                                profileList["img"] != ""
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          color: Colors.blue,
                                          //shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 2,
                                                color: appPrimaryMaterialColor
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                offset: Offset(3, 5)),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 65,
                                          backgroundImage: profileList["img"] !=
                                                  null
                                              ? NetworkImage(profileList["img"])
                                              : AssetImage(
                                                  'assets/user2.png',
                                                ),
                                          //child: Image.asset("assets/10.jpeg",fit: BoxFit.cover,),
                                        ))
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          color: Colors.blue,
                                          //shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 2,
                                                color: appPrimaryMaterialColor
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                offset: Offset(3, 5)),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 80,
                                          backgroundColor:
                                              appPrimaryMaterialColor,
                                          backgroundImage: AssetImage(
                                            "assets/051-user.png",
                                          ),
                                          //child: Image.asset("assets/10.jpeg",fit: BoxFit.cover,),
                                        )),
                                SizedBox(
                                  height: 22,
                                ),
                                Container(
                                  height: 131,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: appPrimaryMaterialColor[50],
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(22.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: appPrimaryMaterialColor
                                                .withOpacity(0.2),
                                            blurRadius: 2.0,
                                            spreadRadius: 2.0,
                                            offset: Offset(3.0, 5.0))
                                      ]),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            // "Mr. Natasha Goel",
                                            "${profileList["name"]}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text("Manager",
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        Flexible(
                                          child: Text(
//                                          "Future Group Info Soft",
                                              "${profileList["company_name"]}",
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  height: 133,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: appPrimaryMaterialColor[50],
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(22.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: appPrimaryMaterialColor
                                                .withOpacity(0.2),
                                            blurRadius: 2.0,
                                            spreadRadius: 2.0,
                                            offset: Offset(3.0, 5.0))
                                      ]),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 24, top: 4, bottom: 4),
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Icon(
                                                Icons.phone,
                                                color: Color(0xff16B8FF),
                                                size: 22,
                                              ),
                                              Image.asset(
                                                  "assets/whatsapp.png"),
                                              Icon(
                                                Icons.email,
                                                color: Colors.redAccent,
                                                size: 22,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
//                                              "+91-8488848476",
                                                    "${profileList["mobile"]}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 1),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
//                                                "+91-9723131314",
                                                      "${profileList["whatsApp"]}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Flexible(
                                                  child: Text(
//                                                "xsantosh7@gmail.com",
                                                      "${profileList["email"]}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                /* SizedBox(
                height: 18,
              ),
              Container(
                height: 42,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[500], width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                  BoxShadow(
                    color: appPrimaryMaterialColor.withOpacity(0.2),
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                    offset: Offset(3.0, 5.0))
                    ]),
                child: Center(
                    child: Text(
                  "Share QR to scan",
                  style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  fontSize: 21),
                )),
              ),*/
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Container(
                                    height: 250,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: appPrimaryMaterialColor[50],
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(22.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: appPrimaryMaterialColor
                                                  .withOpacity(0.2),
                                              blurRadius: 2.0,
                                              spreadRadius: 2.0,
                                              offset: Offset(3.0, 5.0))
                                        ]),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.business,
                                                  color:
                                                      appPrimaryMaterialColor,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    'Business Info',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0, top: 12),
                                                child: Text(
                                                  // "Mr. Natasha Goel",
                                                  "Company Name  : ",
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, top: 12),
                                                  child: Text(
                                                    // "Mr. Natasha Goel",
                                                    "${profileList["company_name"] ?? "-"}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0),
                                                child: Text(
                                                  // "Mr. Natasha Goel",
                                                  "About Bussiness  : ",
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                      "${profileList["about_business"] ?? "-"}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0),
                                                child: Text(
                                                  // "Mr. Natasha Goel",
                                                  "Business Category  : ",
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                      "${business_category ?? "-"}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0),
                                                child: Text(
                                                  // "Mr. Natasha Goel",
                                                  "Address : ",
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
//                                          "Future Group Info Soft",
                                                      "${profileList["address"] ?? "-"}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Container(
                                    height: 250,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: appPrimaryMaterialColor[50],
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(22.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: appPrimaryMaterialColor
                                                  .withOpacity(0.2),
                                              blurRadius: 2.0,
                                              spreadRadius: 2.0,
                                              offset: Offset(3.0, 5.0))
                                        ]),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.info,
                                                  color:
                                                      appPrimaryMaterialColor,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    'More Info',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0, top: 12),
                                                child: Text(
                                                  // "Mr. Natasha Goel",
                                                  "Achievement  : ",
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, top: 12),
                                                  child: Text(
                                                    // "Mr. Natasha Goel",
                                                    "${profileList["achievement"] ?? "-"}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, top: 8),
                                            child: Text(
                                              "Social Media : ",
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                left: 8.0,
                                                right: 8,
                                                bottom: 30),
                                            child: Container(
                                              height: 55,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          appPrimaryMaterialColor[
                                                              50],
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              22.0))),
                                              child: SocialMediaComponent(
                                                facebook:
                                                    profileList["faceBook"],
                                                instagram:
                                                    profileList["instagram"],
                                                linkedIn:
                                                    profileList["linkedIn"],
                                                twitter: profileList["twitter"],
                                                whatsapp:
                                                    profileList["whatsApp"],
                                                youtube: profileList["youTube"],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _getUpdatedProfile() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var body = {
          "id": prefs.getString(Session.CustomerId),
        };
        Services.PostForList(api_name: 'admin/getsingleid', body: body).then(
            (ResponseList) async {
          setState(() {
            isProfileLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              profileList = ResponseList[0];
              //set "data" here to your variable
            });
          } else {
            setState(() {
              isProfileLoading = false;
            });
            Fluttertoast.showToast(msg: "Product Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isProfileLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }
}
