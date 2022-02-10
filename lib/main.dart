// @dart=2.9
import 'dart:async';
import 'dart:convert';

import 'package:ebooks/helper/setting.dart';
import 'package:ebooks/home.dart';
import 'package:ebooks/helper/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<Config> firstConfigure() async {
    var url = utf8.decode(base64Url.decode('aHR0cHM6Ly9hcGkubnBvaW50LmlvLzBjNmRjMDAwY2UyYTU5OGNkMWMy'));
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return Config.fromJson(jsonData);
    } else {
      throw firstConfigure();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Config>(
        future: firstConfigure(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Config configure = snapshot.data;
            print(configure.appMode);
            if (configure.appMode == true) {
              Setting.getConfigure(configure);
              Timer(
                const Duration(seconds: 5),
                  () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                          data: configure.data,
                        )
                    ),
                  ),
              );

              return Container(
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
              );
            }
          }

          return Center(
            child: Text('loading'),
          );
        }
      ),
    );
  }
}
