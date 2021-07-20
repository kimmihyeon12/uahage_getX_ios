import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:uahage/src/Controller/user.controller.dart';
import 'package:uahage/src/Service/snslogin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uahage/src/Static/Widget/dialog.dart';
import 'package:get/get.dart';
import 'package:uahage/src/Static/Widget/appbar.dart';
import 'package:uahage/src/Static/Font/font.dart';

class Agreement extends StatefulWidget {
  @override
  _AgreementState createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  SnsLogin login = new SnsLogin();
  List<bool> check = [false, false, false, false];
  bool kakaoinstalled;
  initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() {
      kakaoinstalled = installed;
    });
  }

  void initState() {
    initKakaoTalkInstalled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      KakaoContext.clientId = "581f27a7aed8a99e5b0a78b33c855dab";

      ScreenUtil.init(context, width: 1125, height: 2436);
      if (check[1] && check[2] && check[3]) {
        setState(() {
          check[0] = true;
        });
      } else {
        setState(() {
          check[0] = false;
        });
      }
      return Scaffold(
        appBar: imageAppbar(context, "약관동의"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),

            Container(
                margin: EdgeInsets.only(top: 591.h),
                child: boldfont("서비스 약관에 동의해주세요.", 56, Color(0xffff7292))),

            // Agreement
            Container(
              margin: EdgeInsets.only(top: 87.h),
              width: 872.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(width: 0.1),
              ),
              child: // 모두 동의합니다.
                  Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60.h,
                        margin: EdgeInsets.only(
                            left: 23.w, top: 41.h, bottom: 41.h),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              check[0] =
                                  check[1] = check[2] = check[3] = !check[0];
                            });
                          },
                          child: check[0] == true
                              ? Image.asset(
                                  "./assets/agreementPage/checked.png")
                              : Image.asset(
                                  "./assets/agreementPage/unchecked.png"),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            left: 19.w,
                          ),
                          child: boldfont("모두 동의합니다.", 42, Color(0xff000000))),
                    ],
                  ),
                  Divider(thickness: 0.1, height: 0, color: Color(0xff000000)),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60.h,
                        margin: EdgeInsets.only(
                            left: 23.w, top: 41.h, bottom: 41.h),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                check[1] = !check[1];
                              });
                            },
                            child: check[1] == true
                                ? Image.asset(
                                    "./assets/agreementPage/checked.png")
                                : Image.asset(
                                    "./assets/agreementPage/unchecked.png")),
                      ),
                      Container(
                        width: 720.w,
                        margin: EdgeInsets.only(left: 19.w, right: 0),
                        child: InkWell(
                          onTap: () async {
                            final result = await Get.toNamed("/announce",
                                arguments: "check1");

                            if (result == "check")
                              setState(() {
                                check[1] = true;
                              });
                          },
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              normalfont("[필수] 이용약관 동의", 42, Color(0xff666666)),
                              Container(
                                height: 50.h,
                                // margin: EdgeInsets.only(right: 100.w),
                                child: Image.asset(
                                    "./assets/agreementPage/next.png"),
                              ),
                            ],
                          ),
                        ), // [필수] 이용약관 동의
                      ),
                    ],
                  ),
                  Divider(thickness: 0.1, height: 0, color: Color(0xff000000)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60.h,
                        margin: EdgeInsets.only(
                            left: 23.w, top: 41.h, bottom: 41.h),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                check[2] = !check[2];
                              });
                            },
                            child: check[2] == true
                                ? Image.asset(
                                    "./assets/agreementPage/checked.png")
                                : Image.asset(
                                    "./assets/agreementPage/unchecked.png")),
                      ),
                      Container(
                        width: 720.w,
                        margin: EdgeInsets.only(left: 19.w, right: 0),
                        child: InkWell(
                          onTap: () async {
                            final result = await Get.toNamed("/announce",
                                arguments: "check2");

                            if (result == "check")
                              setState(() {
                                check[2] = true;
                              });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              normalfont(
                                  "[필수] 개인정보처리방침 동의", 42, Color(0xff666666)),
                              Container(
                                height: 50.h,
                                //        margin: EdgeInsets.only(right: 20.w),
                                child: Image.asset(
                                    "./assets/agreementPage/next.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 0.1, height: 0, color: Color(0xff000000)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60.h,
                        margin: EdgeInsets.only(
                            left: 23.w, top: 41.h, bottom: 41.h),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                check[3] = !check[3];
                              });
                            },
                            child: check[3] == true
                                ? Image.asset(
                                    "./assets/agreementPage/checked.png")
                                : Image.asset(
                                    "./assets/agreementPage/unchecked.png")),
                      ),
                      Container(
                        width: 720.w,
                        margin: EdgeInsets.only(
                          left: 19.w,
                        ),
                        child: InkWell(
                          onTap: () async {
                            final result = await Get.toNamed("/announce",
                                arguments: "check3");
                            if (result == "check")
                              setState(() {
                                check[3] = true;
                              });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: normalfont("[필수] 위치기반서비스 이용약관 동의", 42.5,
                                    Color(0xff666666)),
                              ),
                              Container(
                                height: 50.h,
                                //       margin: EdgeInsets.only(right: 20.w),
                                child: Image.asset(
                                    "./assets/agreementPage/next.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 132.h),
              child: SizedBox(
                height: 130.h,
                width: 804.w,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: check[0] == true
                      ? const Color(0xffff7292)
                      : Color(0xffcacaca),
                  onPressed: () {
                    if (check[0] == false) {
                      dialog(context, "이용약관에 동의하셔야 합니다.");
                    } else {
                      switch (UserController.to.option.value) {
                        case "KAKAO":
                          if (kakaoinstalled)
                            awaitdialog(login.loginWithTalk(), context, 200.h,
                                200.w, 80.w, 100.w, 62.5.sp);
                          else {
                            awaitdialog(login.loginWithKakao(), context, 200.h,
                                200.w, 80.w, 100.w, 62.5.sp);
                          }
                          break;
                        case "NAVER":
                          awaitdialog(login.naverLogin(), context, 200.h, 200.w,
                              80.w, 100.w, 62.5.sp);
                          break;

                        default:
                          break;
                      }
                    }
                  },
                  child: normalfont("OK", 42.5, Color(0xffffffff)),
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      print("에러났어요!");
    }
  }
}
