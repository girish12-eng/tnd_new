import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';

class CalenderScreen extends StatefulWidget {
  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen>
    with TickerProviderStateMixin {
  bool isLoading = true;
  DateTime _selectedDay;
  Map<DateTime, List> _visibleEvents;
  List _selectedEvents = [];
  int _currentIndex = 0;
  CalendarController _calendarController;

  //=================================
//  DateTime _currentDate = DateTime(2019, 2, 3);
//  DateTime _currentDate2 = DateTime(2019, 2, 3);
//  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
//  DateTime _targetDateTime = DateTime(2019, 2, 3);

  //==========================
  DateTime _currentDate = new DateTime.now();
  DateTime _currentDate2 = new DateTime.now();
  //final now = new DateTime.now();
  //String _currentMonth = DateFormat('yMd').format(DateTime.now());
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = new DateTime.now();

  CalendarCarousel _calendarCarouselNoHeader;

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          //icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          //  icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          // icon: _eventIcon,
        ),
      ],
    },
  );
  @override
  void initState() {
    _visibleEvents = {};
    _calendarController = new CalendarController();
    _getEventData();
  }

  _getEventData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        var body = {};
        Services.PostForList(
          api_name: 'admin/getEvents',
        ).then((ResponseList) async {
          setState(() {
            isLoading = false;
          });
          Map<DateTime, List> temp = {};
          if (ResponseList.length > 0) {
            log("===========================");
            for (var i = 0; i < ResponseList.length; i++) {
              List splitData =
                  ResponseList[i]["startDate"][0].toString().split("/");
              DateTime startDate = DateTime.parse(
                  "${splitData[2]}-${splitData[1]}-${splitData[0]}");
              var splitData2 =
                  ResponseList[i]["endDate"][0].toString().split('/');
              DateTime endDate = DateTime.parse(
                  "${splitData2[2]}-${splitData2[1]}-${splitData2[0]}");

              for (DateTime j = startDate;
                  j.isBefore(endDate) || j == endDate;
                  j = j.add(Duration(days: 1))) {
                temp.addAll({
                  j: [ResponseList[i]]
                });
              }
            }
            log(temp.toString());

            setState(() {
              _visibleEvents = temp;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "No Data Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: appPrimaryMaterialColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onDaySelected(DateTime day, List events, _) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'en_US',
      events: _visibleEvents,
      //holidays: _visibleHolidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        /*CalendarFormat.twoWeeks: '2 weeks',
        CalendarFormat.week: 'Week',*/
      },
      calendarStyle: CalendarStyle(
        selectedColor: appPrimaryMaterialColor,
        todayColor: appPrimaryMaterialColor[200],
        markersColor: Colors.deepOrange,
        //markersMaxAmount: 7,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: appPrimaryMaterialColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),

      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      calendarController: _calendarController,
    );
  }

  Widget _buildEventList() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView(
        children: _selectedEvents
            .map(
              (event) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 75.0),
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 8.0),
                          height: 107,
                          //width: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  event["eventOrganiseBy"],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff4B4B4B),
                                      fontWeight: FontWeight.w600),
                                ),
//                                Text(
//                                  "Owl factory Solutions",
//                                  style: TextStyle(
//                                      fontSize: 10, color: Color(0xff4B4B4B)),
//                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  event["eventName"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  event["startTime"] + "-" + event["endTime"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: appPrimaryMaterialColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: CircleAvatar(
                          radius: 49,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              NetworkImage(Image_URL + event["eventImage"]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
//
            )
            .toList(),
      ),
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    setState(() {
      print(first);
      print(last);
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: appPrimaryMaterialColor,
      // dayButtonColor: appPrimaryMaterialColor[300],
      selectedDayBorderColor: appPrimaryMaterialColor,

      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: appPrimaryMaterialColor)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.red,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: appPrimaryMaterialColor,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.white,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      selectedDayButtonColor: appPrimaryMaterialColor,
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
          print("====================================");
          print(_currentMonth);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Calendar",
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
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, right: 18, left: 10, bottom: 8),
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
              child: Image.asset('assets/scan.png'),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
//          _buildTableCalendar(),

          Container(
            margin: EdgeInsets.only(
              top: 30.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: new Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month - 1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                ),
                Expanded(
                    child: Text(
                  _currentMonth,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                )),
                FlatButton(
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month + 1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: _calendarCarouselNoHeader,
          ),
          Expanded(child: _buildEventList()),
//
        ],
      ),
    );
  }
}
