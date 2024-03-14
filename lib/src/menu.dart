import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

bool menuopen = false;

class Menu extends StatefulWidget {
  const Menu({required this.controller, super.key});

  final WebViewController controller;

  @override
  State<Menu> createState() => _MenuState();
}


class _MenuState extends State<Menu> {
  final cookieManager = WebViewCookieManager();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (!menuopen) {
          await widget.controller.runJavaScript('''
            document.querySelector(".right").click();
            
              ''');
          menuopen = true;
        } else {
          await widget.controller.runJavaScript('''
            document.querySelector(".darklayer").click();
            
              ''');
          menuopen = false;
        }
      },
      icon: Icon(Icons.menu),
    );
  }

}