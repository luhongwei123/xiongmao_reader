import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class RecommendScene extends StatefulWidget {
  @override
  _RecommendSceneState createState() => _RecommendSceneState();
}

class _RecommendSceneState extends State<RecommendScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(0),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
        children: <Widget>[
          FloorTitle(title: "实用集合"),
          Container(
            child: GridView.count(
              crossAxisCount: 5,
              physics: new NeverScrollableScrollPhysics(), //增加
              shrinkWrap: true, //增加
              padding: EdgeInsets.all(5),
              children: _buildNavigator(context),
            ),
          ),
          FloorTitle(title: "轻松一刻"),
          Container(
            child: GridView.count(
              crossAxisCount: 5,
              physics: new NeverScrollableScrollPhysics(), //增加
              shrinkWrap: true, //增加
              padding: EdgeInsets.all(5),
              children: _buildGames(context),
            ),
          ),
        ],
      )
    );
  }

  //appbar
  Widget _buildAppBar(int index) {
    var appbar;
    switch (index) {
      case 0:
        appbar = new AppBar(
          elevation: 0,
          title: new Text("精选推荐", style: new TextStyle(color: AppColor.red)),
          iconTheme: new IconThemeData(color: Colors.white),
          backgroundColor: AppColor.paper,
          brightness: Brightness.light,
          // actions: [
          //   IconButton(
          //     padding:EdgeInsets.all(0),
          //     icon: Icon(CupertinoIcons.search),
          //     iconSize: 24,
          //     onPressed: () => {},
          //     splashColor: Colors.transparent,
          //     highlightColor:Colors.transparent
          //   ),
          //   IconButton(
          //     padding:EdgeInsets.all(4),
          //     icon: Icon(CupertinoIcons.time),
          //     iconSize: 24,
          //     onPressed: () => {},
          //     splashColor: Colors.transparent,
          //     highlightColor:Colors.transparent
          //   ),
          //   IconButton(
          //     padding:EdgeInsets.all(0),
          //     icon: Icon(CupertinoIcons.ellipsis),
          //     iconSize: 24,
          //     onPressed: () => {},
          //     splashColor: Colors.transparent,
          //     highlightColor:Colors.transparent
          //   ),
          // ],
        );
        break;
    }
    return appbar;
  }
  List<Widget> _buildNavigator(BuildContext context) {
    List<Widget> list = [];
    // list.add(FloorTitle(title: "实用工具",));
    var tianqi = InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap:(){
        // _onClickWeather(context);
        AppNavigator.toWeather(context);
      },
      child: Column(
        children: <Widget>[
          Image.asset("asset/recommends/tianqi.png",
              width: ScreenUtil().setWidth(80)),
          SizedBox(height:10),
          Text('今日天气'),
        ],
      ),
    );
    list.add(tianqi);
    var kaixin = InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
      child: Column(
        children: <Widget>[
          Image.asset("asset/recommends/kaixin.png",
              width: ScreenUtil().setWidth(80)),
          SizedBox(height:10),
          Text('开心一刻'),
        ],
      ),
    );
    list.add(kaixin);
    var news = InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
      child: Column(
        children: <Widget>[
          Image.asset("asset/recommends/news.png",
              width: ScreenUtil().setWidth(80)),
          SizedBox(height:10),
          Text('今日头条'),
        ],
      ),
    );
    list.add(news);
    var rubbish = InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
      child: Column(
        children: <Widget>[
          Image.asset("asset/recommends/laji.png",
              width: ScreenUtil().setWidth(80)),
          SizedBox(height:10),
          Text('垃圾分类'),
        ],
      ),
    );
    list.add(rubbish);
    var kuaidi = InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
      child: Column(
        children: <Widget>[
          Image.asset("asset/recommends/kuaidi.png",
              width: ScreenUtil().setWidth(80)),
          SizedBox(height:10),
          Text('快递查询'),
        ],
      ),
    );
    list.add(kuaidi);
    return list;
  }

  List<Widget> _buildGames(BuildContext context) {
    List<Widget> list = [];
    // list.add(FloorTitle(title: "实用工具",));
    var game_2048 = InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        AppNavigator.toGame_2048(context);
      },
      child: Column(
        children: <Widget>[
          Image.asset("asset/recommends/2048.png",
              width: ScreenUtil().setWidth(80)),
          SizedBox(height:10),
          Text('2048'),
        ],
      ),
    );
    list.add(game_2048);
    return list;
  }
}
