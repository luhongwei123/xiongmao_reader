import 'dart:async';

import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/logo.dart';
import 'package:xiongmao_reader/app/home/home_scene.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State < SplashPage > {

  int _count = 3; // 倒计时秒数
  Timer _timer;

  @override
  void initState() {
    super.initState();
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {
        if (_count <= 0) {
          _timer.cancel();
          _timer = null;
          Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => new HomeScene()
                  ), (route) => route == null);
        } else {
          _count = _count - 1;
        }
      });
    });
  }
  
  // 构建闪屏背景
  Widget _buildSplashBg() {
    return Container(
      color: AppColor.white,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: < Widget > [
          _buildSplashBg(),
          //广告位
          Logo()
        ],
      ),
    );
  }
}