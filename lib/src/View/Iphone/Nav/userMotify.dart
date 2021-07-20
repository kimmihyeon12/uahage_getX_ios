import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:uahage/src/Service/users.dart';
import 'package:uahage/src/Static/Font/font.dart';
import 'package:uahage/src/Static/Image/mypageImage.dart';
import 'package:uahage/src/Static/Widget/bottomsheet.dart';
import 'package:uahage/src/Static/Widget/dialog.dart';
import 'package:uahage/src/Static/Widget/toast.dart';
import 'package:uahage/src/Static/Widget/yearpicker.dart';
import 'package:uahage/src/Static/url.dart';

class UserModify extends StatefulWidget {
  final userdata;
  const UserModify({
    Key key,
    this.userdata,
  }) : super(key: key);
  @override
  _UserModifyState createState() => _UserModifyState();
}

class _UserModifyState extends State<UserModify> {
  Map userdata;
  @override
  void initState() {
    super.initState();
    userdata = widget.userdata;
    userdata["nickname"] != "" ? isIdValid = true : isIdValid = false;
  }

  TextEditingController yController = TextEditingController();

  var ageImage = [false, false, false, false, false, false];

  bool isIdValid = false;

  String _uploadedFileURL = "";
  File _image;
  bool isImage = false;
  String imageLink = "";
  Users users = new Users();
  dynamic recievedImage;
  String url = URL;

  void _imageBottomSheet(context) async {
    Sheet sheet = new Sheet();
    await sheet.bottomSheet(context, "delete");
    if (sheet.image != null) {
      setState(() {
        _image = sheet.image;
      });
    } else {
      setState(() {
        userdata["image_path"] = "";
      });
    }
  }

  Future _formData() async {
    File file = _image;
    String fileName;
    if (userdata["image_path"] == "") {
      setState(() {
        isImage = true;
      });
    }

    FormData formData = FormData.fromMap({
      "image": _image == null
          ? null
          : await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last),
      "imgInit": isImage ? "Y" : "N",
      "nickname": "${userdata["nickname"]}",
      "ageGroupType": userdata["age_group_type"],
      "babyGender": "${userdata['baby_gender']}",
      "babyBirthday": "${userdata["baby_birthday"]}",
    });

