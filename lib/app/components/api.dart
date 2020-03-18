 
/// 请求API
class API {

  static const String baseApi = "https://www.mxnzp.com/api";
  static const String app_id = "qgocoridmpliotoi";
  static const String app_secret = "eDZYS1ZpRlRLTGRwNE5udHNXSlRFQT09";

  static const String getMessageTypes = baseApi +'/news/types?app_id='+app_id+"&app_secret="+app_secret;

  static const String getMessageList = baseApi +'/news/list?app_id='+app_id+"&app_secret="+app_secret;

  static const String getMessageDetails = baseApi +'/news/details?app_id='+app_id+"&app_secret="+app_secret;
}