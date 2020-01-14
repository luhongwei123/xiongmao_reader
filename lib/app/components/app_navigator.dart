import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/home/home_scene.dart';
import 'package:xiongmao_reader/app/pages/books/details/novel_detail_scene.dart';
import 'package:xiongmao_reader/app/pages/books/details/novel_titles_scene.dart';
import 'package:xiongmao_reader/app/pages/books/reader/novel_reader_scene.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }
  static toHome(BuildContext context){
    AppNavigator.push(context, HomeScene());
  }
  /*
   * 跳转到小说详情页面
   */
  static toNovelDetail(BuildContext context){
      AppNavigator.push(context, NovelDetailScene());
  }

   /*
   * 跳转到小说章节目录页面
   */
  static toNovelTitles(BuildContext context){
      AppNavigator.push(context, NovelTitlesScene());
  }
  
  /*
   * 跳转到小说阅读页面
   */
  static toNovelReaders(BuildContext context,String artId){
      AppNavigator.push(context, NovelReaderScene(artId:artId));
  }
}
