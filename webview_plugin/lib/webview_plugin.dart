import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';

class WebviewPlugin {
  static const MethodChannel _channel = const MethodChannel('webview_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  //声明plugin加载的方法，参数为url，callback回调，和可选参数Rect（控制）plugin的大小
  Future<Null> launch(
      String url,
      Function callback, {
        Rect rect,
      }) async {
    Map<String, dynamic> args = {
      "url": url,
    };
    if (rect != null) {
      args["rect"] = {
        "left": rect.left,
        "top": rect.top,
        "width": rect.width,
        "height": rect.height
      };
    }
    final String result = await _channel.invokeMethod('load', args);

    if (callback != null) {
      callback(result);
    }
  }
}
