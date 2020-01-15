import 'package:flutter/material.dart';

import '../../splash.dart';


class AppScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
      ),
      home: SplashPage(),
    );
  }
}