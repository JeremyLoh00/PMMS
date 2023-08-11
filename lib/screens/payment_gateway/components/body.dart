import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Body extends StatefulWidget {
  final String? billId;
  final ValueSetter<WebViewController> callBackSetWebViewController;
  const Body({
    super.key,
    this.billId,
    required this.callBackSetWebViewController,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int delayAnimationDuration = 200;
  late String url;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // url = "https://google.com";
    url = devToyyibPay + widget.billId!;
    print(url);
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
                widget.callBackSetWebViewController(webViewController);
              },
              onProgress: (int progress) {
                print('WebView is loading (progress : $progress%)');
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
              gestureNavigationEnabled: true,
              backgroundColor: kWhite,
            ),
          ),
        ],
      ),
    );
  }
}
