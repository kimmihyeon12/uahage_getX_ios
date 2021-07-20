import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uahage/src/Controller/connection.controller.dart';
import 'package:uahage/src/Service/connection.dart';
import 'package:uahage/src/Static/Widget/progress.dart';
import '../Nav/search.dart';
import '../Nav/star.dart';
import '../Nav/Home.dart';
import 'myPage.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    connection();
    FocusScopeNode currentFocus = FocusScope.of(context);
    ScreenUtil.init(context, width: 781, height: 1390);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
      onWillPop: () {
        if (_selectedTabIndex >= 1) {
          setState(() {
            _selectedTabIndex = 0;
          });
        } else
          SystemNavigator.pop();
        // Navigator.pop(context, true);
      },
      child: Scaffold(
          body: Stack(
            children: [
              _selectedTabIndex != 1
                  ? IndexedStack(
                      index: _selectedTabIndex,
                      children: <Widget>[
                        Home(),
                        Search(),
                        Star(),
                        MyPage(),
                      ],
                    )
                  : Search()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedTabIndex,
            showSelectedLabels: false, // <-- HERE
            showUnselectedLabels: false,
            elevation: 15,
            backgroundColor: Colors.white,
            onTap: (value) {
              setState(() {
                _selectedTabIndex = value;
                currentFocus.unfocus();
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/NavigationbarPage/home_grey.png",
                  width: 79.w * 0.5,
                  height: 144.h * 0.52,
                ),
                label: "home",
                activeIcon: Image.asset(
                  "assets/NavigationbarPage/home_pink.png",
                  width: 79.w * 0.5,
                  height: 144.h * 0.52,
                ),
                // title: Text("home"),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Image.asset(
                  "assets/NavigationbarPage/search_grey.png",
                  width: 79.w * 0.5,
                  height: 139.h * 0.52,
                ),
                activeIcon: Image.asset(
                  "assets/NavigationbarPage/search_pink.png",
                  width: 79.w * 0.5,
                  height: 139.h * 0.52,
                ),
                // title: Text("search"),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Image.asset(
                  "assets/NavigationbarPage/star_grey.png",
                  width: 162.w * 0.5,
                  height: 147.h * 0.52,
                ),
                activeIcon: Image.asset(
                  "assets/NavigationbarPage/star_pink.png",
                  width: 162.w * 0.5,
                  height: 147.h * 0.52,
                ),
                // title: Text("star"),
              ),
              BottomNavigationBarItem(
                label: "",

                icon: Image.asset(
                  "assets/NavigationbarPage/mypage_grey.png",
                  width: 132.w * 0.5,
                ),
                activeIcon: Image.asset(
                  "assets/NavigationbarPage/mypage_pink.png",
                  width: 132.w * 0.5,
                  height: 141.h * 0.52,
                ),
                // title: Text("mypage"),
              ),
            ],
          )),
    );
  }
}
