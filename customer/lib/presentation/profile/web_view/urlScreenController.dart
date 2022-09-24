import 'dart:async';
import 'dart:io';

import 'package:acoride/core/helper/helper_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);
  final String data;
  final String title;
  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(widget.title,style: HelperStyle.textStyle(
            context,
            Colors.black,
            14,
            FontWeight.w400),),
        material: (_, __) => MaterialAppBarData(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          //automaticallyImplyLeading: true,
        ),
        automaticallyImplyLeading: true,
      ),
      iosContentBottomPadding: true,
      iosContentPadding: true,
      backgroundColor: const Color(0xff363A3B),
      body: SafeArea(
        top: Platform.isIOS? false : true,
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          initialUrl: widget.data,
          onProgress: (int progress) {
            //priint("WebView is loading (progress : $progress%)");
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

}
