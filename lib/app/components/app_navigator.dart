import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/pages/books/details/novel_detail_scene.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }
  /*
   * 跳转到小说详情页面
   */
  static toNovelDetail(BuildContext context){
      AppNavigator.push(context, NovelDetailScene());
  }
  
}
