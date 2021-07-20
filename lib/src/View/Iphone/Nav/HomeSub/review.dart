import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uahage/src/Service/review.dart';
import 'package:uahage/src/Static/Font/font.dart';
import 'package:uahage/src/Static/Widget/appbar.dart';
import 'package:uahage/src/Static/Widget/bottomsheet.dart';
import 'package:uahage/src/Static/Widget/dialog.dart';
import 'package:uahage/src/Static/Widget/toast.dart';

class ReviewPage extends StatefulWidget {
  final data;
  final reviewData;

  const ReviewPage({Key key, @required this.data, this.reviewData})
      : super(key: key);
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  var data;
  var reviewData;
  List ratingLabel = ["평가없음", "별로예요", "그냥 그래요", "보통이에요", "맘에 들어요", "아주 좋아요"];
  List<dynamic> uploadingImage = [];
  List<dynamic> prevImage = [];
  List<dynamic> deleteImage = [];
  List<dynamic> ee = [];
  int index1 = 0, index2 = 0, index3 = 0;
  bool btnColor = false;
  var width = 1500 / 720;
  var height = 2667 / 1280;
  final myController = TextEditingController();
  bool imageLoad = false;
  double taste, cost, service = 0;
  @override
  void initState() {
    super.initState();

    data = widget.data;
    reviewData = widget.reviewData;

    index1 =
        reviewData != null ? double.parse(reviewData.taste_rating).round() : 0;
    taste = reviewData != null ? double.parse(reviewData.taste_rating) : 0;
    index2 =
        reviewData != null ? double.parse(reviewData.cost_rating).round() : 0;
    cost = reviewData != null ? double.parse(reviewData.cost_rating) : 0;
    index3 = reviewData != null
        ? double.parse(reviewData.service_rating).round()
        : 0;
    service = reviewData != null ? double.parse(reviewData.service_rating) : 0;
    myController.text = reviewData != null ? reviewData.description : "";
    if (reviewData != null) {
      if (reviewData.image_path != null) {
        imageLoad = true;
        prevImage.add(reviewData.image_path.split(','));
      }
    }

    setState(() {});
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
    ScreenUtil.init(context, width: 1125, height: 2436);
    if (myController.text.length >= 10) {
      setState(() {
        btnColor = true;
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        context,
        data.name,
        "",
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
                top: 36 * height.h * 0.9, bottom: 27.5 * height.h * 0.9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                normalfont("${data.name}", 46, Colors.black),
                normalfont("방문하셨나요?", 46, Color(0xff939393)),
              ],
            ),
          ),
          Divider(
            thickness: 2.h * 0.9,
          ),

          // 3 stars
          Container(
            height: 207 * height.h * 0.9,
            width: double.infinity,
            margin: EdgeInsets.only(
                top: 36 * height.sp,
                bottom: 35.7 * height.sp,
                left: 70 * width.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 50.w * 0.71),
                        child: boldfont("맛", 46, Colors.black)),
                    Padding(
                        padding: EdgeInsets.only(left: 39.3 * width.w * 0.71)),
                    Rating(
                        initrating: taste,
                        changed: (v) {
                          if (v == 5) {
                            index1 = 5;
                          } else if (v >= 4) {
                            index1 = 4;
                          } else if (v >= 3) {
                            index1 = 3;
                          } else if (v >= 2) {
                            index1 = 2;
                          } else if (v >= 1) {
                            index1 = 1;
                          } else {
                            index1 = 0;
                          }
                          setState(() {
                            taste = v;
                          });
                        }),
                    Padding(
                        padding: EdgeInsets.only(left: 22.3 * width.w * 0.71)),
                    Container(
                      width: 160 * width.w * 0.71,
                      child: normalfont("${ratingLabel[index1]}", 46,
                          index1 == 0 ? Color(0xffefefef) : Color(0xff4d4d4d)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25.w * 0.71),
                      child: boldfont("가격", 46, Colors.black),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 26.3 * width.w * 0.71)),
                    Rating(
                      initrating: cost,
                      changed: (v) {
                        if (v == 5) {
                          index2 = 5;
                        } else if (v >= 4) {
                          index2 = 4;
                        } else if (v >= 3) {
                          index2 = 3;
                        } else if (v >= 2) {
                          index2 = 2;
                        } else if (v >= 1) {
                          index2 = 1;
                        } else {
                          index2 = 0;
                        }
                        setState(() {
                          cost = v;
                        });
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 22.3 * width.w * 0.71)),
                    Container(
                      width: 160 * width.w * 0.71,
                      child: normalfont("${ratingLabel[index2]}", 46,
                          index2 == 0 ? Color(0xffefefef) : Color(0xff4d4d4d)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: boldfont("서비스", 46, Colors.black),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 12.3 * width.w * 0.71)),
                    Rating(
                      initrating: service,
                      changed: (v) {
                        if (v == 5) {
                          index3 = 5;
                        } else if (v >= 4) {
                          index3 = 4;
                        } else if (v >= 3) {
                          index3 = 3;
                        } else if (v >= 2) {
                          index3 = 2;
                        } else if (v >= 1) {
                          index3 = 1;
                        } else {
                          index3 = 0;
                        }
                        setState(() {
                          service = v;
                        });
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 22.3 * width.w * 0.71)),
                    Container(
                      width: 160 * width.w * 0.71,
                      child: normalfont("${ratingLabel[index3]}", 46,
                          index3 == 0 ? Color(0xffefefef) : Color(0xff4d4d4d)),
                    )
                  ],
                ),
              ],
            ),
          ),

          // Text input
          Container(
            margin: EdgeInsets.only(
              // top: 25.7.w*0.71,
              right: 36 * width.w * 0.71,
              left: 36 * width.w * 0.71,
            ),
            padding: EdgeInsets.only(bottom: 15.sp),
            width: double.infinity,
            height: 330 * width.w * 0.71,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 114, 142, 0.05),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: Color.fromRGBO(255, 114, 142, 0.4),
              ),
            ),
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
              textAlign: TextAlign.left,
              style: TextStyle(color: Color.fromRGBO(255, 114, 142, 0.6)),
              maxLines: 20,
              maxLength: 1000,
              cursorColor: Color.fromRGBO(255, 114, 142, 0.6),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: "최소 10자 이상 리뷰를 작성해주세요.",
                hintStyle: TextStyle(color: Color.fromRGBO(255, 114, 142, 0.6)),
                counterStyle: TextStyle(
                    color: Color.fromRGBO(255, 114, 142, 0.6),
                    fontFamily: "NotoSansCJKkr_Medium"),
                contentPadding:
                    EdgeInsets.only(top: 10.sp, right: 19.sp, left: 19.sp),
              ),
            ),
          ),

          // image upload
          Container(
            margin: EdgeInsets.only(
                top: 20 * height.h * 0.9,
                right: 36 * width.w * 0.71,
                left: 36 * width.w * 0.71),
            width: double.infinity,
            height: 130 * width.w * 0.71,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    if (((imageLoad == false ? 0 : prevImage[0].length) +
                            uploadingImage.length) >
                        4) {
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
                Padding(padding: EdgeInsets.only(left: 17 * width.w * 0.71)),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          (imageLoad == false ? 0 : prevImage[0].length) +
                              (uploadingImage.length),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            (imageLoad == false ? 0 : prevImage[0].length) >
                                    index
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: 130 * width.w * 0.71,
                                          height: 130 * height.w * 0.71,
                                          child: Image.network(
                                            prevImage[0][index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            image: DecorationImage(
                                                image: NetworkImage(prevImage[0]
                                                    [index]), //imageURL
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        Container(
                                          width: 130 * width.w * 0.71,
                                          height: 130 * height.w * 0.71,
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        Positioned(
                                          right: 3 * width,
                                          top: 3 * height,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (prevImage[0].length >
                                                    index) {
                                                  deleteImage
                                                      .add(prevImage[0][index]);
                                                  prevImage[0].removeAt(index);
                                                }
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/reviewPage/x_button.png",
                                              height: 27.3 * width.w * 0.71,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: 130 * width.w * 0.71,
                                          height: 130 * height.w * 0.71,
                                          child: Image.file(
                                            uploadingImage[index -
                                                (imageLoad == false
                                                    ? 0
                                                    : prevImage[0].length)],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            image: DecorationImage(
                                                image: FileImage(uploadingImage[
                                                    index -
                                                        (imageLoad == false
                                                            ? 0
                                                            : prevImage[0]
                                                                .length)]), //imageURL
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        Container(
                                          width: 130 * width.w * 0.71,
                                          height: 130 * height.w * 0.71,
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        Positioned(
                                          right: 3 * width,
                                          top: 3 * height,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                uploadingImage.removeAt(index -
                                                    (reviewData.image_path ==
                                                            null
                                                        ? 0
                                                        : prevImage[0].length));
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/reviewPage/x_button.png",
                                              height: 27.3 * width.w * 0.71,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 17 * width.w * 0.71)),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
          //  Bottom button
          Container(
            margin: EdgeInsets.only(
                top: 36 * height.w * 0.71,
                right: 110 * width.w * 0.71,
                left: 110 * width.w * 0.71,
                bottom: 65 * height.w * 0.71),
            width: double.infinity,
            height: 93 * width.w * 0.71,
            child: RaisedButton(
              elevation: 0,
              hoverElevation: 0,
              color: btnColor && service > 0 && cost > 0 && taste > 0
                  ? Color.fromRGBO(255, 114, 142, 1.0)
                  : Color.fromRGBO(212, 212, 212, 1.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "리뷰 남기기",
                style: TextStyle(
                    letterSpacing: -0.71.h * 0.9,
                    fontSize: 46.sp,
                    fontFamily: "NotoSansCJKkr_Bold",
                    color: Colors.white),
              ),
              onPressed: () async {
                if (btnColor && service > 0 && cost > 0 && taste > 0) {
                  if (reviewData == null) {
                    var formdata = await insertFormData(
                        data.id,
                        myController.text,
                        taste,
                        cost,
                        service,
                        uploadingImage);

                    await reviewInsert(formdata);
                    Navigator.pop(context, 'ok');
                  } else {
                    var formdata = await reviewUpdateFormdata(uploadingImage,
                        myController.text, taste, cost, service, deleteImage);

                    await reviewUpdate(reviewData.id, formdata);
                    Navigator.pop(context, 'ok');
                  }
                } else {
                  toast(context, "모든필드를 입력해주세요", "bottom");
                }
              },
            ),
          )
        ],
      )),
    );
  }
}

class Rating extends StatelessWidget {
  final rateValue;
  final Function changed;
  final initrating;
  const Rating({
    Key key,
    this.rateValue,
    this.changed,
    this.initrating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = 1500 / 720;
    var height = 2667 / 1280;
    return RatingBar(
      initialRating: initrating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 45.3 * width.w * 0.71,
      ratingWidget: RatingWidget(
        full: Image.asset(
          'assets/listPage/star_color.png',
          // width: 1.3.h*0.9,
        ),
        half: Image.asset(
          'assets/listPage/star_half.png',
          // width: 1.3.h*0.9,
        ),
        empty: Image.asset(
          'assets/listPage/star_grey.png',
          // width: 1.3.h*0.9,
        ),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
      onRatingUpdate: changed,
    );
  }
}
