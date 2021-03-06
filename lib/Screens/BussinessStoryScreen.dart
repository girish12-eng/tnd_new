import 'dart:developer';
import 'dart:io';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/FollowingNewsComponent.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/Components/SocialMediaComponent.dart';
import 'package:url_launcher/url_launcher.dart';

import 'NewsBannerDetail.dart';

class BussinessStoryScreen extends StatefulWidget {
  @override
  _BussinessStoryScreenState createState() => _BussinessStoryScreenState();
}

class _BussinessStoryScreenState extends State<BussinessStoryScreen>
    with TickerProviderStateMixin {
  List subCatNews = [];
  List subCatBanner = [];
  bool isLoadingCat = true;
  bool isLoadingCatNews = true;

  @override
  void initState() {
    _bannerName();
  }

  _bannerName() async {
    String name;
    name = "Business-News";
    _newsBanner(name);
    _newsCategory(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Business Stories",
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
      ),
      body: isLoadingCat == true
          ? LoadingBlueComponent()
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        //color: Colors.grey[100],
                        border: Border.all(color: Colors.grey[200], width: 2),
                      ),
                      child: Carousel(
                        boxFit: BoxFit.contain,
                        autoplay: true,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 1500),
                        dotSize: 0.0,
                        //  borderRadius: true,
                        dotIncreasedColor: Color(0xFF9f782d),
                        dotBgColor: Colors.transparent,
                        dotPosition: DotPosition.bottomCenter,
                        dotVerticalPadding: 10.0,
                        showIndicator: false,
                        indicatorBgPadding: 7.0,
                        dotColor: Colors.grey,
                        onImageChange: (a, b) {
//                                                    log(a.toString());
//                                                    log(b.toString());
                          setState(() {
                            //skip = b;
                          });
                        },
                        images: subCatBanner.map((link) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsBannerDetail(
                                      newsData: link,
                                    ),
                                  ));
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                    // borderRadius: BorderRadius.circular(8.0),
                                    child: link['featured_img_src'] == null
                                        ? Center(
                                            child:
                                                Image.asset('assets/LOGO1.png'))
                                        : Image.network(
                                            link['featured_img_src'],
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            // height: 220,
                                            fit: BoxFit.fill,
                                          )),
                                Positioned(
                                    bottom: 0.0,
                                    child: Container(
                                      //  height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      decoration: BoxDecoration(
                                        color: Color(0xff4B4B4B4A),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            link["title"],
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.1),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
                      child: Text(
                        "    ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: appPrimaryMaterialColor),
                      ),
                    ),
                    isLoadingCatNews == true
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: LoadingBlueComponent(),
                          ))
                        : subCatNews.length <= 0
                            ? Center(child: Text("No Data Found"))
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                // scrollDirection: Axis.vertical,
                                itemCount: subCatNews.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return FollowingNewsComponent(
                                    newsData: subCatNews[index],
                                    isBookmark: subCatNews[index]["bookmark"],
                                  );
                                })
                  ],
                ),
              ),
            ),
    );
  }

  _newsBanner(var subcatName) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoadingCat = true;
        });

        FormData body = FormData.fromMap({"news_category": "${subcatName}"});
        Services.PostForList1(api_name: 'custom/slider_news', body: body).then(
            (subCatResponseList) async {
          setState(() {
            isLoadingCat = false;
          });
          if (subCatResponseList.length > 0) {
            setState(() {
              subCatBanner = subCatResponseList;

              //set "data" here to your variable
            });
            log("News Banners ${subCatBanner}");
            // for (var i = 0; i <= subCatResponseList.length; i++) {
            //   //  if (subCatResponseList[i]["trending"] == true) {
            //   setState(() {
            //     imgList.add(subCatResponseList[i]);
            //     tabController =
            //         TabController(length: imgList.length, vsync: this);
            //   });
            // }
            // }
          } else {
            setState(() {
              subCatBanner = [];
            });
            Fluttertoast.showToast(msg: "Data Not Found");
          }
        }, onError: (e) {
          setState(() {
            isLoadingCat = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _newsCategory(var subcatId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoadingCatNews = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "news_category": "${subcatId}",
          "user_id": prefs.getString(Session.CustomerId)
        });

        // print(body.fields);
        Services.PostForList1(api_name: 'custom/category_wise_news', body: body)
            .then((subCatResponseList) async {
          setState(() {
            isLoadingCatNews = false;
          });
          if (subCatResponseList.length > 0) {
            setState(() {
              subCatNews = subCatResponseList;

              //set "data" here to your variable
            });
            // for (var i = 0; i <= subCatResponseList.length; i++) {
            //   if (subCatResponseList[i]["trending"] == true) {
            //     setState(() {
            //       imgList.add(subCatResponseList[i]);
            //       tabController =
            //           TabController(length: imgList.length, vsync: this);
            //     });
            //   }
            // }
          } else {
            setState(() {
              subCatNews = [];
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isLoadingCatNews = false;
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
