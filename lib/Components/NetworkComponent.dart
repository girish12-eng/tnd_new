import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';

class NetworkComponent extends StatefulWidget {
  var networkData;
  NetworkComponent({this.networkData});
  @override
  _NetworkComponentState createState() => _NetworkComponentState();
}

class _NetworkComponentState extends State<NetworkComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 22, left: 12, right: 12),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[100], width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400].withOpacity(0.2),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: Offset(3.0, 5.0))
            ]),
        child: Row(
          children: [
            Container(
              width: 130,
              height: 210,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey[100]),
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    Image_URL + "${widget.networkData["img"]}",
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.networkData["name"]}",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        "${widget.networkData["business_category"]}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        height: 25,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: appPrimaryMaterialColor[100], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/videocall.png'),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(
                                "Open Zoom Meeting",
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.grey,
                            size: 16,
                          ),
                          Text(
                            "11 september 2020 12:40 pm",
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Container(
                              height: 30,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey[200], width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Colors.grey[600].withOpacity(0.2),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(3.0, 5.0))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5, top: 5, bottom: 5),
                                child: Image.asset('assets/forward.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Container(
                              height: 30,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey[300], width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
//                                  boxShadow: [
//                                    BoxShadow(
//                                        color:
//                                            Colors.grey[600].withOpacity(0.2),
//                                        blurRadius: 1.0,
//                                        spreadRadius: 1.0,
//                                        offset: Offset(3.0, 5.0))
//                                  ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5, top: 5, bottom: 5),
                                child: Image.asset('assets/unVideocall.png'),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.grey[300], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
//                                boxShadow: [
//                                  BoxShadow(
//                                      color: Colors.grey[600].withOpacity(0.2),
//                                      blurRadius: 1.0,
//                                      spreadRadius: 1.0,
//                                      offset: Offset(3.0, 5.0))
//                                ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 5, top: 5, bottom: 5),
                              child: Image.asset('assets/shake.png'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
