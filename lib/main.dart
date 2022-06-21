// @dart=2.9
import 'dart:async';

import 'package:ebooks/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  initState(){
    Timer(
      const Duration(seconds: 5),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Home()
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),

                  Image.asset("assets/image/splash_logo.png"),
                  SizedBox(
                    height: 25,
                  ),

                  Text('App name',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Text('E-book App',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/image/books_splash.png")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
