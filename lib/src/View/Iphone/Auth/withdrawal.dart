import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Withdrawal extends StatefulWidget {
  @override
  _WithdrawalState createState() => _WithdrawalState();
}

class _WithdrawalState extends State<Withdrawal> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  Future startTime() async => Future.delayed(
        Duration(seconds: 2),
        () => Get.offAllNamed("/login"),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1500, height: 2667);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
            body: Stack(
          children: [
            Image.asset('./assets/firstPage/rectangleRectangle.png',
                height: 1415.h, fit: BoxFit.fitHeight),
            Container(
              alignment: Alignment.bottomCenter,
              child: Image(
                image: AssetImage('./assets/firstPage/backfamily.png'),
                //height: 2668.h,
                width: 1501.w,
                // height: 50,
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                  left: 658.w,
                )),
              ],
            ),
            Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                    top: 626.h,
                  )),
                  Text(
                    "회원탈퇴가 완료되었습니다.",
                    style: TextStyle(
                        fontFamily: "NotoSansCJKkr_Bold",
                        //   height: 1.0,
                        //   letterSpacing: -1.0,
                        fontSize: 78.sp,
                        // fontWeight: FontWeight.bold,
                        color: Color(0xffff7292)),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    top: 100.h,
                  )),
                  Text(
                    "그동안 우아하게를 이용해주시고 ",
                    style: TextStyle(
                        fontFamily: "NotoSansCJKkr_Medium",
                        // height: 0.8,
                        //   letterSpacing: -1.0,
                        fontSize: 63.sp,
                        color: Color.fromRGBO(255, 114, 142, 1.0)),
                  ),
                  Text(
                    "그 사랑해주셔서 감사합니다.",
                    style: TextStyle(
                        fontFamily: "NotoSansCJKkr_Medium",
                        //  height: 1.0,
                        //   letterSpacing: -1.0,
                        fontSize: 63.sp,
                        color: Color.fromRGBO(255, 114, 142, 1.0)),
                  ),
                  Text(
                    "더욱더 노력하고 발전하는 우아하게가 되겠습니다.",
                    style: TextStyle(
                        fontFamily: "NotoSansCJKkr_Medium",
                        //  height: 1.0,
                        //   letterSpacing: -1.0,
                        fontSize: 63.sp,
                        color: Color.fromRGBO(255, 114, 142, 1.0)),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
