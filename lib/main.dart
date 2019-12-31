import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/home/home_scene.dart';

void main(){
  runApp(MyApp());
  if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness:Brightness.dark
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'UI Kit',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
      ),
      home: HomeScene(),
    );
    
  }
}


