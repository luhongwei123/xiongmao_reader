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

        print(e);
        return 'error';
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

        print(e);
        return 'error';
      }
      var data = response.data;
      return json.decode(data);
  }
}