    return formData;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 781, height: 1390);
    FocusScopeNode currentFocus = FocusScope.of(context);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(60.w * 0.7, 50.h * 0.62, 0, 0),
                    child: InkWell(
                      onTap: () async {
                        Navigator.pop(context, false);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "./assets/myPage/back.png",
                            width: 30.w * 0.7,
                            height: 76.h * 0.62,
                          ),
                          // 내 정보
                          Container(
                            margin: EdgeInsets.only(left: 33.w * 0.7),
                            child: normalfont(
                                "내 정보", 32, Color.fromRGBO(255, 114, 148, 1.0)),
                          ),

                          //
                        ],
                      ),
                    )),
                Container(
                  padding: EdgeInsets.only(top: 100.h * 0.62),
                  child: Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 330.h * 0.62,
                          width: 330.h * 0.62,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("./assets/myPage/avatar.png"),
                            child: (() {
                              if (userdata["image_path"] != "" &&
                                  _image == null) {
                                return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            userdata["image_path"]), //imageURL
                                        fit: BoxFit.cover),
                                  ),
                                );
                              } else if (_image != null) {
                                return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: FileImage(_image), //imageURL
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
                        Positioned(
                          right: -7,
                          bottom: -7,
                          child: Container(
                            child: InkWell(
                              onTap: () {
                                _imageBottomSheet(context);
                              },
                              child: Image.asset(
                                "./assets/myPage/camera.png",
                                height: 130.h * 0.62,
                                width: 130.w * 0.7,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(
                    top: 105.h * 0.62,
                  ),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 닉네임
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              118.w * 0.7, 40.h * 0.62, 57.w * 0.7, 0),
                          child: normalfont(
                              "닉네임", 32, Color.fromRGBO(255, 114, 148, 1.0)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 106.w * 0.7,
                            ),
                            child: Stack(
                              children: [
                                TextFormField(
                                  cursorColor: Color(0xffff7292),
                                  maxLength: 10,
                                  onChanged: (txt) {
                                    setState(() {
                                      isIdValid = false;
                                      userdata["nickname"] = txt;
                                    });
                                  },
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xff3a3939),
                                      fontFamily: "NotoSansCJKkr_Bold",
                                      fontSize: 32.sp),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    contentPadding:
                                        EdgeInsets.only(right: 410.w * 0.7),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xffff7292),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffff7292)),
                                    ),
                                    hintText: userdata["nickname"] == ''
                                        ? "닉네임을 입력하세요"
                                        : userdata["nickname"],
                                    hintStyle: TextStyle(
                                        color: const Color(0xffcacaca),
                                        fontFamily: "NotoSansCJKkr_Medium",
                                        fontSize: 32.sp),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: FlatButton(
                                    height: 106.h * 0.62,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    color: userdata["nickname"] == ""
                                        ? Color(0xffcacaca)
                                        : Color(0xffff7292),
                                    onPressed: userdata["nickname"] != ""
                                        ? () async {
                                            var data =
                                                await users.checkNickName(
                                                    userdata["nickname"]);
                                            setState(() {
                                              isIdValid = data['idValid'];
                                            });
                                            currentFocus.unfocus();
                                            dialog(
                                              context,
                                              data['value'],
                                            );
                                          }
                                        : () {},
                                    child: // 중복확인
                                        normalfont("중복확인", 32, Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Gender
                Container(
                  margin: EdgeInsets.fromLTRB(77.w * 0.7, 60.h * 0.62, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 아이성별
                      normalfont(
                          "아이성별", 32, Color.fromARGB(255, 255, 114, 148)),
                      Container(
                        height: 282.h * 0.62,
                        width: 195.w * 0.7,
                        margin: EdgeInsets.only(left: 41.w * 0.7),
                        child: InkWell(
                          child: Image.asset(userdata['baby_gender'] != "F" &&
                                  userdata['baby_gender'] != "A"
                              ? girl_image[0]
                              : girl_image[1]),
                          onTap: () {
                            setState(() {
                              if (userdata['baby_gender'] == "")
                                userdata['baby_gender'] = "F";
                              else if (userdata['baby_gender'] == "M")
                                userdata['baby_gender'] = "A";
                              else if (userdata['baby_gender'] == "A")
                                userdata['baby_gender'] = "M";
                              else if (userdata['baby_gender'] == "F") {
                                userdata['baby_gender'] = "";
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 283.h * 0.62,
                        width: 195.w * 0.7,
                        margin: EdgeInsets.only(left: 74.w * 0.7),
                        child: InkWell(
                          child: Image.asset(userdata['baby_gender'] != "M" &&
                                  userdata['baby_gender'] != "A"
                              ? boy_image[0]
                              : boy_image[1]),
                          onTap: () {
                            setState(() {
                              if (userdata['baby_gender'] == "")
                                userdata['baby_gender'] = "M";
                              else if (userdata['baby_gender'] == "F")
                                userdata['baby_gender'] = "A";
                              else if (userdata['baby_gender'] == "A")
                                userdata['baby_gender'] = "F";
                              else if (userdata['baby_gender'] == "M") {
                                userdata['baby_gender'] = "";
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(77.w * 0.7, 50.h * 0.62, 0, 0),
                  child: Row(
                    children: [
                      // 아이생일
                      normalfont("아이생일", 32, Color(0xffff7292)),

                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              58.w * 0.7, 0, 121.w * 0.7, 0),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var result = await yearPicker(context);
                                  setState(() {
                                    userdata["baby_birthday"] = result;
                                  });
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: yController,
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
                                      hintText: userdata["baby_birthday"] == ''
                                          ? "생년월일을 선택해주세요"
                                          : userdata["baby_birthday"],
                                      hintStyle: TextStyle(
                                          color: userdata["baby_birthday"] == ''
                                              ? Color(0xffd4d4d4)
                                              : Color(0xffff7292),
                                          fontFamily: "NotoSansCJKkr_Medium",
                                          fontSize: 32.0.sp),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () async {
                                    var result = await yearPicker(context);
                                    setState(() {
                                      userdata["baby_birthday"] = result;
                                    });
                                  },
                                  icon: Image.asset(
                                      "./assets/myPage/calendar.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 98.h * 0.62, 0, 0.h * 0.62),
                ),
                //Ages
                Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 120.w * 0.7)),
                      normalfont(
                          "보호자\n연령대", 32, Color.fromARGB(255, 255, 114, 148)),
                      Padding(padding: EdgeInsets.only(left: 44.w * 0.7)),
                      InkWell(
                        child: Image.asset(
                          userdata["age_group_type"] == 1
                              ? './assets/register/10_pink.png'
                              : './assets/register/10_grey.png',
                          height: 145.h * 0.62,
                          width: 185.w * 0.7,
                        ),
                        onTap: () {
                          setAgeColor(1);
                        },
                      ),
                      Padding(padding: EdgeInsets.only(left: 44.w * 0.7)),
                      InkWell(
                        child: Image.asset(
                          userdata["age_group_type"] == 2
                              ? './assets/register/20_pink.png'
                              : './assets/register/20_grey.png',
                          height: 145.h * 0.62,
                          width: 185.w * 0.7,
                        ),
                        onTap: () {
                          setAgeColor(2);
                        },
                      ),
                      Padding(padding: EdgeInsets.only(left: 44.w * 0.7)),
                      InkWell(
                        child: Image.asset(
                          userdata["age_group_type"] == 3
                              ? './assets/register/30_pink.png'
                              : './assets/register/30_grey.png',
                          height: 145.h * 0.62,
                          width: 185.w * 0.7,
                        ),
                        onTap: () {
                          setAgeColor(3);
                        },
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 35.w * 0.7)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 120.w * 0.7)),
                      normalfont("보호자\n연령대", 32, Colors.transparent),
                      Padding(padding: EdgeInsets.only(left: 44.w * 0.7)),
                      InkWell(
                        child: Image.asset(
                          userdata["age_group_type"] == 4
                              ? './assets/register/40_pink.png'
                              : './assets/register/40_grey.png',
                          height: 145.h * 0.62,
                          width: 185.w * 0.7,
                        ),
                        onTap: () {
                          setAgeColor(4);
                        },
                      ),
                      Padding(padding: EdgeInsets.only(left: 44.w * 0.7)),
                      InkWell(
                        child: Image.asset(
                          userdata["age_group_type"] == 5
                              ? './assets/register/50_pink.png'
                              : './assets/register/50_grey.png',
                          height: 145.h * 0.62,
                          width: 185.w * 0.7,
                        ),
                        onTap: () {
                          setAgeColor(5);
                        },
                      ),
                      Padding(padding: EdgeInsets.only(left: 44.w * 0.7)),
                      InkWell(
                        child: Image.asset(
                          userdata["age_group_type"] == 6
                              ? './assets/register/others_pink.png'
                              : './assets/register/others_grey.png',
                          height: 145.h * 0.62,
                          width: 185.w * 0.7,
                        ),
                        onTap: () {
                          setAgeColor(6);
                        },
                      ),
                    ],
                  ),
                ]),
                //   Padding(padding: EdgeInsets.only(top: 125.h*0.62)),

                //OK
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 80.h * 0.62,
                    ),
                    child: SizedBox(
                      height: 145.w * 0.7,
                      width: 893.h * 0.62,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        color: isIdValid &&
                                userdata["age_group_type"] != "" &&
                                userdata['baby_gender'] != "" &&
                                userdata["baby_birthday"] != ""
                            ? Color(0xffff7292)
                            : Color(0xffcacaca),
                        onPressed: isIdValid &&
                                userdata["age_group_type"] != "" &&
                                userdata['baby_gender'] != "" &&
                                userdata["baby_birthday"] != ""
                            ? () async {
                                var formdata = await _formData();
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => FutureBuilder(
                                    future: users.update(formdata),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          Navigator.pop(context, true);
                                          Navigator.pop(context, true);
                                        });
                                      } else if (snapshot.hasError) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                          ),
                                          title: Text("${snapshot.error}"),
                                          actions: [
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: // 확인
                                                  normalfont("확", 32,
                                                      Color(0xffff7292)),
                                            ),
                                          ],
                                        );
                                      }
                                      return Center(
                                        child: SizedBox(
                                            height: 200.w * 0.7,
                                            width: 200.w * 0.7,
                                            child: buildSpinKitThreeBounce(
                                                80.w * 0.7, 1500.h * 0.62)),
                                      );
                                    },
                                  ),
                                );
                              }
                            : () {
                                toast(context, "모든 필드를 입력하십시오", "bottom");
                                if (isIdValid == false) {
                                  dialog(context, "닉네임 중복을 확인해주세요");
                                }
                              },
                        child: // 중복확인
                            normalfont("OK", 32, Color(0xffffffff)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  setAgeColor(int value) {
    setState(() {
      userdata["age_group_type"] = value;
    });
  }
}
