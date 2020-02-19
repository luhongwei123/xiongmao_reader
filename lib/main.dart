import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xiongmao_reader/app/home/app_scene.dart';
// List<String> list = [
//     "https://福利之家.com/?addfb",
//     "https://tiaozhuandaofuli.space/?addfb",
//     "https://onedh.xyz/?addfb",
//     "https://第一福利导航.com/?addfb",
//   ];
void main(){
  runApp(AppScene());
  if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness:Brightness.light
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
}


