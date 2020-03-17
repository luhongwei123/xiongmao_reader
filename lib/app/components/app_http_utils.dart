import 'dart:convert';

import 'package:dio/dio.dart';

import 'api.dart';
import 'http_request.dart';

class HttpUtils{
  
  static Future getHot() async{
      Map<String,Object> params = {};
      params['isRandom'] = false;
      params['limit'] = 5;
      params['page'] = 1;
      var dio = Request.getDio();
      String path = Request.baseUrl + 'list';
      Response<String> response ;
      // try{
        response  = await dio.get(path,queryParameters: params);
      // }catch(e){
      //   return e;
      // }
      var data = response.data;
      return json.decode(data);
  }
   static Future getCatalogListByLimit(String id,int page) async{
      Map<String,Object> params = {};
      params['bookId'] = id;
      params['limit'] = 20;
      params['page'] = page;
      var dio = Request.getDio();
      String path = Request.baseUrl + 'catalogList';
      Response<String> response ;
      // try{
        response  = await dio.get(path,queryParameters: params);
      // }catch(e){
      //   return e;
      // }
      var data = response.data;
      return json.decode(data);
  }

  static Future getCatalogList(String id,int page) async{
      Map<String,Object> params = {};
      params['bookId'] = id;
      params['limit'] = 1;
      params['page'] = page;
      var dio = Request.getDio();
      String path = Request.baseUrl + 'catalogList';
      Response<String> response ;
      // try{
        response  = await dio.get(path,queryParameters: params);
      // }catch(e){
      //   return e;
      // }
      var data = response.data;
      return json.decode(data);
  }

  static Future getCatalog(int bookId,int catalogId,int number) async{
      Map<String,Object> params = {};
      params['bookId'] = bookId;
      params['catalogId'] = catalogId;
      params['num'] = number;
      var dio = Request.getDio();
      String path = Request.baseUrl + 'catalog';
      Response<String> response ;
      // try{
        response  = await dio.get(path,queryParameters: params);
      // }catch(e){
      //   return e;
      // }
      var data = response.data;
      return json.decode(data);
  }

  static Future getList(String type,int limit,int page) async{
      Map<String,Object> params = {};
      params['isRandom'] = false;
      params['limit'] = limit;
      params['page'] = page;
      params['bookType'] = type;
      var dio = Request.getDio();
      String path = Request.baseUrl + 'list';
      Response<String> response ;
      // try{
        response  = await dio.get(path,queryParameters: params);
      // }catch(e){
      //   return e;
      // }
      var data = response.data;
      return json.decode(data);
  }

  static Future getListbyName(String bookName) async{
      Map<String,Object> params = {};
      params['isRandom'] = false;
      params['limit'] = 10;
      params['page'] = 1;
      params['bookName'] = bookName;
      var dio = Request.getDio();
      String path = Request.baseUrl + 'list';
      Response<String> response ;
      // try{
        response  = await dio.get(path,queryParameters: params);
      // }catch(e){
      //   return e;
      // }
      var data = response.data;
      return json.decode(data);
  }

  static Future getRecentBook(int bookId) async{
      Map<String,Object> params = {};
      params['isRandom'] = false;
      params['limit'] = 1;
      params['page'] = 1;
      params['bookId'] = bookId;
      var dio = Request.getDio();
      String path = Request.baseUrl + 'list';
      Response<String> response ;
      // try{
        response  = await dio.get(path,queryParameters: params);
      // }catch(e){
      //   return e;
      // }
      var data = response.data;
      return json.decode(data);
  }


  //获取当前城市天气
  static Future getCurrentWeather(String cityName) async{
    Map<String,Object> params = {};
    params['app_id'] = Request.app_id;
    params['app_secret'] = Request.app_secret;
    var dio = Request.getDio();
    String path = Request.baseApi + '/weather/current/'+cityName;
    Response<String>  response  = await dio.get(path,queryParameters: params);
    var data = response.data;
    return json.decode(data);
  }
  //获取当前城市未来天气
  static Future getForecastWeather(String cityName) async{
    Map<String,Object> params = {};
    params['app_id'] = Request.app_id;
    params['app_secret'] = Request.app_secret;
    var dio = Request.getDio();
    String path = Request.baseApi + '/weather/forecast/'+cityName;
    Response<String>  response  = await dio.get(path,queryParameters: params);
    var data = response.data;
    return json.decode(data);
  }
   //获取新闻类型
  static Future getMsgTypes()async{
    Response<String>  response = await Request.getDio().get(API.getMessageTypes);
    var data = response.data;
    return json.decode(data);
  }

  //获取新闻列表
  static Future getMsgList(int id,int index)async{
    Response<String>  response = await Request.getDio().get(API.getMessageList+"&typeId=$id&page=$index");
    var data = response.data;
    return json.decode(data);
  }
}