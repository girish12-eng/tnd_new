import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/ClassList.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtSpouseName = TextEditingController();
  TextEditingController txtachievement = TextEditingController();
  TextEditingController txtCName = TextEditingController();
  TextEditingController txtChildrenCount = TextEditingController();
  TextEditingController txtExperience = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAboutBusiness = TextEditingController();
  TextEditingController txtMobileNumber = TextEditingController();
  TextEditingController txtWNumber = TextEditingController();
  TextEditingController txtGstNumber = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController linkedIn = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController youTube = TextEditingController();

  String img, userName = "";
  final _formkey = new GlobalKey<FormState>();
  bool isLoading = false;
  String Gender;
  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  String _format = 'yyyy-MMMM-dd';
  DateTime _birthDate = DateTime.now();
  DateTime _spouseBirthDate = DateTime.now();
  List<CategoryData> memberTypeList = [];
  CategoryData selectedOfferCat;
  bool isOfferLoading = false;
  String MemberTypeId, BusinessCategory;

  bool isCategoty = true;
  List<OfferClass> offerCatList = [];
  OfferClass selectedOfferCat2;

  @override
  void initState() {
    _profile();
    getCategory();
    getMemberType();
  }

  getMemberType() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.GetMemberType().then((responseList) async {
          setState(() {
            isOfferLoading = true;
          });
          if (responseList.length > 0) {
            setState(() {
              isOfferLoading = false;
              memberTypeList = responseList;
            });
          } else {
            setState(() {
              isOfferLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
          }
        }, onError: (e) {
          setState(() {
            isOfferLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  void _showBirthDate() {
    DatePicker.showDatePicker(
      context,
      dateFormat: _format,
      initialDateTime: _birthDate,
      locale: _locale,
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _birthDate = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _birthDate = dateTime;
        });
        print(_birthDate);
      },
    );
  }

  void _showSpouseDatePicker() {
    DatePicker.showDatePicker(
      context,
      dateFormat: _format,
      initialDateTime: _spouseBirthDate,
      locale: _locale,
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _spouseBirthDate = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _spouseBirthDate = dateTime;
        });
        print(_spouseBirthDate);
      },
    );
  }

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      txtName.text = prefs.getString(Session.CustomerName);
      userName = prefs.getString(Session.CustomerName);
      txtCName.text = prefs.getString(Session.CustomerCompanyName);
      txtEmail.text = prefs.getString(Session.CustomerEmailId);
      txtMobileNumber.text = prefs.getString(Session.CustomerPhoneNo);
      txtWNumber.text = prefs.getString(Session.CustomerPhoneNo);
      txtachievement.text = prefs.getString(Session.achievement);
      txtAboutBusiness.text = prefs.getString(Session.about_business);
      txtChildrenCount.text = prefs.getString(Session.number_of_child);
      txtExperience.text = prefs.getString(Session.experience);
      facebook.text = prefs.getString(Session.faceBook);
      instagram.text = prefs.getString(Session.instagram);
      youTube.text = prefs.getString(Session.youTube);
      twitter.text = prefs.getString(Session.twitter);
      linkedIn.text = prefs.getString(Session.linkedIn);
      log("======================");
//      print(img);
    });
  }

  File _Image;

  Future getFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _Image = image;
      });
    }
  }

  Future getFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _Image = image;
      });
    }
  }

  void _settingModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15, bottom: 10),
                      child: Text(
                        "Add Photo",
                        style: TextStyle(
                          fontSize: 22,
                          color: appPrimaryMaterialColor,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getFromCamera();
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 15),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "assets/camera.png",
                                color: appPrimaryMaterialColor,
                              )),
                        ),
                        title: Text(
                          "Take Photo",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Divider(),
                    ),
                    GestureDetector(
                      onTap: () {
                        getFromGallery();
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 15),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "assets/gallery.png",
                                color: appPrimaryMaterialColor,
                              )),
                        ),
                        title: Text(
                          "Choose from Gallery",
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0, bottom: 5),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 18,
                              color: appPrimaryMaterialColor,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "Update Profile",
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
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
        ),
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 30.0, bottom: 25.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _settingModalBottomSheet();
                  },
                  child:
