import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:uahage/src/Binding/place.restaurant.bookmark.binding.dart';
import 'package:uahage/src/Controller/place.restaurant.bookmark.controller.dart';
import 'package:uahage/src/Controller/user.controller.dart';
import 'package:uahage/src/Model/craftRooms.dart';
import 'package:uahage/src/Model/dayCareCenter.dart';
import 'package:uahage/src/Model/experienceCenter.dart';
import 'package:uahage/src/Model/hospitals.dart';
import 'package:uahage/src/Model/kidCafe.dart';
import 'package:uahage/src/Model/restaurant.dart';

import 'package:uahage/src/Service/places.restaurant.bookmarks.dart';
import 'package:uahage/src/Service/report.dart';
import 'package:uahage/src/Service/review.dart';
import 'package:uahage/src/Static/Font/font.dart';
import 'package:uahage/src/Static/Widget/dialog.dart';
import 'icon.dart';

class pop extends StatefulWidget {
  @override
  _popState createState() => _popState();
}

class _popState extends State<pop> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<Object> x_popup(context, grey_image) {
  return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return StatefulBuilder(builder: (context, setState) {
          return SafeArea(
            child: Builder(builder: (context) {
              return Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 600.h * 0.93,
                        bottom: 0.h * 0.93,
                        left: 190.w * 0.78,
                        right: 0.w * 0.78),
                    width: 1100.w * 0.78,
                    height: 1060.h * 0.93,
                    child: Card(
                      shadowColor: Colors.black54,
                      elevation: 1,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 85.h * 0.93,
                            left: 50.w * 0.78,
                            right: 50.w * 0.78),
                        child: SizedBox(
                          child: GridView.count(
                            crossAxisCount: 3,
                            children: List.generate(9, (index) {
                              return Scaffold(
                                backgroundColor: Colors.white,
                                body: Center(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (grey_image[index] == 1)
                                          grey_image[index] = 0;
                                        else
                                          grey_image[index] = 1;
                                      });
                                      print(grey_image);
                                    },
                                    child: grey_image[index] == 0
                                        ? Image.asset(
                                            "./assets/searchPage/image" +
                                                (index + 1).toString() +
                                                "_grey.png",
                                            height: 293.h * 0.93,
                                            width: 218.w * 0.78,
                                          )
                                        : Image.asset(
                                            "./assets/searchPage/image" +
                                                (index + 1).toString() +
                                                ".png",
                                            height: 293.h * 0.93,
                                            width: 218.w * 0.78,
                                          ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 1850.h * 0.93,
                    left: 400.w * 0.78,
                    right: 400.w * 0.78,
                    child: SizedBox(
                      width: 611.w * 0.78,
                      height: 195.h * 0.93,
                      child: FlatButton(
                        onPressed: () async {
                          Navigator.pop(context, grey_image);
                          grey_image = [
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                          ];
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        color: Color.fromRGBO(255, 114, 148, 1.0),
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NotoSansCJKkr_Medium',
                            fontSize: 60.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        });
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: null,
      transitionDuration: const Duration(milliseconds: 150));
}

Future<Object> x_placepopup(context, Message, type, placeCode) async {
  var restaurantListImage = [
    "https://uahage.s3.ap-northeast-2.amazonaws.com/restaurant_image/image1.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/restaurant_image/image2.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/restaurant_image/image3.png",
  ];
  var hospitalListImage = [
    "https://uahage.s3.ap-northeast-2.amazonaws.com/hospital_image/image1.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/hospital_image/image2.png",
  ];
  var kidsCafeListImage = [
    "https://uahage.s3.ap-northeast-2.amazonaws.com/kids_cafe/image1.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/kids_cafe/image2.png",
  ];
  var experienceListImage = [
    "https://uahage.s3.ap-northeast-2.amazonaws.com/experience_/image1.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/experience_/image2.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/experience_/image3.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/experience_/image4.png",
  ];
  print(Message["name"]);
  int mark;
  var total = Message["total"];
  if (placeCode == 1) {
    mark = Message["bookmark"];
  }
  var width = 1500 / 720;
  var height = 2667 / 1280;

  Bookmark bookmark = new Bookmark();
  return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return StatefulBuilder(builder: (context, setState) {
          return Builder(builder: (context) {
            return Stack(
              children: [
                GestureDetector(
                  onPanDown: (a) {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    height: type == 'search' ? 1874.h * 0.93 : 1800.h * 0.93,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: type == 'search' ? 1900.h * 0.93 : 1800.h * 0.93,
                      bottom: type == 'search' ? 263.h * 0.93 : 330.h * 0.93,
                      left: 33.w * 0.78,
                      right: 33.w * 0.78),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shadowColor: Colors.black54,
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: () async {
                        print(Message);
                        var message;
                        if (placeCode == 1) {
                          message = Restaurant.fromJson(Message);
                          message.bookmark = mark;
                        } else if (placeCode == 2) {
                          message = Hospitals.fromJson(Message);
                        } else if (placeCode == 3) {
                          message = DayCareCenter.fromJson(Message);
                        } else if (placeCode == 5) {
                          message = KidCafe.fromJson(Message);
                        } else if (placeCode == 6) {
                          message = Experiencecenter.fromJson(Message);
                        } else if (placeCode == 8) {
                          message = CraftRooms.fromJson(Message);
                        }

                        var result = await Get.offNamed("/listsub", arguments: {
                          "data": message,
                          "placeCode": placeCode,
                          "index": 1,
                        });
                        //print("result ${result}");
                        // setState(() {
                        //   mark = result[0];
                        //   total = result[1];
                        // });
                      },
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                            left: 30.w * 0.78,
                          )),
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    (() {
                                      if (placeCode == 1) {
                                        return restaurantListImage[0];
                                      } else if (placeCode == 2) {
                                        return hospitalListImage[0];
                                      } else if (placeCode == 3) {
                                        return experienceListImage[0];
                                      } else if (placeCode == 5) {
                                        return kidsCafeListImage[0];
                                      } else if (placeCode == 6) {
                                        return experienceListImage[0];
                                      } else if (placeCode == 8) {
                                        if (Message["image_path"] == null) {
                                          return experienceListImage[0];
                                        } else {
                                          return Message["image_path"][0];
                                        }
                                      } else {
                                        return restaurantListImage[0];
                                      }
                                    }()),
                                    scale: 0.1,
                                  ),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            height: 413.w * 0.78,
                            width: 413.w * 0.78,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                            left: 53.w * 0.78,
                          )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 55.h * 0.93),
                                height: 92.h * 0.93,
                                child: Row(
                                  children: [
                                    Container(
                                        width: 700.w * 0.78,
                                        child: boldfont(
                                            Message["name"].length <= 10
                                                ? '${Message["name"]}'
                                                : '${Message["name"].substring(0, 11)}...',
                                            50,
                                            Color(0xff010000))),
                                    (() {
                                      if (placeCode == 1) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              // left: 8.w * 0.78,
                                              ),
                                          child: InkWell(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 30.w * 0.78,
                                                  right: 30.w * 0.78,
                                                  bottom: 10.h * 0.93),
                                              child: Image.asset(
                                                mark == 0 || mark == null
                                                    ? "./assets/listPage/love_grey.png"
                                                    : "./assets/listPage/love_color.png",
                                                height: 50.h * 0.93,
                                              ),
                                            ),
                                            onTap: () async {
                                              if (mark == 0 || mark == null) {
                                                await bookmark.bookmarkToogle(
                                                    UserController
                                                        .to.userId.value,
                                                    Message["id"]);

                                                setState(() {
                                                  mark = 1;
                                                });
                                              } else {
                                                await bookmark.bookmarkToogle(
                                                    UserController
                                                        .to.userId.value,
                                                    Message["id"]);
                                                // BookmarkController.to
                                                //     .starPlaceBookmarkrefresh(
                                                //         Message["index"]);
                                                setState(() {
                                                  mark = 0;
                                                });
                                              }
                                            },
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }())
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 10  width.w0.78),
                              // ),

                              placeCode == 1
                                  ? Row(
                                      children: [
                                        Image.asset(
                                          "./assets/listPage/star_color.png",
                                          width: 30 * width.w * 0.78,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 4.7 * width.w * 0.78),
                                        ),
                                        normalfont(total ?? "0.0", 46,
                                            Color(0xff4d4d4d))
                                      ],
                                    )
                                  : Container(),
                              placeCode == 1
                                  ? Container(
                                      margin: EdgeInsets.only(top: 10.h * 0.93),
                                      child: Message["address"].length > 18
                                          ? normalfont(
                                              '${Message["address"].substring(0, 18)}...',
                                              46,
                                              Color(0xffb0b0b0))
                                          : normalfont('${Message["address"]}',
                                              46, Color(0xffb0b0b0)),
                                    )
                                  : Container(
                                      width: 750.w * 0.78,
                                      margin: EdgeInsets.only(top: 10.h * 0.93),
                                      child: Message["address"].length > 32
                                          ? normalfont(
                                              '${Message["address"].substring(0, 32)}...',
                                              46,
                                              Color(0xffb0b0b0))
                                          : normalfont(Message["address"], 46,
                                              Color(0xffb0b0b0)),
                                    ),
                              Container(
                                margin: EdgeInsets.only(top: 15.h * 0.93),
                                alignment: Alignment.bottomRight,
                                child: Row(children: [
                                  icon(
                                      context,
                                      Message["baby_menu"],
                                      Message["stroller"],
                                      Message["baby_bed"],
                                      Message["baby_tableware"],
                                      Message["nursing_room"],
                                      Message["meeting_room"],
                                      Message["diaper_change"],
                                      Message["play_room"],
                                      Message["baby_chair"]

                                      // PlaceController
                                      //     .to.place[index].parking
                                      //     .toString())
                                      ),
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        });
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: null,
      transitionDuration: const Duration(milliseconds: 150));
}

Future<Object> popup(context, grey_image) {
  return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return StatefulBuilder(builder: (context, setState) {
          return SafeArea(
            child: Builder(builder: (context) {
              return Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 450.h * 0.62 * 0.93,
                        bottom: 0.h * 0.62 * 0.93,
                        left: 190.w * 0.7 * 0.78,
                        right: 0.w * 0.7 * 0.78),
                    width: 1100.w * 0.7 * 0.78,
                    height: 1060.h * 0.62 * 0.93,
                    child: Card(
                      shadowColor: Colors.black54,
                      elevation: 1,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 85.h * 0.62 * 0.93,
                            left: 50.w * 0.7 * 0.78,
                            right: 50.w * 0.7 * 0.78),
                        child: SizedBox(
                          child: GridView.count(
                            crossAxisCount: 3,
                            children: List.generate(9, (index) {
                              return Scaffold(
                                backgroundColor: Colors.white,
                                body: Center(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (grey_image[index] == 1)
                                          grey_image[index] = 0;
                                        else
                                          grey_image[index] = 1;
                                      });
                                      print(grey_image);
                                    },
                                    child: grey_image[index] == 0
                                        ? Image.asset(
                                            "./assets/searchPage/image" +
                                                (index + 1).toString() +
                                                "_grey.png",
                                            height: 293.h * 0.62 * 0.93,
                                            width: 218.w * 0.7 * 0.78,
                                          )
                                        : Image.asset(
                                            "./assets/searchPage/image" +
                                                (index + 1).toString() +
                                                ".png",
                                            height: 293.h * 0.62 * 0.93,
                                            width: 218.w * 0.7 * 0.78,
                                          ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 1600.h * 0.62 * 0.93,
                    left: 400.w * 0.7 * 0.78,
                    right: 400.w * 0.7 * 0.78,
                    child: SizedBox(
                      width: 611.w * 0.7 * 0.78,
                      height: 195.h * 0.62 * 0.93,
                      child: FlatButton(
                        onPressed: () async {
                          Navigator.pop(context, grey_image);
                          grey_image = [
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                          ];
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        color: Color.fromRGBO(255, 114, 148, 1.0),
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NotoSansCJKkr_Medium',
                            fontSize: 30.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        });
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: null,
      transitionDuration: const Duration(milliseconds: 150));
}

Future<Object> placepopup(context, Message, type, placeCode) async {
  var restaurantListImage = [
    "https://uahage.s3.ap-northeast-2.amazonaws.com/restaurant_image/image1.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/restaurant_image/image2.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/restaurant_image/image3.png",
  ];
  var hospitalListImage = [
    "https://uahage.s3.ap-northeast-2.amazonaws.com/hospital_image/image1.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/hospital_image/image2.png",
  ];
  var kidsCafeListImage = [
    "https://uahage.s3.ap-northeast-2.amazonaws.com/kids_cafe/image1.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/kids_cafe/image2.png",
  ];
  var experienceListImage = [
    "https://uahage.s3.ap-northeast-2.amazonaws.com/experience_/image1.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/experience_/image2.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/experience_/image3.png",
    "https://uahage.s3.ap-northeast-2.amazonaws.com/experience_/image4.png",
  ];
  print(Message["name"]);
  int mark;
  var total = Message["total"];
  if (placeCode == 1) {
    mark = Message["bookmark"];
  }
  var width = 1500 / 720;
  var height = 2667 / 1280;

  Bookmark bookmark = new Bookmark();
  return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return StatefulBuilder(builder: (context, setState) {
          return Builder(builder: (context) {
            return Stack(
              children: [
                GestureDetector(
                  onPanDown: (a) {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    height: type == 'search'
                        ? 1874.h * 0.62 * 0.93
                        : 1800.h * 0.62 * 0.93,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: type == 'search'
                          ? 1700.h * 0.62 * 0.93
                          : 1650.h * 0.62 * 0.93,
                      bottom: type == 'search'
                          ? 250.h * 0.62 * 0.93
                          : 250.h * 0.62 * 0.93,
                      left: 33.w * 0.7 * 0.78,
                      right: 33.w * 0.7 * 0.78),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shadowColor: Colors.black54,
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: () async {
                        print(Message);
                        var message;
                        if (placeCode == 1) {
                          message = Restaurant.fromJson(Message);
                          message.bookmark = mark;
                        } else if (placeCode == 2) {
                          message = Hospitals.fromJson(Message);
                        } else if (placeCode == 3) {
                          message = DayCareCenter.fromJson(Message);
                        } else if (placeCode == 5) {
                          message = KidCafe.fromJson(Message);
                        } else if (placeCode == 6) {
                          message = Experiencecenter.fromJson(Message);
                        } else if (placeCode == 8) {
                          message = CraftRooms.fromJson(Message);
                        }

                        var result = await Get.offNamed("/listsub", arguments: {
                          "data": message,
                          "placeCode": placeCode,
                          "index": 1,
                        });
                        //print("result ${result}");
                        // setState(() {
                        //   mark = result[0];
                        //   total = result[1];
                        // });
                      },
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                            left: 30.w * 0.7 * 0.78,
                          )),
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    (() {
                                      if (placeCode == 1) {
                                        return restaurantListImage[0];
                                      } else if (placeCode == 2) {
                                        return hospitalListImage[0];
                                      } else if (placeCode == 3) {
                                        return experienceListImage[0];
                                      } else if (placeCode == 5) {
                                        return kidsCafeListImage[0];
                                      } else if (placeCode == 6) {
                                        return experienceListImage[0];
                                      } else if (placeCode == 8) {
                                        if (Message["image_path"] == null) {
                                          return experienceListImage[0];
                                        } else {
                                          return Message["image_path"][0];
                                        }
                                      } else {
                                        return restaurantListImage[0];
                                      }
                                    }()),
                                    scale: 0.1,
                                  ),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            height: 413.w * 0.7 * 0.78,
                            width: 413.w * 0.7 * 0.78,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                            left: 53.w * 0.7 * 0.78,
                          )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(top: 55.h * 0.62 * 0.93),
                                height: 92.h * 0.62 * 0.93,
                                child: Row(
                                  children: [
                                    Container(
                                        width: 700.w * 0.7 * 0.78,
                                        child: boldfont(
                                            Message["name"].length <= 10
                                                ? '${Message["name"]}'
                                                : '${Message["name"].substring(0, 11)}...',
                                            35,
                                            Color(0xff010000))),
                                    (() {
                                      if (placeCode == 1) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              // left: 8.w*0.7 * 0.78,
                                              ),
                                          child: InkWell(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 30.w * 0.7 * 0.78,
                                                  right: 30.w * 0.7 * 0.78,
                                                  bottom: 10.h * 0.62 * 0.93),
                                              child: Image.asset(
                                                mark == 0 || mark == null
                                                    ? "./assets/listPage/love_grey.png"
                                                    : "./assets/listPage/love_color.png",
                                                height: 50.h * 0.62 * 0.93,
                                              ),
                                            ),
                                            onTap: () async {
                                              if (mark == 0 || mark == null) {
                                                await bookmark.bookmarkToogle(
                                                    UserController
                                                        .to.userId.value,
                                                    Message["id"]);

                                                setState(() {
                                                  mark = 1;
                                                });
                                              } else {
                                                await bookmark.bookmarkToogle(
                                                    UserController
                                                        .to.userId.value,
                                                    Message["id"]);
                                                // BookmarkController.to
                                                //     .starPlaceBookmarkrefresh(
                                                //         Message["index"]);
                                                setState(() {
                                                  mark = 0;
                                                });
                                              }
                                            },
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }())
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 10 * width.w*0.7*0.78),
                              // ),

                              placeCode == 1
                                  ? Row(
                                      children: [
                                        Image.asset(
                                          "./assets/listPage/star_color.png",
                                          width: 30 * width.w * 0.7 * 0.78,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 4.7 * width.w * 0.7 * 0.78),
                                        ),
                                        normalfont(total ?? "0.0", 30,
                                            Color(0xff4d4d4d))
                                      ],
                                    )
                                  : Container(),
                              placeCode == 1
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: 10.h * 0.62 * 0.93),
                                      child: Message["address"].length > 18
                                          ? normalfont(
                                              '${Message["address"].substring(0, 18)}...',
                                              30,
                                              Color(0xffb0b0b0))
                                          : normalfont('${Message["address"]}',
                                              30, Color(0xffb0b0b0)),
                                    )
                                  : Container(
                                      width: 750.w * 0.7 * 0.78,
                                      margin: EdgeInsets.only(
                                          top: 10.h * 0.62 * 0.93),
                                      child: Message["address"].length > 32
                                          ? normalfont(
                                              '${Message["address"].substring(0, 32)}...',
                                              46,
                                              Color(0xffb0b0b0))
                                          : normalfont(Message["address"], 46,
                                              Color(0xffb0b0b0)),
                                    ),
                              Container(
                                margin:
                                    EdgeInsets.only(top: 15.h * 0.62 * 0.93),
                                alignment: Alignment.bottomRight,
                                child: Row(children: [
                                  icon(
                                      context,
                                      Message["baby_menu"],
                                      Message["stroller"],
                                      Message["baby_bed"],
                                      Message["baby_tableware"],
                                      Message["nursing_room"],
                                      Message["meeting_room"],
                                      Message["diaper_change"],
                                      Message["play_room"],
                                      Message["baby_chair"]

                                      // PlaceController
                                      //     .to.place[index].parking
                                      //     .toString())
                                      ),
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        });
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: null,
      transitionDuration: const Duration(milliseconds: 150));
}

class Report extends StatefulWidget {
  List reportIndex = [false, false, false, false, false, false];

  var width = 1500 / 720;
  var height = 2667 / 1280;

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

report(context, reviewId) {
  print("report");
  List reportIndex = [false, false, false, false, false, false];
  var width = 1500 / 720;
  var height = 2667 / 1280;
  bool isreport = false;
  final myController = TextEditingController();
  bool btnColor = false;
  return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return StatefulBuilder(builder: (context, setState) {
          return SafeArea(
            child: Builder(builder: (context) {
              return Container(
                color: Colors.black54,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 231 * height.h * 0.62 * 0.93,
                          bottom: 0.h * 0.62 * 0.93,
                          left: 85 * width.w * 0.7 * 0.78,
                          right: 0.w * 0.7 * 0.78),
                      width: 550 * width.w * 0.7 * 0.78,
                      height: 736 * height.h * 0.62 * 0.93,
                      child: Card(
                        shadowColor: Colors.black54,
                        elevation: 1,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                            margin: EdgeInsets.only(
                              top: 30 * height.h * 0.62 * 0.93,
                              left: 33 * width.w * 0.7 * 0.78,
                              right: 33 * width.w * 0.7 * 0.78,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        width: 420 * width.w * 0.7 * 0.78,
                                        child:
                                            boldfont("신고유형", 68, Colors.black)),
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Image.asset(
                                        "./assets/sublistPage/cancel.png",
                                        width: 26 * width.w * 0.7 * 0.78,
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 37 * height.h * 0.62 * 0.93)),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          reportIndex[0] = !reportIndex[0];
                                          isreport = false;
                                          for (int i = 0;
                                              i < reportIndex.length;
                                              i++) {
                                            if (reportIndex[i]) {
                                              isreport = true;
                                            }
                                          }
                                        });
                                      },
                                      child: reportIndex[0]
                                          ? Image.asset(
                                              "./assets/sublistPage/check.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            )
                                          : Image.asset(
                                              "./assets/sublistPage/uncheck.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: 7 * width.w * 0.7 * 0.78)),
                                    Container(
                                      width: 206 * width.w * 0.7 * 0.78,
                                      child: normalfont(
                                          "영리목적/홍보성", 58, Color(0xff666666)),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          reportIndex[1] = !reportIndex[1];
                                          isreport = false;
                                          for (int i = 0;
                                              i < reportIndex.length;
                                              i++) {
                                            if (reportIndex[i]) {
                                              isreport = true;
                                            }
                                          }
                                        });
                                      },
                                      child: reportIndex[1]
                                          ? Image.asset(
                                              "./assets/sublistPage/check.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            )
                                          : Image.asset(
                                              "./assets/sublistPage/uncheck.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: 7 * width.w * 0.7 * 0.78)),
                                    normalfont("기능작동오류", 58, Color(0xff666666)),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 47 * height.h * 0.62 * 0.93)),

                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          reportIndex[2] = !reportIndex[2];
                                          isreport = false;
                                          for (int i = 0;
                                              i < reportIndex.length;
                                              i++) {
                                            if (reportIndex[i]) {
                                              isreport = true;
                                            }
                                          }
                                        });
                                      },
                                      child: reportIndex[2]
                                          ? Image.asset(
                                              "./assets/sublistPage/check.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            )
                                          : Image.asset(
                                              "./assets/sublistPage/uncheck.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: 7 * width.w * 0.7 * 0.78)),
                                    Container(
                                      width: 206 * width.w * 0.7 * 0.78,
                                      child: normalfont(
                                          "음란성/선전성", 58, Color(0xff666666)),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          reportIndex[3] = !reportIndex[3];
                                          isreport = false;
                                          for (int i = 0;
                                              i < reportIndex.length;
                                              i++) {
                                            if (reportIndex[i]) {
                                              isreport = true;
                                            }
                                          }
                                        });
                                      },
                                      child: reportIndex[3]
                                          ? Image.asset(
                                              "./assets/sublistPage/check.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            )
                                          : Image.asset(
                                              "./assets/sublistPage/uncheck.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: 7 * width.w * 0.7 * 0.78)),
                                    normalfont(
                                        "욕설/인신공격", 58, Color(0xff666666)),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 47 * height.h * 0.62 * 0.93)),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          reportIndex[4] = !reportIndex[4];
                                          isreport = false;
                                          for (int i = 0;
                                              i < reportIndex.length;
                                              i++) {
                                            if (reportIndex[i]) {
                                              isreport = true;
                                            }
                                          }
                                        });
                                      },
                                      child: reportIndex[4]
                                          ? Image.asset(
                                              "./assets/sublistPage/check.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            )
                                          : Image.asset(
                                              "./assets/sublistPage/uncheck.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: 7 * width.w * 0.7 * 0.78)),
                                    Container(
                                      width: 206 * width.w * 0.7 * 0.78,
                                      child: normalfont(
                                          "개인정보노출", 58, Color(0xff666666)),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          reportIndex[5] = !reportIndex[5];
                                          isreport = false;
                                          for (int i = 0;
                                              i < reportIndex.length;
                                              i++) {
                                            if (reportIndex[i]) {
                                              isreport = true;
                                            }
                                          }
                                        });
                                      },
                                      child: reportIndex[5]
                                          ? Image.asset(
                                              "./assets/sublistPage/check.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            )
                                          : Image.asset(
                                              "./assets/sublistPage/uncheck.png",
                                              width: 32 * width.w * 0.7 * 0.78,
                                            ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: 7 * width.w * 0.7 * 0.78)),
                                    normalfont("반복 게시", 58, Color(0xff666666)),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 49 * height.h * 0.62 * 0.93)),
                                // Text input
                                Container(
                                  width: double.infinity,
                                  height: 330 * width.w * 0.7 * 0.78,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 114, 142, 0.05),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                      color: Color.fromRGBO(255, 114, 142, 0.4),
                                    ),
                                  ),
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(bottom: 10, right: 5),
                                    child: TextFormField(
                                      onChanged: (e) {
                                        if (myController.text.length >= 10) {
                                          setState(() {
                                            btnColor = true;
                                          });
                                        } else {
                                          if (btnColor)
                                            setState(() {
                                              btnColor = false;
                                            });
                                        }
                                      },
                                      controller: myController,
                                      //  textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 114, 142, 0.6)),
                                      maxLines: 20,
                                      maxLength: 100,
                                      cursorColor:
                                          Color.fromRGBO(255, 114, 142, 0.6),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintText: "신고하실 내용을 설명해주세요",
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 114, 142, 0.6)),
                                        counterStyle: TextStyle(
                                            fontSize: 50.sp,
                                            color: Color.fromRGBO(
                                                255, 114, 142, 0.6),
                                            fontFamily: "NotoSansCJKkr_Medium"),
                                        contentPadding: EdgeInsets.only(
                                            top: 20.sp,
                                            right: 19.sp,
                                            left: 15.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    Positioned(
                      top: 1000 * height.h * 0.62 * 0.93,
                      left: 117 * width.w * 0.7 * 0.78,
                      right: 117 * width.w * 0.7 * 0.78,
                      child: SizedBox(
                        width: 488 * width.w * 0.7 * 0.78,
                        height: 96 * height.h * 0.62 * 0.93,
                        child: FlatButton(
                          onPressed: () async {
                            if (myController.text.length > 10 && isreport) {
                              bool result = await reviewReport(
                                  reportIndex, reviewId, myController.text);
                              if (result) {
                                await dialog(context, "신고가 완료되었습니다");
                                Get.back();
                              }
                            } else {
                              isreport
                                  ? await dialog(context, "10글자 이상 작성해 주세요.")
                                  : await dialog(context, "신고유형을 선택해 주세요");
                            }
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          color: (() {
                            return myController.text.length > 10 && isreport
                                ? Color.fromRGBO(255, 114, 148, 1.0)
                                : Color.fromRGBO(212, 212, 212, 1.0);
                          }()),
                          child: Text(
                            "완료",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NotoSansCJKkr_Medium',
                              fontSize: 60.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        });
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: null,
      transitionDuration: const Duration(milliseconds: 150));
}
