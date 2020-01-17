import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReaderMenuScene extends StatefulWidget {
  final VoidCallback onTap;
  final VoidCallback isNighttime;
  bool _isNighttime;

  ReaderMenuScene(this._isNighttime, {
    this.onTap,
    this.isNighttime,
  });
  @override
  _ReaderMenuSceneState createState() => _ReaderMenuSceneState();
}

class _ReaderMenuSceneState extends State < ReaderMenuScene > with SingleTickerProviderStateMixin {
  static final double _sImagePadding = ScreenUtil().setWidth(30);
  int _duration = 200;
  bool _isNighttime = false;

  @override
  initState() {
    super.initState();
    setState(() {
      _isNighttime = this.widget._isNighttime;
    });
  }
  hide() {
    Timer(Duration(milliseconds: 200), () {
      this.widget.onTap();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isNighttime ? Colors.black : Colors.white,
      child: Stack(
        children: < Widget > [
          GestureDetector(
            onTapDown: (_) {
              SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
                statusBarColor: _isNighttime ? Colors.black : Colors.transparent,
                statusBarBrightness: _isNighttime ? Brightness.dark : Brightness.light
              );
              SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
              hide();
            },
            // child: Container(color: Colors.transparent),
          ),
          buildTopView(context),
          buildBottomView(),
        ],
      ),
    );
  }
  buildTopView(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: _isNighttime ? Color(0xFF333333) : Color(0xFFF5F5F5),
      statusBarBrightness: _isNighttime ? Brightness.dark : Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return Positioned(
      top: MediaQueryData.fromWindow(window).padding.top,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(color: _isNighttime ? Color(0xFF333333) : Color(0xFFF5F5F5)),
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Row(
          children: < Widget > [
            Container(
              width: 44,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('asset/readers/pub_back_gray.png', color: _isNighttime ? Colors.white : Colors.black, ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: 44,
              child: Image.asset('asset/readers/read_icon_voice.png', color: _isNighttime ? Colors.white : Colors.black),
            ),
            Container(
              width: 44,
              child: Image.asset('asset/readers/read_icon_more.png', color: _isNighttime ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  buildBottomView() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: < Widget > [
          Container(
            width: _sImagePadding * 2,
            height: _sImagePadding * 2,
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0, 0, 0),
            child: AnimatedPadding(
              duration: Duration(milliseconds: _duration),
              padding: EdgeInsets.all(1),
              child: InkWell(
                splashColor: Colors.white,
                onTap: () {
                  this.widget.isNighttime();
                  setState(() {
                    _isNighttime = !_isNighttime;
                  });
                },
                child: Image.asset(
                  _isNighttime ?
                  "asset/readers/icon_content_daytime.png" :
                  "asset/readers/icon_content_nighttime.png",
                  height: 36,
                  width: 36,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: _isNighttime ? Color(0xFF333333) : Color(0xFFF5F5F5)),
            padding: EdgeInsets.only(bottom: ScreenUtil.bottomBarHeight),
            child: Column(
              children: < Widget > [
                // buildProgressView(),
                buildBottomMenus(),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildBottomMenus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: < Widget > [

        buildBottomItem('目录', 'asset/readers/read_icon_catalog.png'),
        buildBottomItem('亮度', 'asset/readers/read_icon_brightness.png'),
        // buildBottomItem('字体', 'asset/readers/read_icon_font.png'),
        buildBottomItem('设置', 'asset/readers/read_icon_setting.png'),
      ],
    );
  }

  buildBottomItem(String title, String icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: < Widget > [
          Image.asset(icon, color: _isNighttime ? Colors.white : Colors.black),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 12, color: _isNighttime ? Colors.white : Colors.black)),
        ],
      ),
    );
  }
}