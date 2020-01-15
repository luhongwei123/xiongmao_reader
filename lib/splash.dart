import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';
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
    return new Image.asset(
      'asset/template.png',
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
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
          Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => new HomeScene()
                  ), (route) => route == null);
                },
                child: new Container(
                  padding: EdgeInsets.all(12.0),
                  child: new Text(
                    '跳转 $_count',
                    style: new TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                  decoration: new BoxDecoration(
                    color: AppColor.paper,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: new Border.all(
                      width: 0.33, color: Colors.grey))),
              ),
            ),
        ],
      ),
    );
  }
}