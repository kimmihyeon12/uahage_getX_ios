import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uahage/src/Service/suggestion.dart';
import 'package:uahage/src/Static/Font/font.dart';
import 'package:uahage/src/Static/Widget/appbar.dart';
import 'package:uahage/src/Static/Widget/bottomsheet.dart';
import 'package:uahage/src/Static/Widget/dialog.dart';
import 'package:uahage/src/Static/Widget/toast.dart';

class ReviseSuggest extends StatefulWidget {
  const ReviseSuggest({Key key, @required this.placeId, this.placeCategoryId})
      : super(key: key);
  final placeId;
  final placeCategoryId;

  @override
  _ReviseSuggestState createState() => _ReviseSuggestState();
}

class _ReviseSuggestState extends State<ReviseSuggest> {
  int placeId;
  int placeCategoryId;
  List<dynamic> uploadingImage = [];
  final myController = TextEditingController();
  var width = 1500 / 720;
  var height = 2667 / 1280;
  bool btnColor = false;

  void initState() {
    super.initState();
    placeId = widget.placeId;
    placeCategoryId = widget.placeCategoryId;
  }

  void _imageBottomSheet(context) async {
    Sheet sheet = new Sheet();
    await sheet.bottomSheet(context, "");
    if (sheet.image != null) {
      setState(() {
        uploadingImage.add(sheet.image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 781, height: 1390);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        shadowColor: Colors.black26,
        title: new Text(
          "정보 수정 제안하기",
          style: TextStyle(
              fontSize: 35.sp,
              fontFamily: 'NotoSansCJKkr_Medium',
              color: Color.fromRGBO(255, 114, 148, 1.0)),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xffff7292)),
            onPressed: () {
              Get.back(result: "");
            }),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              if (btnColor) {
                var formdata = await suggestionFormData(placeId,
                    placeCategoryId, myController.text, uploadingImage);
                await revisesuggestion(formdata);
                toast(context, "정상적으로 등록되었습니다.", "bottom");
                Navigator.pop(context, 'ok');
              } else {
                toast(context, "10자 이상 작성해주세요.", "center");
              }
            },
            child: Container(
              padding: EdgeInsets.only(right: 40.h * 0.62),
              child: Center(
                child: Text(
                  "등록",
                  style: TextStyle(
                      fontSize: 35.sp,
                      fontFamily: 'NotoSansCJKkr_Medium',
                      color: btnColor
                          ? Color.fromRGBO(255, 114, 142, 1.0)
                          : Color.fromRGBO(212, 212, 212, 1.0)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              right: 35 * width.w * 0.7,
              left: 35 * width.w * 0.7,
              top: 30 * height.h * 0.62),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 260 * height.h * 0.62,
                child: TextFormField(
                  autofocus: true,
                  onChanged: (e) {
                    if (myController.text.length > 9) {
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
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xffff7292),
                    fontSize: 32.sp,
                  ),
                  maxLines: 20,
                  maxLength: 1000,
                  cursorColor: Color(0xffff7292),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "상호, 위치 이전,영업시간, 전화번호, 폐업 등\n정보를 작성해주세요.",
                    hintStyle: TextStyle(
                      color: Color(0xffc6c6c6),
                      fontSize: 32.sp,
                      height: 1.2,
                    ),
                    counterStyle: TextStyle(
                        color: Color(0xffff7292),
                        fontSize: 32.sp,
                        fontFamily: "NotoSansCJKkr_Medium"),
                    contentPadding: EdgeInsets.all(30.h * 0.62),
                  ),
                ),
              ),
              normalfont("5장 등록 가능", 32, Color(0xffc6c6c6)),
              Padding(padding: EdgeInsets.only(top: 5 * height.h * 0.62)),
              Container(
                // margin: EdgeInsets.only(
                //     top: 20 * height.h*0.62, right: 36 * width.w*0.7, left: 36 * width.w*0.7),
                width: double.infinity,
                height: 100 * width.w * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (uploadingImage.length > 4) {
                          dialog(context, "5장이상의 사진을 넣을수 없습니다");
                        } else {
                          FocusScope.of(context).unfocus();
                          _imageBottomSheet(context);
                        }
                      },
                      child: Image.asset(
                        "assets/reviewPage/camera_button.png",
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 17 * width.w * 0.7)),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: uploadingImage.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: 130 * width.w * 0.7,
                                        height: 130 * height.w * 0.7,
                                        child: Image.file(
                                          uploadingImage[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: FileImage(uploadingImage[
                                                  index]), //imageURL
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      Container(
                                        width: 130 * width.w * 0.7,
                                        height: 130 * height.w * 0.7,
                                        color: Colors.grey.withOpacity(0.3),
                                      ),
                                      Positioned(
                                        right: 3 * width,
                                        top: 3 * height,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              uploadingImage.removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            child: Image.asset(
                                              "assets/reviewPage/x_button.png",
                                              height: 27.3 * width.w * 0.7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 17 * width.w * 0.7)),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20 * height.h * 0.62)),
              Container(
                  padding: EdgeInsets.all(16 * height.h * 0.62),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 114, 142, 0.05),
                      border: Border.all(
                        color: Color.fromRGBO(255, 114, 142, 0.7),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: normalfont(
                      "제안해 주신 정보는 가능한 빠른 시일 내에 검토하여 업데이트에 반영하도록 하겠습니다.",
                      32,
                      Color.fromRGBO(255, 114, 142, 0.7)))
            ],
          ),
        ),
      ),
    );
  }
}