//
                      Image != null || img != ""
                          ? _Image != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    color: appPrimaryMaterialColor,
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
                                    backgroundColor: appPrimaryMaterialColor,
                                    backgroundImage: FileImage(
                                      _Image,
                                    ),
                                  ))
                              : img != ""
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(80.0),
                                        color: appPrimaryMaterialColor,
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
//                                        backgroundImage:
//                    NetworkImage(
//                        Image_URL + "${widget.directoryData["img"]}"),
                                        /*  NetworkImage(
                                          Image_URL + img,
                                        ),*/
                                      ))
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(80.0),
                                        color: appPrimaryMaterialColor,
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
                                      ))
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.0),

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
                                backgroundColor: appPrimaryMaterialColor,
                                backgroundImage:
//                    NetworkImage(
//                        Image_URL + "${widget.directoryData["img"]}"),
                                    AssetImage(
                                  "assets/051-user.png",
                                ),
                              )),
                ),
                SizedBox(
                  height: 22,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 5, bottom: 5),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        controller: txtName,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
                        validator: (name) {
                          if (name.length == 0) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Gender",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: 'Male',
                            groupValue: Gender,
                            onChanged: (value) {
                              setState(() {
                                Gender = value;
                                print(Gender);
                              });
                            }),
                        Text("Male", style: TextStyle(fontSize: 13)),
                        Radio(
                            value: 'Female',
                            groupValue: Gender,
                            onChanged: (value) {
                              setState(() {
                                Gender = value;
                                print(Gender);
                              });
                            }),
                        Text("Female", style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Date of Birth",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showBirthDate();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
                          child: Center(
                              child: Text(
                            '${_birthDate.day}/${_birthDate.month}/${_birthDate.year}',
                            style: TextStyle(fontSize: 17),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 5, bottom: 5),
                      child: Text(
                        'Address',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        controller: txtAddress,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 5, bottom: 5),
                      child: Text(
                        'Spouse Name',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        controller: txtSpouseName,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Date of Birth",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showSpouseDatePicker();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
                          child: Center(
                              child: Text(
                            '${_spouseBirthDate.day}/${_spouseBirthDate.month}/${_spouseBirthDate.year}',
                            style: TextStyle(fontSize: 17),
                          )),
                        ),
                      ),
                    ),
/*                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Position',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        //controller: txtName,
                        controller: txtPosition,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
//                        validator: (position) {
//                          if (position.length == 0) {
//                            return 'Please enter your position';
//                          }
//                          return null;
//                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),*/
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        "Achievement",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        //controller: txtName,
                        controller: txtachievement,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'No Of Children',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        //controller: txtName,
                        controller: txtChildrenCount,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
//                        validator: (position) {
//                          if (position.length == 0) {
//                            return 'Please enter your position';
//                          }
//                          return null;
//                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Company Name',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        //controller: txtName,
                        controller: txtCName,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
                        validator: (cname) {
                          if (cname.length == 0) {
                            return 'Please enter company name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Mobile Number',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        //controller: txtName,
                        controller: txtMobileNumber,
                        keyboardType: TextInputType.phone,
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
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Whatsapp Number',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        //controller: txtName,
                        controller: txtWNumber,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
                        maxLength: 10,
                        validator: (wphone) {
                          Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                          RegExp regExp = new RegExp(pattern);
                          if (wphone.length == 0) {
                            return 'Please enter mobile number';
                          } else if (!regExp.hasMatch(wphone)) {
                            return 'Please enter valid mobile number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Container(
                        height: 42,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: TextFormField(
//                      controller: txtEmail,
                          controller: txtEmail,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 15),
                          cursorColor: Colors.black,
                          validator: (email) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            print(email);
                            if (email.isEmpty) {
                              return 'Please enter email';
                            } else {
                              if (!regex.hasMatch(email))
                                return 'Enter valid Email Address';
                              else
                                return null;
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15.0, left: 5, bottom: 5),
                      child: Text(
                        'Member Type',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 15),
                      child: Container(
                          height: 38,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: appPrimaryMaterialColor)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: DropdownButtonHideUnderline(
                              child: isOfferLoading
                                  ? LoadingBlueComponent()
                                  : DropdownButton<CategoryData>(
//                                hint: dropdownValue == null
//                                    ? Text(
//                                        "Select category",
//                                        style: TextStyle(
//                                          color: Colors.black,
//                                        ),
//                                      )
//                                    : Text(dropdownValue),
                                      dropdownColor: Colors.white,
                                      hint: Text("Select Member Type"),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        size: 40,
                                        color: Colors.black,
                                      ),
                                      isExpanded: true,
                                      value: selectedOfferCat,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedOfferCat = value;
                                          MemberTypeId = selectedOfferCat.Id;
                                        });
                                      },
                                      items: memberTypeList.map(
                                        (CategoryData category) {
                                          return DropdownMenuItem<CategoryData>(
                                            child:
                                                Text(category.memberShipName),
                                            value: category,
                                          );
                                        },
                                      ).toList(),
                                    ),
                            ),

