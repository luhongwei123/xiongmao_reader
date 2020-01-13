import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReaderMenuScene extends StatefulWidget {
  final VoidCallback onTap;

  ReaderMenuScene({this.onTap});
  @override
  _ReaderMenuSceneState createState() => _ReaderMenuSceneState();
}

class _ReaderMenuSceneState extends State<ReaderMenuScene> with SingleTickerProviderStateMixin{

  @override
  initState() {
    super.initState();

  }

  hide() {
    Timer(Duration(milliseconds: 200), () {
      this.widget.onTap();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (_) {
              hide();
            },
            child: Container(color: Colors.transparent),
          ),
          buildTopView(context),
          buildBottomView(),
        ],
      ),
    );
  }
  buildTopView(BuildContext context) {
    return Positioned(
      top: MediaQueryData.fromWindow(window).padding.top,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
        height:ScreenUtil().setHeight(80),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('asset/readers/pub_back_gray.png'),
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: 44,
              child: Image.asset('asset/readers/read_icon_voice.png'),
            ),
            Container(
              width: 44,
              child: Image.asset('asset/readers/read_icon_more.png'),
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
        children: <Widget>[
          // buildProgressTipView(),
          Container(
            decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
            padding: EdgeInsets.only(bottom: ScreenUtil.bottomBarHeight),
            child: Column(
              children: <Widget>[
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
      children: <Widget>[
        buildBottomItem('目录', 'asset/readers/read_icon_catalog.png'),
        buildBottomItem('亮度', 'asset/readers/read_icon_brightness.png'),
        buildBottomItem('字体', 'asset/readers/read_icon_font.png'),
        buildBottomItem('设置', 'asset/readers/read_icon_setting.png'),
      ],
    );
  }

  buildBottomItem(String title, String icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: <Widget>[
          Image.asset(icon),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 12, color: Color(0xFF333333))),
        ],
      ),
    );
  }
}