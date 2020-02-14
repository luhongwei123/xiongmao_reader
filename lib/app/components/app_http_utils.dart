import 'dart:convert';

import 'package:dio/dio.dart';

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
      try{
        response  = await dio.get(path,queryParameters: params);
      }catch(e){
        return e;
      }
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
      try{
        response  = await dio.get(path,queryParameters: params);
      }catch(e){
        return e;
      }
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
      try{
        response  = await dio.get(path,queryParameters: params);
      }catch(e){
        return e;
      }
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
      try{
        response  = await dio.get(path,queryParameters: params);
      }catch(e){
        return e;
      }
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
      try{
        response  = await dio.get(path,queryParameters: params);
      }catch(e){
        return e;
      }
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
      try{
        response  = await dio.get(path,queryParameters: params);
      }catch(e){
        return e;
      }
      var data = response.data;
      return json.decode(data);
  }
}