import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart' show AndroidWebViewPlatform;
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

void initWebViewPlatform() {
  if (Platform.isAndroid) {
    WebViewPlatform.instance = AndroidWebViewPlatform();
  } else if (Platform.isIOS) {
    WebViewPlatform.instance = WebKitWebViewPlatform();
  }
}
