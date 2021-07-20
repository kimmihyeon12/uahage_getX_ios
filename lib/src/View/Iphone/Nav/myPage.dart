import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uahage/src/Service/users.dart';
import 'package:uahage/src/Static/Image/mypageImage.dart';
import 'package:uahage/src/Static/Widget/progress.dart';
import 'package:uahage/src/Static/Font/font.dart';
import '../Nav/userMotify.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Users users = new Users();
  bool isIdValid = false;
  Map userdata;

  void userSelect() async {
    var data = await users.select();
    userdata = data;
  }

  @override
  Widget build(BuildContext context) {
    userSelect();

    ScreenUtil.init(context, width: 781, height: 1390);
    return userdata != null
        ? WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    //Center avatar
                    Padding(
                      padding: EdgeInsets.only(top: 230.h * 0.62),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 330.h * 0.62,
                            width: 330.h * 0.62,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("./assets/myPage/avatar.png"),
                              child: (() {
                                if ('${userdata["image_path"]}' != "") {
                                  return Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              userdata["image_path"]),
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "./assets/myPage/avatar.png"),
                                      ),
                                    ),
                                  );
                                }
                              }()),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Nickname
                    Container(
                      margin: EdgeInsets.only(top: 36.h * 0.62),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: userdata["nickname"] == ''
                                ? boldfont("우아하게", 40, Color(0xff3a3939))
                                : boldfont(userdata["nickname"], 40,
                                    Color(0xff3a3939)),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => UserModify(
                                            userdata: userdata,
                                          )),
                                );

                                if (result == true) {
                                  await userSelect();
                                  setState(() {});
                                }
                              },
                              child: Image.asset(
                                "./assets/myPage/button1_pink.png",
                                width: 252.w * 0.7,
                                height: 100.h * 0.62,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    //Gender
                    Container(
                      margin:
                          EdgeInsets.fromLTRB(81.w * 0.7, 90.h * 0.62, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 아이성별
                          normalfont(
                              "아이성별", 32, Color.fromARGB(255, 255, 114, 148)),

                          Container(
                            margin: EdgeInsets.fromLTRB(
                                41.w * 0.7, 0.h * 0.62, 0, 0),
                            height: 282.h * 0.62,
                            width: 195.w * 0.7,
                            child: InkWell(
                              child: Image.asset(
                                  userdata['baby_gender'] != "F" &&
                                          userdata['baby_gender'] != "A"
                                      ? girl_image[0]
                                      : girl_image[1]),
                            ),
                          ),
                          Container(
                            height: 283.h * 0.62,
                            width: 195.w * 0.7,
                            margin: EdgeInsets.only(left: 74.w * 0.7),
                            child: InkWell(
                              child: Image.asset(
                                  userdata['baby_gender'] != "M" &&
                                          userdata['baby_gender'] != "A"
                                      ? boy_image[0]
                                      : boy_image[1]),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Birthday
                    Container(
                      margin:
                          EdgeInsets.fromLTRB(81.w * 0.7, 50.h * 0.62, 0, 0),
                      child: Row(
                        children: [
                          // 아이생일
                          normalfont(
                              "아이생일", 32, Color.fromARGB(255, 255, 114, 148)),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  58.w * 0.7, 0, 81.w * 0.7, 0),
                              child: Stack(
                                children: [
                                  AbsorbPointer(
                                    child: TextFormField(
                                      readOnly: true,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xffff7292),
                                          fontSize: 32.sp,
                                          fontFamily: 'NotoSansCJKkr_Medium',
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: -1.0),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: const Color(0xffff7292),
                                          ),
                                          //Color.fromRGBO(255, 114, 148, 1.0)
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffff7292)),
                                        ),
                                        hintText:
                                            userdata["baby_birthday"] == ''
                                                ? "생년월일을 선택해주세요"
                                                : userdata["baby_birthday"],
                                        hintStyle: TextStyle(
                                            color:
                                                userdata["baby_birthday"] == ''
                                                    ? Color(0xffd4d4d4)
                                                    : Color(0xffff7292),
                                            fontFamily: "NotoSansCJKkr_Medium",
                                            fontSize: 32.0.sp),
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
                    // Ages
                    Container(
                      margin:
                          EdgeInsets.fromLTRB(125.w * 0.7, 91.h * 0.62, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 보호자 연령대
                          normalfont("보호자\n연령대", 32,
                              Color.fromARGB(255, 255, 114, 148)),

                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 44.w * 0.7),
                                      child: Image.asset(
                                        userdata["age_group_type"] == 1
                                            ? './assets/register/10_pink.png'
                                            : './assets/register/10_grey.png',
                                        height: 145.h * 0.62,
                                        width: 185.w * 0.7,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 44.w * 0.7),
                                      child: Image.asset(
                                        userdata["age_group_type"] == 2
                                            ? './assets/register/20_pink.png'
                                            : './assets/register/20_grey.png',
                                        height: 145.h * 0.62,
                                        width: 185.w * 0.7,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 44.w * 0.7),
                                      child: Image.asset(
                                        userdata["age_group_type"] == 3
                                            ? './assets/register/30_pink.png'
                                            : './assets/register/30_grey.png',
                                        height: 145.h * 0.62,
                                        width: 185.w * 0.7,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 44.w * 0.7, top: 35.h * 0.62),
                                      child: Image.asset(
                                        userdata["age_group_type"] == 4
                                            ? './assets/register/40_pink.png'
                                            : './assets/register/40_grey.png',
                                        height: 145.h * 0.62,
                                        width: 185.w * 0.7,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 44.w * 0.7, top: 35.h * 0.62),
                                      child: Image.asset(
                                        userdata["age_group_type"] == 5
                                            ? './assets/register/50_pink.png'
                                            : './assets/register/50_grey.png',
                                        height: 145.h * 0.62,
                                        width: 185.w * 0.7,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 44.w * 0.7, top: 35.h * 0.62),
                                      child: Image.asset(
                                        userdata["age_group_type"] == 6
                                            ? './assets/register/others_pink.png'
                                            : './assets/register/others_grey.png',
                                        height: 145.h * 0.62,
                                        width: 185.w * 0.7,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Ok Button

                    //logout
                    Container(
                      margin:
                          EdgeInsets.fromLTRB(698.w * 0.7, 170.h * 0.62, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  title: // 로그아웃 하시겠습니까?
                                      normalfont(
                                          "로그아웃 하시겠습니까?", 32, Colors.black),
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: normalfont(
                                          "아니요", 32, Color(0xffff7292)),
                                    ),
                                    FlatButton(
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.clear();
                                        Navigator.pop(context);
                                        Get.offAllNamed('/login');
                                      },
                                      child: normalfont(
                                          "네", 32, Color(0xffff7292)),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: // 로그아웃
                                normalfont("로그아웃", 28, Color(0xffb1b1b1)),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 15.w * 0.7, right: 15.w * 0.7),
                            child: normalfont("|", 30, Color(0xffb1b1b1)),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  title: normalfont(
                                      "탈퇴하시겠습니까? 탈퇴 시 기존 데이터를 복구할 수 없습니다.",
                                      32,
                                      Color(0xff4d4d4d)),
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: normalfont(
                                          "아니요", 32, Color(0xffff7292)),
                                    ),
                                    FlatButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();

                                        //delete data in the database
                                        showDialog(
                                          context: context,
                                          builder: (_) => FutureBuilder(
                                            future: users.delete(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                        (_) async {
                                                  await prefs.clear();
                                                  FlutterNaverLogin.logOut();
                                                  Get.offNamed("/withdrawal");
                                                });
                                              } else if (snapshot.hasError) {
                                                return AlertDialog(
                                                  title:
                                                      Text("${snapshot.error}"),
                                                );
                                              }
                                              return Center(
                                                child: SizedBox(
                                                  height: 200.h * 0.62,
                                                  width: 200.w * 0.7,
                                                  child: progress(),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: // 네
                                          normalfont(
                                              "예", 32, Color(0xffff7292)),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: normalfont("회원탈퇴", 28, Color(0xffb1b1b1)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : progress();
  }
}
