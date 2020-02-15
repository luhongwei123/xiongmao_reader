import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/public.dart';
import 'package:xiongmao_reader/app/pages/recommends/games/game_2048.dart';

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
  static toNovelDetail(BuildContext context,Map map){
      AppNavigator.push(context, NovelDetailScene(article:map));
  }

   /*
   * 跳转到小说章节目录页面
   */
  static toNovelTitles(BuildContext context,Article article){
      AppNavigator.push(context, NovelTitlesScene(article:article));
  }
  
  /*
   * 跳转到小说阅读页面
   */
  static toNovelReaders(BuildContext context,Article article,Map map,int index){
      AppNavigator.push(context, NovelReaderScene(index,article:article,map: map));
  }


  /*
   * 跳转到小说阅读页面
   */
  static toWeather(BuildContext context){
      AppNavigator.push(context, WeatherScene());
  }
  
  static toGame_2048(BuildContext context){
      AppNavigator.push(context, GameScene());
  }
}
