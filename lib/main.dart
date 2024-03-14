import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'src/menu.dart';

import 'src/web_view_stack.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://ilia-auto.com'),
      );
  }

  @override
  Widget build(BuildContext context) {
    late final WebViewCookieManager cookieManager = WebViewCookieManager();
    Future<void> _AddCookie() async {
      await cookieManager.setCookie(
        const WebViewCookie(
          name: 'iamsrflutterapp',
          value: '1',
          domain: 'https://ilia-auto.com',
          path: '/',
        ),
      );
    }

    _AddCookie();
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: Image.asset('assets/images/ilialogo.png',width: 90,),
          iconSize: 5,
          onPressed: () async{
            setState(() {
               controller.loadRequest(
                  Uri.parse('https://ilia-auto.com'),
              );
            });
          },
        ),
        actions: [
          Menu(controller: controller),
        ],

      ),
      body: WebViewStack(controller: controller),
    );
  }
}
