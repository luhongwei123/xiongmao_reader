import 'package:flutter/foundation.dart';
import 'http.dart';

/// 网络请求
class Request {
  static Http http = Http();

  /// 下载文件
  static Future<bool> downloadFile(
      {@required String url,
        @required String path,
        @required onProgress(int count, int total),
        @required onError(int code, String message)}) async {
    var response = await Http(hasTimeout: false).downloadFile(
        url: url, path: path, onProgress: onProgress, onError: onError);

    if (response) {
      return true;
    } else {
      // response为null,表示网络出错,
      // onError()方法会在http.post()内调用.
      return false;
    }
  }
}