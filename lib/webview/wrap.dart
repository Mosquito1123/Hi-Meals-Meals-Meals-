import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WrapScreen extends StatefulWidget {
  final url;
  WrapScreen(this.url);

  @override
  _WrapState createState() {
    // TODO: implement createState
    return _WrapState(this.url);
  }
}

class _WrapState extends State<WrapScreen> {
  final _url;
  Completer<WebViewController> _controller = Completer<WebViewController>();
  _WrapState(this._url);

  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    print('++++++++wrap$_url');
    // TODO: implement build
    return new Scaffold(
          body: Builder(builder: (BuildContext context) {
                  return WebView(
                    initialUrl: _url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    // TODO(iskakaushik): Remove this when collection literals makes it to stable.
                    // ignore: prefer_collection_literals
                  
                    navigationDelegate: (NavigationRequest request) {
                      if (request.url.startsWith('itms-services://')) {
                        print('blocking navigation to $request}');
                        _callMe(request.url);
                        return NavigationDecision.prevent;
                      }
                      print('allowing navigation to $request');
                      return NavigationDecision.navigate;
                    },
                    onPageFinished: (String url) {
                      print('Page finished loading: $url');
                    },
                  );
                }),
  
);
    
    // return new WebviewScaffold(
    //   supportMultipleWindows: true,
    //   url: _url,
    //   withJavascript: true,
      
    // );
  }

_callMe(String string) async {
    // Android
    var uri = string;
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      var uri = string;
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}