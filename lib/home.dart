import 'dart:convert';

import 'package:ebooks/helper/setting.dart';
import 'package:ebooks/list_chapter.dart';
import 'package:ebooks/list_search.dart';
import 'package:ebooks/helper/transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';

import 'helper/colors_res.dart';
import 'listmenu/about_us.dart';
import 'listmenu/contact_us.dart';
import 'listmenu/privacy.dart';
import 'listmenu/term_condition.dart';
import 'helper/model.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final String data;
  const Home({Key? key, required this.data}) : super(key: key);

  _Home createState() => _Home();
}

class _Home extends State<Home> {
  bool isOpened = false;
  double xOffset = 0;
  double yOffsite = 0;
  double scaleFactor = 1;
  var fullHeight, fullWidth;
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    fullHeight = MediaQuery.of(context).size.height;
    fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color:  Colors.grey,
          ),

          blurDesign1(),
          navSideBar(),
          animatedContainer(),
          blurDesign2(),
          menuTapped(),
        ],
      ),
    );
  }

  //========================== Main Code for body ============================//

  animatedContainer() {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffsite, 0)
        ..scale(scaleFactor)
        ..rotateY(isOpened ? -0.5 : 0),

      decoration: BoxDecoration(
        color: ColorsRes.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 60,
            color: ColorsRes.appColor.withOpacity(0.5),
            offset: Offset(1, 3),
          ),
        ],

        borderRadius: BorderRadius.circular(isOpened ? 40 : 0.0),
      ),

      duration: Duration(milliseconds: 250),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(isOpened ? 40 : 0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: controller,
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              appBar(),
              setSliders(),
              body(),
            ],
          ),
        ),
      ),
    );
  }

  navSideBar() {
    return Container(
      decoration: BoxDecoration(
        color: ColorsRes.appColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.75,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsRes.textcolor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.42,
            child: Stack(
              children: [
                Positioned(
                    top: fullHeight * 0.06,
                    left: fullWidth * 0.15,
                    child: Image.asset("assets/image/splash_logo.png"),
                ),

                Positioned(
                    top: fullHeight * 0.34,
                    left: fullWidth * 0.18,
                    child: Text(
                      'E-book',
                      style: TextStyle(
                        color: ColorsRes.appColor,
                        fontSize: 16,
                      ),
                    )
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Image.asset("assets/image/termscond_icon.png"),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Terms & Conditions',
                          style: TextStyle(
                            color: ColorsRes.white,
                            fontSize: 20,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Terms_Condition(),
                      ),
                    );
                  },
                ),

                ListTile(
                  title: Row(
                    children: [
                      Image.asset("assets/image/privacypolicy_icon.png"),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            color: ColorsRes.white,
                            fontSize: 20,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Privacy_Policy(),
                      ),
                    );
                  },
                ),

                ListTile(
                  title: Row(
                    children: [
                      Image.asset("assets/image/rateus_icon.png"),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Rate Us',
                          style: TextStyle(
                            color: ColorsRes.white,
                            fontSize: 20,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    LaunchReview.launch(
                      androidAppId: "com.my.ebook",
                      iOSAppId: "585027354",
                    );
                  },
                ),

                ListTile(
                    title: Row(
                      children: [
                        Image.asset("assets/image/share_app.png"),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Share App',
                            style: TextStyle(
                              color: ColorsRes.white,
                              fontSize: 20,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        Share.share(
                            'https://play.google.com/store/apps/details? id=com.book.reading');
                      });
                    },
                ),

                ListTile(
                  title: Row(
                    children: [
                      Image.asset("assets/image/contactus_icon.png"),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                            color: ColorsRes.white,
                            fontSize: 20,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Contact_Us(),
                        ),
                    );
                  },
                ),

                ListTile(
                  title: Row(
                    children: [
                      Image.asset("assets/image/aboutus_icon.png"),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'About Us',
                          style: TextStyle(
                            color: ColorsRes.white,
                            fontSize: 20,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => About_Us(),
                        ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  menuTapped() {
    return isOpened
      ? Positioned.directional(
          textDirection: Directionality.of(context),
          top: fullHeight * 0.1,
          start: fullWidth * 0.8,
          child: GestureDetector(
            onTap: () {
              setState(() {
                xOffset = 0;
                yOffsite = 0;
                scaleFactor = 1;
                isOpened = false;
              });
            },
            child: Container(
              width: fullWidth * 0.195,
              height: fullHeight * 0.79,
              color: Colors.transparent,
            ),
        )
    ) : Container();
  }

  blurDesign1() {
    return isOpened ? Positioned.directional(
        textDirection: Directionality.of(context),
        top: fullHeight * 0.0,
        start: fullWidth * 0.50,
        child: Container(
          width: fullWidth * 0.25,
          height: fullHeight,
          color: Colors.white.withOpacity(0.3),
        )
    ) : Container();
  }

  blurDesign2() {
    return isOpened ? Positioned.directional(
        textDirection: Directionality.of(context),
        top: fullHeight * 0.0,
        start: fullWidth * 0.75,
        child: Container(
          width: fullWidth * 0.25,
          height: fullHeight,
          color: Colors.white.withOpacity(0.3),
        )
    ) : Container();
  }

  //============================ Body Code ===================================//

  Future<Base> secondConfigure() async {
    final response = await http.get(Uri.parse(widget.data));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return Base.fromJson(jsonData);
    } else {
      throw secondConfigure();
    }
  }

  body() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
      color: ColorsRes.white,
      child: FutureBuilder<Base>(
        future: secondConfigure(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Base? base = snapshot.data;
            List<ListHome> _list = List.from(base!.listed);

            if (Setting.opsi_ad != 0) {
              switch (Setting.opsi_ad) {
                case 1:
                  Setting.createInterstitialAdmob();
                  break;

                default:
              }
              for (int i = 0; i < base.listed.length; i++) {
                if((i + 1) % 5 == 3 && i != 0) {
                  _list..insert(i, base.listed[i]);
                }
              }
            }

            return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _list.length,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemBuilder: (context, index) {
                  if (Setting.opsi_ad != 0) {
                    return ((index + 1) % 5 != 3 || index == 0)
                        ? Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: GestureDetector(
                        onTap: () async {
                          switch (Setting.opsi_ad) {
                            case 1:
                              Setting.showInterstitial();
                              break;
                              
                            default:
                          }

                          Navigator.push(
                            context,
                            SlideLeftRoute(page: ChapterPage(
                              name_book: _list[index].name_book,
                              list: _list[index].list,
                            )),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              )
                          ),
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              ),
                              image: DecorationImage(
                                  image: AssetImage("assets/image/container_box.png"),
                                  fit: BoxFit.fill
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _list[index].name_book,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorsRes.appColor,
                                    fontSize: 18,
                                    height: 1.0
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                        : Container(
                      child: (() {
                        switch (Setting.opsi_ad) {
                          case 1:
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/image/container_box.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Setting.createNativeAdmob(),
                                ),
                              ),
                            );

                          default:
                            return Container();
                        }
                      } ())
                    );
                  }

                  else {
                    return Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            SlideLeftRoute(page: ChapterPage(
                              name_book: _list[index].name_book,
                              list: _list[index].list,
                            )),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              )
                          ),
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              ),
                              image: DecorationImage(
                                  image: AssetImage("assets/image/container_box.png"),
                                  fit: BoxFit.fill
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _list[index].name_book,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorsRes.appColor,
                                    fontSize: 18,
                                    height: 1.0
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },

                staggeredTileBuilder: (index) {
                  if (Setting.opsi_ad != 0) {
                    return ((index + 1) % 5 != 3 || index == 0)
                        ? StaggeredTile.count(1, 1)
                        : StaggeredTile.count(2, 1.5);
                  } else {
                    return StaggeredTile.count(1, 1);
                  }
                }
            );
          }

          return Center(
            child: Text('loading...'),
          );
        },
      ),
    );
  }

  appBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isOpened
              ? IconButton(
            icon: Image.asset("assets/image/menu_icon.png"),
            onPressed: () {
              setState(() {
                xOffset = 0;
                yOffsite = 0;
                scaleFactor = 1;
                isOpened = false;
              });
            },
          )
              : IconButton(
            icon: Image.asset("assets/image/menu_icon.png"),
            onPressed: () {
              setState(() {
                xOffset = fullWidth * 0.8;
                yOffsite = fullHeight * 0.1;
                scaleFactor = 0.8;
                isOpened = true;
              });
            },
          ),

          Text(
            'E-book',
            style: TextStyle(
                fontSize: 25,
                color: ColorsRes.appColor,
                fontWeight: FontWeight.w500
            ),
          ),

          IconButton(
            icon: Image.asset("assets/image/search_icon.png"),
            onPressed: () {
              Navigator.push(
                context,
                SlideLeftRoute(page: ListSearch())
              );
            },
          ),
        ],
      ),
    );
  }

  setSliders() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: fullWidth / 1.5,
        child: Carousel(
          dotSize: 5.0,
          dotSpacing: 15.0,
          animationCurve: Curves.easeInOutSine,
          animationDuration: Duration(seconds: 1),
          autoplay: true,
          dotColor: ColorsRes.textcolor,
          indicatorBgPadding: 5.0,
          dotVerticalPadding: 5.0,
          dotBgColor: Colors.transparent,
          dotPosition: DotPosition.bottomCenter,
          images: [
            Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/image/slider_home.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: fullHeight * 0.075,
                  left: fullWidth * 0.390,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Explore',
                      style: TextStyle(
                        color: ColorsRes.textcolor,
                        fontFamily: "Poppins",
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: fullHeight * 0.095,
                  left: fullWidth * 0.388,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Instructive",
                      style: TextStyle(
                        color: ColorsRes.textcolor,
                        fontSize: 35,
                        //   fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: fullHeight * 0.148,
                  left: fullWidth * 0.74,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Books",
                        style: TextStyle(
                          color: ColorsRes.textcolor,
                          fontSize: 15,
                          fontFamily: "Poppins-Thin",
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                ),
                Positioned(
                  top: fullHeight * 0.2,
                  left: fullWidth * 0.567,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.jumpTo(fullHeight * 0.5);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ColorsRes.textcolor,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Text(
                      "Explore Now",
                      style: TextStyle(
                        color: ColorsRes.appColor,
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/image/slider2_home.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: fullHeight * 0.085,
                  left: fullWidth * 0.447,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Explore",
                        style: TextStyle(
                          color: ColorsRes.textcolor,
                          fontFamily: "Poppins-Thin",
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                ),
                Positioned(
                  top: fullHeight * 0.105,
                  left: fullWidth * 0.447,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Biography",
                      style: TextStyle(
                        color: ColorsRes.textcolor,
                        fontSize: 30,
                        fontFamily: "Poppins-ExtraBold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: fullHeight * 0.1555,
                  left: fullWidth * 0.72,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Books",
                        style: TextStyle(
                          color: ColorsRes.textcolor,
                          fontSize: 15,
                          fontFamily: "Poppins-Thin",
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                ),
                Positioned(
                  top: fullHeight * 0.21,
                  left: fullWidth * 0.5525,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.jumpTo(fullHeight * 0.5);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ColorsRes.textcolor,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Text(
                      "Explore Now",
                      style: TextStyle(
                        color: ColorsRes.appColor,
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/image/slider3_home.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: fullHeight * 0.078,
                  left: fullWidth * 0.3868,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Explore",
                        style: TextStyle(
                          color: ColorsRes.textcolor,
                          fontFamily: "Poppins-Thin",
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                ),
                Positioned(
                  top: fullHeight * 0.105,
                  left: fullWidth * 0.3868,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Historical",
                      style: TextStyle(
                        color: ColorsRes.textcolor,
                        fontSize: 35,
                        fontFamily: "Poppins-ExtraBold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: fullHeight * 0.16,
                  left: fullWidth * 0.695,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Books",
                        style: TextStyle(
                          color: ColorsRes.textcolor,
                          fontSize: 15,
                          fontFamily: "Poppins-Thin",
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                ),
                Positioned(
                  top: fullHeight * 0.22,
                  left: fullWidth * 0.52,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.jumpTo(fullHeight * 0.5);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ColorsRes.textcolor,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Text(
                      "Explore Now",
                      style: TextStyle(
                        color: ColorsRes.appColor,
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}