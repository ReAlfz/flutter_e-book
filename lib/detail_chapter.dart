import 'package:ebooks/helper/transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'helper/colors_res.dart';
import 'list_search.dart';
import 'helper/model.dart';

class DetailChapter extends StatefulWidget{
  final String name_book;
  final List<ListChapter> list;
  final int index;
  const DetailChapter({Key? key, required this.name_book, required this.list, required this.index}) : super(key: key);

  @override
  _DetailChapter createState() => _DetailChapter();
}

class _DetailChapter extends State<DetailChapter> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                appBar(height, width),
                nextAndPrevious(height, width),
                body(height, width),
              ],
            ),
          ),
        ],
      ),
    );
  }

  nextAndPrevious(double height, double width) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (widget.index != 0)
                  ? () {
                Navigator.pushReplacement(
                    context,
                    SlideUp(page: DetailChapter(
                        name_book: widget.name_book,
                        list: widget.list,
                        index: widget.index - 1
                    ))
                );
              } : null,

              child: Container(
                width: width * 0.45,
                height: height * 0.07,
                child: Card(
                  color: (widget.index != 0) ?
                    ColorsRes.appColor.withOpacity(0.9) : ColorsRes.black.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 17,
                          color: (widget.index != 0)
                              ? ColorsRes.textcolor : ColorsRes.black.withOpacity(0.3),
                        ),

                        SizedBox(),

                        Text('Previous',
                          style: TextStyle(
                              color: (widget.index != 0)
                                  ? ColorsRes.textcolor : ColorsRes.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold,
                              height: 1,
                              fontSize: 18
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ),
            ),

            GestureDetector(
              onTap: (widget.index != widget.list.length - 1)
                  ? () {
                Navigator.pushReplacement(
                    context,
                    SlideUp(page: DetailChapter(
                        name_book: widget.name_book,
                        list: widget.list,
                        index: widget.index + 1
                    ))
                );
              } : null,

              child: Container(
                width: width * 0.45,
                height: height * 0.07,
                child: Card(
                  color:(widget.index != widget.list.length - 1)
                      ? ColorsRes.appColor.withOpacity(0.9) : ColorsRes.black.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Next',
                          style: TextStyle(
                              color: (widget.index != widget.list.length - 1)
                                  ? ColorsRes.textcolor : ColorsRes.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold,
                              height: 1,
                              fontSize: 18
                          ),
                        ),

                        SizedBox(),

                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: (widget.index != widget.list.length - 1)
                              ? ColorsRes.textcolor : ColorsRes.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  body(double height, double width) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25)
        ),
        side: BorderSide(
          color: ColorsRes.black.withOpacity(0.1),
          width: 1
        )
      ),
      child: Container(
        width: width,
        height: height * 0.54,
        child: Center(
          child: WebView(
            initialUrl: widget.list[widget.index].link,
            onProgress: (int process) {
              Center(
                child: Text('Loading...'),
              );
            },
          ),
        ),
      ),
    );
  }

  appBar(double height, double width) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )
      ),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 40,
                  ),
                  color: ColorsRes.appColor,
                  onPressed: () {
                    Navigator.pop(context);
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
                      MaterialPageRoute(
                          builder: (context) => ListSearch()
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 12, 12, 0),
                    child: Container(
                      width: width * 0.40,
                      child: Text(
                        widget.name_book,
                        style: TextStyle(
                          color: ColorsRes.appColor,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(17, 10, 12, 50),
                    child: Container(
                      width: width * 0.40,
                      child: Text(
                        'Total chapter ${widget.list.length}',
                        style: TextStyle(
                            color: ColorsRes.appColor,
                            height: 1.0
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Container(
                      width: width * 0.32,
                      height: height * 0.22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(25)
                        ),
                        image: DecorationImage(
                            image: AssetImage("assets/image/container_box.png"),
                            fit: BoxFit.fill
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            widget.name_book,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorsRes.appColor,
                                fontSize: 18,
                                height: 1
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}