//                          DropdownButtonHideUnderline(
//                        child: DropdownButton(
//                          hint: dropdownValue == null
//                              ? Text(
//                                  "Select category",
//                                  style: TextStyle(
//                                    color: Colors.black,
//                                  ),
//                                )
//                              : Text(dropdownValue),
//                          dropdownColor: Colors.white,
//                          icon: Icon(
//                            Icons.arrow_drop_down,
//                            size: 40,
//                            color: Colors.black,
//                          ),
//                          isExpanded: true,
//                          value: dropdownValue,
//                          items: [
//                            "Sports",
//                            "Entertainment",
//                            "Politics",
//                            "Religion"
//                          ].map((value) {
//                            return DropdownMenuItem<String>(
//                                value: value, child: Text(value));
//                          }).toList(),
//                          onChanged: (value) {
//                            setState(() {
//                              dropdownValue = value;
//                            });
//                          },
//                        ),
//                      ),
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15.0, left: 5, bottom: 5),
                      child: Text(
                        'Business Category',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 15),
                      child: Container(
                          height: 38,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: appPrimaryMaterialColor)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: DropdownButtonHideUnderline(
                              child: isCategoty
                                  ? LoadingBlueComponent()
                                  : DropdownButton<OfferClass>(
//                                hint: dropdownValue == null
//                                    ? Text(
//                                        "Select category",
//                                        style: TextStyle(
//                                          color: Colors.black,
//                                        ),
//                                      )
//                                    : Text(dropdownValue),
                                      dropdownColor: Colors.white,
                                      hint: Text("Select Business Category"),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        size: 40,
                                        color: Colors.black,
                                      ),
                                      isExpanded: true,
                                      value: selectedOfferCat2,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedOfferCat2 = value;
                                          BusinessCategory =
                                              selectedOfferCat2.offerId;
                                        });
                                      },
                                      items: offerCatList.map(
                                        (OfferClass category) {
                                          return DropdownMenuItem<OfferClass>(
                                            child: Text(category.offerName),
                                            value: category,
                                          );
                                        },
                                      ).toList(),
                                    ),
                            ),

