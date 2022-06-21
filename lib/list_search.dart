
import 'package:ebooks/helper/colors_res.dart';
import 'package:ebooks/helper/data.dart';
import 'package:ebooks/helper/transition.dart';
import 'package:ebooks/list_chapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper/model.dart';

class ListSearch extends StatefulWidget {
  _ListSearch createState() => _ListSearch();
}

class _ListSearch extends State<ListSearch> {
  bool typing = false;
  TextEditingController _textController = TextEditingController();
  String query = "";
  List<ListHome> _list = [];

  void searchingData(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _list = Datas.data.where((element) => element.name_book.contains(query)).toList();
      });
    } else {
      setState(() {
        _list.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsRes.appColor,
        title: typing 
            ? Text('Search Book')
            : TextField(
          style: TextStyle(
            color: ColorsRes.white,
            fontSize: 18,
          ),
          cursorColor: ColorsRes.white,
          autocorrect: true,
          controller: _textController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Colors.white60,
              fontSize: 18,
            ),
          ),

          onChanged: (text) {
            searchingData(text);
          },
        ),

        actions: [
          IconButton(
            icon: Icon(typing ? Icons.search : Icons.clear),
            onPressed: () {
              setState(() {
                typing = !typing;
                _textController.clear();
                query = "";
              });
            },
          )
        ],
      ),

      body: ListView.builder(
        itemCount: _list.length,
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  SlideLeftRoute(page: ChapterPage(
                    name_book: _list[index].name_book,
                    list: _list[index].list,
                  ))
              );
            },

            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.13,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  side: BorderSide(
                    color: ColorsRes.black.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                elevation: 2,
                child: Center(
                  child: Text(
                    '${_list[index].name_book}',
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
          );
        },
      ),
    );
  }
}