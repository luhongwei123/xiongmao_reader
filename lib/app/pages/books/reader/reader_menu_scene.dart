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
          // buildBottomView(),
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
}