//                          DropdownButtonHideUnderline(
//                        child: DropdownButton(
//                          hint: dropdownValue == null
//                              ? Text(
//                                  "Select category",
//                                  style: TextStyle(
//                                    color: Colors.black,
//                                  ),
//                                )
//                              : Text(dropdownValue),
//                          dropdownColor: Colors.white,
//                          icon: Icon(
//                            Icons.arrow_drop_down,
//                            size: 40,
//                            color: Colors.black,
//                          ),
//                          isExpanded: true,
//                          value: dropdownValue,
//                          items: [
//                            "Sports",
//                            "Entertainment",
//                            "Politics",
//                            "Religion"
//                          ].map((value) {
//                            return DropdownMenuItem<String>(
//                                value: value, child: Text(value));
//                          }).toList(),
//                          onChanged: (value) {
//                            setState(() {
//                              dropdownValue = value;
//                            });
//                          },
//                        ),
//                      ),
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'About Business',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        //controller: txtName,
                        controller: txtAboutBusiness,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Experience',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        //controller: txtName,
                        controller: txtExperience,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        "Social Media Links",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        height: 42,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: TextFormField(
                          //controller: txtName,
                          controller: facebook,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          decoration: InputDecoration(
                            hintText: "Facebook Link",
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        height: 42,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: TextFormField(
                          //controller: txtName,
                          controller: instagram,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        height: 42,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: TextFormField(
                          //controller: txtName,
                          controller: linkedIn,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        height: 42,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: TextFormField(
                          //controller: txtName,
                          controller: twitter,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          _updateProfile();
                        },
                        child: Container(
                          height: 42,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: appPrimaryMaterialColor[500],
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
//                          boxShadow: [
//                            BoxShadow(
//                                color: appPrimaryMaterialColor.withOpacity(0.2),
//                                blurRadius: 2.0,
//                                spreadRadius: 2.0,
//                                offset: Offset(3.0, 5.0))
//                          ]
                          ),
                          child: Center(
                              child: Text('Update Profile',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500))),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCategory() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getState().then((responseList) async {
          setState(() {
            isCategoty = true;
          });
          if (responseList.length > 0) {
            setState(() {
              isCategoty = false;
              offerCatList = responseList;
            });
          } else {
            setState(() {
              isCategoty = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
          }
        }, onError: (e) {
          setState(() {
            isCategoty = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _updateProfile() async {
    if (_formkey.currentState.validate()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          String filename = "";
          String filePath = "";
          File compressedFile;
          if (_Image != null) {
            ImageProperties properties =
                await FlutterNativeImage.getImageProperties(_Image.path);

            compressedFile = await FlutterNativeImage.compressImage(
              _Image.path,
              quality: 80,
              targetWidth: 600,
              targetHeight:
                  (properties.height * 600 / properties.width).round(),
            );

            filename = _Image.path.split('/').last;
            filePath = compressedFile.path;
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();

          FormData body = FormData.fromMap({
            "id": prefs.getString(Session.CustomerId),
            "name": txtName.text,
            "mobile": txtMobileNumber.text,
            "email": txtEmail.text,
            "company_name": txtCName.text,
            "referred_by": prefs.getString(Session.referred_by),
            "date_of_birth": _birthDate.toString().split(" ")[0],
            "gender": Gender,
            "address": txtAddress.text,
            "spouse_name": txtSpouseName.text,
            "spouse_birth_date": _spouseBirthDate.toString().split(" ")[0],
            "achievement": txtachievement.text,
            "number_of_child": txtChildrenCount.text,
            "memberOf": MemberTypeId,
            "experience": txtExperience.text,
            "about_business": txtAboutBusiness.text,
            "img": (filePath != null && filePath != '')
                ? await MultipartFile.fromFile(filePath,
                    filename: filename.toString())
                : null,
            "faceBook": facebook.text,
            "instagram": instagram.text,
            "linkedIn": linkedIn.text,
            "twitter": twitter.text,
            "youTube": youTube.text,
            "business_category": BusinessCategory
          });
          print(body.fields);
          //"key":"value"
          Services.PostForList(
                  api_name: 'api/registration/updatePersonal', body: body)
              .then((responseList) async {
            setState(() {
              isLoading = false;
            });
            if (responseList.length > 0) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                prefs.setString(Session.CustomerName, txtName.text);
                prefs.setString(Session.CustomerCompanyName, txtCName.text);
                prefs.setString(Session.CustomerEmailId, txtEmail.text);
                prefs.setString(Session.CustomerPhoneNo, txtMobileNumber.text);
                prefs.setString(Session.spouse_name, txtSpouseName.text);
                prefs.setString(Session.number_of_child, txtChildrenCount.text);
                prefs.setString(Session.about_business, txtAboutBusiness.text);
                prefs.setString(Session.experience, txtExperience.text);
                prefs.setString(Session.achievement, txtachievement.text);
                prefs.setString(Session.linkedIn, linkedIn.text);
                prefs.setString(Session.faceBook, facebook.text);
                prefs.setString(Session.youTube, youTube.text);
                prefs.setString(Session.instagram, instagram.text);
                prefs.setString(Session.twitter, twitter.text);
                prefs.setString(Session.gender, Gender);
                prefs.setString(Session.spouse_birth_date,
                    responseList[0]["spouse_birth_date"]);
                prefs.setString(Session.CustomerImage, responseList[0]["img"]);
              });
              Navigator.of(context).pushNamed('/HomeScreen');
              Fluttertoast.showToast(
                  msg: "Profile Updated Successfully",
                  gravity: ToastGravity.BOTTOM);
            }

            setState(() {
              isLoading = false;
            });
          }, onError: (e) {
            setState(() {
              isLoading = false;
            });
            print("error on call -> ${e.message}");
            Fluttertoast.showToast(msg: "Something Went Wrong");
            //showMsg("something went wrong");
          });
        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(msg: "No Internet Connection.");
      }
    } else {
      Fluttertoast.showToast(msg: "Please Fill the Field");
    }
  }
}
