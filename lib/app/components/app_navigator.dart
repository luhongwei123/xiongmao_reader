import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:xiongmao_reader/app/components/public.dart';
import 'package:xiongmao_reader/app/pages/books/books_search.dart';
import 'package:xiongmao_reader/app/pages/recommends/games/game_2048.dart';
import 'package:xiongmao_reader/app/pages/recommends/little_tools/jokes_scene.dart';
import 'package:xiongmao_reader/app/pages/recommends/little_tools/news_info_details.dart';
import 'package:xiongmao_reader/app/pages/recommends/little_tools/today_news.dart';
import 'package:xiongmao_reader/app/pages/recommends/little_tools/video_scene.dart';
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
  
  static toVideo(BuildContext context,String url,String title){
      AppNavigator.push(context, VideoPlayerScene(url,title));
  }


  //小说搜索、
  static toSeacher(BuildContext context){
     AppNavigator.push(context, BooksSearchScene());
  }

 static toNews(BuildContext context){
     AppNavigator.push(context, TodayNews());
  }

   static toNewsDetails(BuildContext context,Map map){
     AppNavigator.push(context, NewsInfoDetails(map));
  }

  static toJokes(BuildContext context){
    AppNavigator.push(context, JokesScene());
  }
}
