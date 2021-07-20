import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uahage/src/Controller/connection.controller.dart';
import 'package:uahage/src/Controller/place.controller.dart';
import 'package:uahage/src/Controller/user.controller.dart';
import 'package:uahage/src/Service/connection.dart';
import 'package:uahage/src/Service/places.restaurant.bookmarks.dart';
import 'package:uahage/src/Service/places.dart';
import 'package:uahage/src/Static/Font/font.dart';
import 'package:uahage/src/Static/Image/listImage.dart';
import 'package:uahage/src/Static/Widget/icon.dart';
import 'package:uahage/src/Static/Widget/progress.dart';
import 'package:uahage/src/Static/url.dart';
import '../HomeSub/listMap.dart';
import 'package:uahage/src/Static/Widget/appbar.dart';

class PlaceList extends GetView<PlaceController> {
  String url = URL;
  Bookmark bookmark = new Bookmark();
  int placeCode = Get.arguments;
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  getList() async {
    Place place = new Place();
    await place.getPlaceList(placeCode);
  }

  var width = 1500 / 720;
  var height = 2667 / 1280;
  Widget build(BuildContext context) {
    connection();
    ScreenUtil.init(context, width: 781, height: 1390);
    controller.placeInit();
    getList();
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      if (currentScroll == maxScroll) {
        getList();
      }
    });

    return Obx(
      () => SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            appBar: x_appBar(
                context,
                (() {
                  if (placeCode == 1) {
                    return "식당·카페";
                  } else if (placeCode == 2) {
                    return "영유아 건강검진 병원";
                  } else if (placeCode == 3) {
                    return "어린이집";
                  } else if (placeCode == 5) {
                    return "키즈카페";
                  } else if (placeCode == 6) {
                    return "키즈카페";
                  } else if (placeCode == 8) {
                    return "공방";
                  } else {
                    return "기타";
                  }
                }()),
                ""),
            body: Stack(
              children: [
                ConnectionController.to.connectionstauts !=
                        "ConnectivityResult.none"
                    ? Stack(
                        //  index: controller.indexCount.value,
                        children: <Widget>[
                            controller.indexCount.value == 0
                                ? ListViews()
                                : ListMap(placeCode: placeCode),
                          ])
                    : progress(),
                Container(
                  margin: EdgeInsets.only(
                      left: 950.w * 0.7 * 0.84, top: 1680.w * 0.7 * 0.84),
                  child: controller.indexCount.value == 1
                      ? GestureDetector(
                          onTap: () {
                            controller.changeindexCount(0);
                            controller.placeInit();
                            getList();
                          },
                          child: Image.asset(
                            './assets/on.png',
                            width: 284.w * 0.7 * 0.84,
                            height: 133.h * 0.6 * 0.9,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.changeindexCount(1);
                          },
                          child: Image.asset(
                            './assets/off.png',
                            width: 284.w * 0.7 * 0.84,
                            height: 133.h * 0.6 * 0.9,
                          ),
                        ),
                ),
              ],
            )),
      ),
    );
  }

  ListViews() {
    if (controller.place.length > 0) {
      return ListView.builder(
          controller: scrollController,
          itemCount: controller.place.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (controller.place.length == 0) {
              return progress();
            } else {
              return Card(
                elevation: 0.3,
                child: Container(
                    height: 450.h * 0.62 * 0.9,
                    padding: EdgeInsets.only(
                      top: 25.h * 0.6 * 0.9,
                      left: 26.w * 0.7 * 0.84,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          highlightColor: Colors.white,
                          onTap: () async {
                            var result =
                                await Get.toNamed("/listsub", arguments: {
                              "data": controller.place[index],
                              "placeCode": placeCode,
                              "index": index,
                            });
                            print("result $result");
                            controller.setPlaceBookmark(index, result[0]);
                            controller.setPlacetotal(index, "${result[1]}");
                          },
                          child: Container(
                            width: 1150.w * 0.7 * 0.84,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          (() {
                                            if (placeCode == 1) {
                                              if (index % 3 == 1)
                                                return restaurantListImage[0];
                                              else if (index % 3 == 2)
                                                return restaurantListImage[1];
                                              else
                                                return restaurantListImage[2];
                                            } else if (placeCode == 2) {
                                              if (index % 2 == 1)
                                                return hospitalListImage[0];
                                              else
                                                return hospitalListImage[1];
                                            } else if (placeCode == 6) {
                                              if (index % 4 == 1)
                                                return experienceListImage[0];
                                              else if (index % 4 == 2)
                                                return experienceListImage[1];
                                              else if (index % 4 == 3)
                                                return experienceListImage[2];
                                              else
                                                return experienceListImage[3];
                                            } else if (placeCode == 8) {
                                              if (controller.place[index]
                                                      .image_path !=
                                                  null) {
                                                return controller
                                                    .place[index].image_path[0];
                                              } else {
                                                return experienceListImage[0];
                                              }
                                            } else {
                                              if (index % 2 == 1)
                                                return kidsCafeListImage[0];
                                              else
                                                return kidsCafeListImage[1];
                                            }
                                          }()),
                                          scale: 0.1,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  height: 370.w * 0.7 * 0.84,
                                  width: 370.w * 0.7 * 0.84,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                  left: 53.w * 0.7 * 0.84,
                                )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Padding(padding: EdgeInsets.only(top: 10.g)),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          //margin: EdgeInsets.only(top: 20.h*0.6*0.9),
                                          // width: 600.w*0.7*0.84,
                                          height: 100.h * 0.6 * 0.9,
                                          child: controller.place[index].name
                                                      .length >
                                                  10
                                              ? normalfont(
                                                  '${controller.place[index].name.substring(0, 10)}...',
                                                  35,
                                                  Colors.black)
                                              : normalfont(
                                                  controller.place[index].name,
                                                  35,
                                                  Colors.black),
                                        ),
                                      ],
                                    ),

                                    placeCode == 1
                                        ? Row(
                                            children: [
                                              Image.asset(
                                                "./assets/listPage/star_color.png",
                                                width:
                                                    30 * width.w * 0.7 * 0.84,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4.7 *
                                                        width.w *
                                                        0.7 *
                                                        0.84),
                                              ),
                                              normalfont(
                                                  "${controller.place[index].total ?? 0.0} ",
                                                  30,
                                                  Color(0xff4d4d4d))
                                            ],
                                          )
                                        : Container(),
                                    placeCode == 1
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                top: 10.h * 0.6 * 0.9),
                                            child: controller.place[index]
                                                        .address.length >
                                                    14
                                                ? normalfont(
                                                    '${controller.place[index].address.substring(0, 14)}...',
                                                    30,
                                                    Color(0xffb0b0b0))
                                                : normalfont(
                                                    controller
                                                        .place[index].address,
                                                    30,
                                                    Color(0xffb0b0b0)),
                                          )
                                        : Container(
                                            width: 630.w * 0.7 * 0.84,
                                            margin: EdgeInsets.only(
                                                top: 10.h * 0.6 * 0.9),
                                            child: controller.place[index]
                                                        .address.length >
                                                    32
                                                ? normalfont(
                                                    '${controller.place[index].address.substring(0, 32)}...',
                                                    30,
                                                    Color(0xffb0b0b0))
                                                : normalfont(
                                                    controller
                                                        .place[index].address,
                                                    30,
                                                    Color(0xffb0b0b0)),
                                          ),
                                    // Container(
                                    //   height: 130.h*0.6*0.9,
                                    //   width: 650.w*0.7*0.84,
                                    //   child: Text(
                                    //     controller.place[index].address,
                                    //     style: TextStyle(
                                    //       // fontFamily: 'NatoSans',
                                    //       color: Colors.grey,
                                    //       fontSize: 46.sp,
                                    //       fontFamily: 'NotoSansCJKkr_Medium',
                                    //       height: 1.3,
                                    //     ),
                                    //   ),
                                    // ),
                                    placeCode == 1
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                top: 5.h * 0.6 * 0.9),
                                            height: 120.h * 0.6 * 0.9,
                                            width: 650.w * 0.7 * 0.84,
                                            alignment: Alignment.bottomRight,
                                            child: Row(
                                              children: [
                                                icon(
                                                  context,
                                                  controller
                                                      .place[index].baby_menu,
                                                  controller
                                                      .place[index].stroller,
                                                  controller
                                                      .place[index].baby_bed,
                                                  controller.place[index]
                                                      .baby_tableware,
                                                  controller.place[index]
                                                      .nursing_room,
                                                  controller.place[index]
                                                      .meeting_room,
                                                  controller.place[index]
                                                      .diaper_change,
                                                  controller
                                                      .place[index].play_room,
                                                  controller
                                                      .place[index].baby_chair,
                                                  // PlaceController
                                                  //     .to.place[index].parking
                                                  //     .toString())
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        placeCode == 1
                            ? Obx(
                                () => Container(
                                  margin: EdgeInsets.only(
                                      left: 8.w * 0.7 * 0.84,
                                      top: 25.h * 0.6 * 0.9),
                                  child: InkWell(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 30.w * 0.7 * 0.84,
                                          right: 30.w * 0.7 * 0.84,
                                          bottom: 10.h * 0.6 * 0.9),
                                      child: Image.asset(
                                        controller.place[index].bookmark == 0
                                            ? "./assets/listPage/love_grey.png"
                                            : "./assets/listPage/love_color.png",
                                        height: 55.h * 0.6 * 0.9,
                                      ),
                                    ),
                                    onTap: () async {
                                      if (controller.place[index].bookmark ==
                                          0) {
                                        await bookmark.bookmarkToogle(
                                            UserController.to.userId.value,
                                            controller.place[index].id);
                                        controller.setPlaceBookmark(index, 1);
                                      } else {
                                        await bookmark.bookmarkToogle(
                                            UserController.to.userId.value,
                                            controller.place[index].id);
                                        controller.setPlaceBookmark(index, 0);
                                      }
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    )),
              );
            }
          });
    } else {
      return progress();
    }
  }
}
