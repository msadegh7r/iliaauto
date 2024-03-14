import 'menu.dart' as menu;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key});
  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}
class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;
  @override
  void initState() {
    super.initState();
    widget.controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              menu.menuopen=false;
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onNavigationRequest: (navigation) {
            final host = Uri.parse(navigation.url).host;
            /* if (host.contains('borgward-iran.com')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Blocking navigation to $host',
                  ),
                ),
              );
              return NavigationDecision.prevent;
            }*/
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: widget.controller,
        ),
        if (loadingPercentage < 100)
          Container(
            color: Colors.white,
            child: Center(
              child: Container(
                width: 30,
                child: LinearProgressIndicator(
                  color: Colors.yellow,
                  value: loadingPercentage / 100.0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
