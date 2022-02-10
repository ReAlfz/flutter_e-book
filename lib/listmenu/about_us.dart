import 'package:ebooks/helper/colors_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About_Us extends StatefulWidget {
  @override
  _About_UsState createState() => _About_UsState();
}

class _About_UsState extends State<About_Us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
              top: 15,
              right: 15,
              left: 10,
            ),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: new TextStyle(
                  color: ColorsRes.black,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  new TextSpan(
                    text: 'Welcome to ',
                  ),
                  new TextSpan(
                    text: 'Offline Book Application \n \n',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new TextSpan(
                    text: 'Best Android & iOS app for reading a book is here. We guarantee you the best reading experience for you. \n \n',
                  ),
                  new TextSpan(
                    text: 'Made with ❤ by ',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new TextSpan(
                    text: 'WRTeam ',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}