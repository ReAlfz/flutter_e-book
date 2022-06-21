import 'package:ebooks/detail_chapter.dart';
import 'package:ebooks/helper/colors_res.dart';
import 'package:ebooks/helper/transition.dart';
import 'package:ebooks/helper/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'list_search.dart';

class ChapterPage extends StatefulWidget {
  final String name_book;
  final List<ListChapter> list;

  const ChapterPage({Key? key, required this.name_book, required this.list}) : super(key: key);
  _ChapterPage createState() => _ChapterPage();
}

class _ChapterPage extends State<ChapterPage> {
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
            color: ColorsRes.white,
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),

                appBar(height, width),
                body(height, width),
              ],
            ),
          ),
        ],
      ),
    );
  }

  body(double height, double width) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        side: BorderSide(
          color: ColorsRes.black.withOpacity(0.1),
          width: 1,
        )
      ),
      child: Container(
        width: width,
        padding: EdgeInsets.only(top: 15),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(5),
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                 Navigator.push(
                      context,
                      SlideUp(page: DetailChapter(
                        name_book: widget.name_book,
                        list: widget.list,
                        index: index,
                      ))
                  );
                },
                child: Container(
                  width: width,
                  height: height * 0.15,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: ColorsRes.black.withOpacity(0.1),
                        ),

                        borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    elevation: 2,

                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/image/chapter_icon.png"),
                            radius: 30,
                          ),
                          SizedBox(width: 20,),
                          Text(
                            'Chapter ${index + 1} - ${widget.list[index].judul_chapter}',
                            style: TextStyle(
                                color: ColorsRes.appColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            );
          },
        )
      )
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
                  icon: Icon(Icons.arrow_back_ios_rounded),
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