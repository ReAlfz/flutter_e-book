import 'dart:convert';

import 'package:ebooks/helper/colors_res.dart';
import 'package:ebooks/helper/setting.dart';
import 'package:ebooks/helper/transition.dart';
import 'package:ebooks/list_chapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'helper/model.dart';

class ListSearch extends StatefulWidget {
  _ListSearch createState() => _ListSearch();
}

class _ListSearch extends State<ListSearch> {
  bool typing = false;
  TextEditingController _textController = TextEditingController();
  String query = "";
  List<ListHome> _list = [];

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
            text = text.toLowerCase();
            setState(() {
              query = text;
              _list = _list.where((element){
                var data = element.name_book.toLowerCase();
                return data.contains(query);
              }).toList();
            });
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

      body: FutureBuilder<Base>(
        future: secondConfigure(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Base? base = snapshot.data;
            (query.isEmpty)
                ? _list = base!.listed.toList()
                : _list = _list.where((element)
            => element.name_book.toLowerCase().contains(query.toLowerCase())
                && element.name_book.toLowerCase().startsWith(query.toLowerCase())
            ).toList();
            return ListView.builder(
              itemCount: _list.length,
              padding: EdgeInsets.all(5),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    switch (Setting.opsi_ad) {
                      case 1:
                        Setting.showInterstitial();
                        break;

                      default:
                    }

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
            );
          }

          return Center(
            child: Text('loading...'),
          );
        },
      ),
    );
  }

  Future<Base> secondConfigure() async {
    final response = await http.get(Uri.parse(Setting.data));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return Base.fromJson(jsonData);
    } else {
      throw secondConfigure();
    }
  }
}