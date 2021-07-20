import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'dart:io';
import 'package:uahage/src/Binding/place.binding.dart';
import 'package:uahage/src/Binding/user.binding.dart';
import 'package:uahage/src/Controller/connection.controller.dart';

import 'package:uahage/src/Controller/location.controller.dart';
import 'package:uahage/src/Controller/place.restaurant.bookmark.controller.dart';
import 'package:uahage/src/Controller/user.controller.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:uahage/src/View/IphoneX/Auth/login.dart' as X_login;
import 'package:uahage/src/View/IphoneX/Loading/loading.dart' as X_loading;
import 'package:uahage/src/View/IphoneX/Nav/HomeSub/searchBar.dart'
    as X_searchBar;
import 'package:uahage/src/View/IphoneX/Nav/navigator.dart' as X_navigator;
import 'package:uahage/src/View/IphoneX/Nav/HomeSub/list.dart' as X_list;
import 'package:uahage/src/View/IphoneX/Nav/HomeSub/listsub.dart' as X_listsub;
import 'package:uahage/src/View/IphoneX/Auth/register.dart' as X_register;
import 'package:uahage/src/View/IphoneX/Auth/announce.dart' as X_announce;
import 'package:uahage/src/View/IphoneX/Auth/agreement.dart' as X_agreement;
import 'package:uahage/src/View/IphoneX/Nav/home.dart' as X_home;
import 'package:uahage/src/View/IphoneX/Nav/search.dart' as X_search;
import 'package:uahage/src/View/IphoneX/Nav/myPage.dart' as X_myPage;
import 'package:uahage/src/View/IphoneX/Auth/withdrawal.dart' as X_withdrawal;
import 'package:uahage/src/View/IphoneX/Nav/userMotify.dart' as X_userModify;
import 'src/View/IphoneX/Nav/Star.dart' as X_Star;

import 'package:uahage/src/View/Iphone/Auth/login.dart';
import 'package:uahage/src/View/Iphone/Loading/loading.dart';
import 'package:uahage/src/View/Iphone/Nav/HomeSub/searchBar.dart';
import 'package:uahage/src/View/Iphone/Nav/navigator.dart';
import 'package:uahage/src/View/Iphone/Nav/HomeSub/list.dart';
import 'package:uahage/src/View/Iphone/Nav/HomeSub/listsub.dart';
import 'package:uahage/src/View/Iphone/Auth/register.dart';
import 'package:uahage/src/View/Iphone/Auth/announce.dart';
import 'package:uahage/src/View/Iphone/Auth/agreement.dart';
import 'package:uahage/src/View/Iphone/Nav/home.dart';
import 'package:uahage/src/View/Iphone/Nav/search.dart';
import 'package:uahage/src/View/Iphone/Nav/myPage.dart';
import 'package:uahage/src/View/Iphone/Auth/withdrawal.dart';
import 'package:uahage/src/View/Iphone/Nav/userMotify.dart';
import 'src/View/Iphone/Nav/Star.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isIphoneX = Device.get().isIphoneX;
  bool isIos = Platform.isIOS;
  @override
  Widget build(BuildContext context) {
    // print("iphonex : $isIphoneX");
    return isIphoneX == false
        ? GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialBinding: BindingsBuilder(() => {
                  Get.put(UserController()),
                  Get.put(LocationController()),
                  Get.put(BookmarkController()),
                  Get.put(ConnectionController()),
                }),
            getPages: [
              GetPage(
                name: "/",
                page: () => Loading(),
              ),
              GetPage(name: "/login", page: () => Login()),
              GetPage(name: "/agreement", page: () => Agreement()),
              GetPage(name: "/announce", page: () => Announce()),
              GetPage(name: "/register", page: () => Register()),

              GetPage(
                name: "/withdrawal",
                page: () => Withdrawal(),
              ),

              //NAV
              GetPage(
                name: "/navigator",
                page: () => Navigation(),
              ),
              GetPage(name: "/home", page: () => Home(), bindings: [
                PlaceBinding(),
              ]),
              GetPage(
                  name: "/list",
                  page: () => PlaceList(),
                  bindings: [
                    PlaceBinding(),
                  ],
                  transition: Transition.fadeIn),
              GetPage(name: "/listsub", page: () => ListSub(), bindings: [
                PlaceBinding(),
              ]),
              GetPage(name: "/searchbar", page: () => SearchBar(), bindings: [
                PlaceBinding(),
              ]),
              GetPage(
                name: "/search",
                page: () => Search(),
              ),
              GetPage(name: "/star", page: () => Star()),
              GetPage(name: "/mypage", page: () => MyPage()),
              GetPage(
                name: "/userModify",
                page: () => UserModify(),
              ),
            ],
          )
        : GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialBinding: BindingsBuilder(() => {
                  Get.put(UserController()),
                  Get.put(LocationController()),
                  Get.put(BookmarkController()),
                  Get.put(ConnectionController()),
                }),
            getPages: [
              GetPage(
                name: "/",
                page: () => X_loading.Loading(),
              ),
              GetPage(name: "/login", page: () => X_login.Login()),
              GetPage(name: "/agreement", page: () => X_agreement.Agreement()),
              GetPage(name: "/announce", page: () => X_announce.Announce()),
              GetPage(name: "/register", page: () => X_register.Register()),

              GetPage(
                name: "/withdrawal",
                page: () => X_withdrawal.Withdrawal(),
              ),

              //NAV
              GetPage(
                name: "/navigator",
                page: () => X_navigator.Navigation(),
              ),
              GetPage(name: "/home", page: () => X_home.Home(), bindings: [
                PlaceBinding(),
              ]),
              GetPage(
                  name: "/list",
                  page: () => X_list.PlaceList(),
                  bindings: [
                    PlaceBinding(),
                  ],
                  transition: Transition.fadeIn),
              GetPage(
                  name: "/listsub",
                  page: () => X_listsub.ListSub(),
                  bindings: [
                    PlaceBinding(),
                  ]),
              GetPage(
                  name: "/searchbar",
                  page: () => X_searchBar.SearchBar(),
                  bindings: [
                    PlaceBinding(),
                  ]),
              GetPage(
                name: "/search",
                page: () => X_search.Search(),
              ),
              GetPage(name: "/star", page: () => X_Star.Star()),
              GetPage(name: "/mypage", page: () => X_myPage.MyPage()),
              GetPage(
                name: "/userModify",
                page: () => X_userModify.UserModify(),
              ),
            ],
          );
  }
}
