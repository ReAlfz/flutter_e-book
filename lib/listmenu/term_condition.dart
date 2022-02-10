import 'package:ebooks/helper/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Terms_Condition extends StatefulWidget {
  @override
  _Terms_Condition createState() => _Terms_Condition();
}

class _Terms_Condition extends State<Terms_Condition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Terms & Conditions'),
      ),

      body: WebView(
        initialUrl: Setting.html_condition,
        onProgress: (int process) {
          Center(
            child: Text('Loading...'),
          );
        },
      ),
    );
  }
}