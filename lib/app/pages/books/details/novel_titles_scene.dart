import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';
import 'package:xiongmao_reader/app/model/article_model.dart';

class NovelTitlesScene extends StatefulWidget {
  final Article article;
  NovelTitlesScene({
    this.article
  });

  @override
  _NovelTitlesSceneState createState() => _NovelTitlesSceneState();
}

class _NovelTitlesSceneState extends State < NovelTitlesScene > {
  List list;
  String title;

  @override
  void initState() {
    super.initState();
    //根据小说id 查询
    list = [{
        "novelId": "0000",
        "title": "第一章 落魄少年"
      },
      {
        "novelId": "0001",
        "title": "第二章 不吃霸王餐"
      },
      {
        "novelId": "0002",
        "title": "第三章 设计"
      }
    ];
    title = this.widget.article.title;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(IconData(0xe314, fontFamily: 'MaterialIcons'), color: AppColor.darkGray, ),
        ),
        centerTitle: true,
        title: Text(title, style: TextStyle(color: AppColor.darkGray), ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: CupertinoScrollbar(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    AppNavigator.toNovelReaders(context, this.widget.article,list[index]['novelId']);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                    child: Text(list[index]['title']),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemCount: list.length),
          ),
        ),

      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    } else {
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}