import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xiongmao_reader/app/home/app_scene.dart';
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


