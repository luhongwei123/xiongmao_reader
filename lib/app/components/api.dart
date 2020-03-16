 
/// 请求API
class API {
  /// 请求地址
  static final String basicApi = "http://api01.6bqb.com";

  /// 这是99api的头条接口
  static final String getMessage = basicApi + "/toutiao/search";

  static const String baseApi = "https://www.mxnzp.com/api";
  static const String app_id = "qgocoridmpliotoi";
  static const String app_secret = "eDZYS1ZpRlRLTGRwNE5udHNXSlRFQT09";

  static const String getMessageTypes = baseApi +'/news/types?app_id='+app_id+"&app_secret="+app_secret;

  static const String getMessageList = baseApi +'/news/list?app_id='+app_id+"&app_secret="+app_secret;
}