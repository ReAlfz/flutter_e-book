import 'package:ebooks/helper/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Privacy_Policy extends StatefulWidget {
  @override
  _Privacy_Policy createState() => _Privacy_Policy();
}

class _Privacy_Policy extends State<Privacy_Policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Privacy Policy'),
      ),
      body: WebView(
        initialUrl: Setting.html_privacy,
        onProgress: (int process) {
          Center(
            child: Text('Loading...'),
          );
        },
      ),
    );
  }
}