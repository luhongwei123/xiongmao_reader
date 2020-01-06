import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/pages/book_scene.dart';
import 'package:xiongmao_reader/app/pages/mine_scene.dart';
import 'package:xiongmao_reader/app/pages/recommend_scene.dart';
import 'package:xiongmao_reader/app/pages/video_scene.dart';


class HomeScene extends StatefulWidget {
  @override
  _HomeSceneState createState() => _HomeSceneState();
}

class _HomeSceneState extends State < HomeScene > {
  List < Widget > _widgetList = [
    //推荐页面
    RecommendScene(),
    //书城
    BookScene(),
    //视频
    VideoScene(),
    //我的
    MineScene()
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    //width: 750,height: 1334
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return Scaffold(
      appBar: _buildAppBar(_index),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
            ),
            title: Text('推荐', style: TextStyle())),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.book,
            ),
            title: Text('书城', style: TextStyle())),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.video_camera,
            ),
            title: Text('视频', style: TextStyle())),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person,
            ),
            title: Text(
              '我的',
              style: TextStyle(),
            ))
        ],
      ),
      body: _widgetList[_index],
    );
  }
}

//appbar
Widget _buildAppBar(int index) {
  var appbar;
    switch (index) {
      case 0:
        appbar = new AppBar(
          elevation: 0,
          title: new Text("熊猫书城",style: new TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white),
          backgroundColor: Colors.amber,
          brightness: Brightness.dark,
          actions: [
            IconButton(
              padding:EdgeInsets.all(0),
              icon: Icon(CupertinoIcons.search),
              iconSize: 24,
              onPressed: () => {},
              splashColor: Colors.transparent,
              highlightColor:Colors.transparent
            ),
            IconButton(
              padding:EdgeInsets.all(4),
              icon: Icon(CupertinoIcons.time),
              iconSize: 24,
              onPressed: () => {},
              splashColor: Colors.transparent,
              highlightColor:Colors.transparent
            ),
            IconButton(
              padding:EdgeInsets.all(0),
              icon: Icon(CupertinoIcons.ellipsis),
              iconSize: 24,
              onPressed: () => {},
              splashColor: Colors.transparent,
              highlightColor:Colors.transparent
            ),
          ],
        );
        break;
      // case 1:
      //   appbar = new AppBar(
      //     elevation: 0.0,
      //     backgroundColor: Colors.white,
      //     brightness: Brightness.light,
      //     title: TabBar(
      //       controller: controller, //可以和TabBarView使用同一个TabController
      //       tabs: tabs,
      //       isScrollable: true,
      //       indicator: UnderlineTabIndicator(
      //         borderSide: BorderSide(width: 0.0, color: Colors.white),
      //         insets: EdgeInsets.zero,
      //       ),
      //       indicatorWeight: 0.01,
      //       indicatorSize: TabBarIndicatorSize.tab,
      //       indicatorPadding: EdgeInsets.zero,
      //       labelPadding: EdgeInsets.only(left: 20),
      //       labelColor: Colors.pinkAccent,
      //       labelStyle: TextStyle(
      //         fontSize: 25.0,
      //       ),
      //       unselectedLabelColor: Colors.black38,
      //       unselectedLabelStyle: TextStyle(
      //         fontSize: 18.0,
      //       ),
      //     ),
      //   );
      //   break;
      // case 2:
      //   appbar = new SearchAppBarWidget(
      //     focusNode: FocusNode(),
      //     controller: new TextEditingController(),
      //     elevation: 2.0,
      //     inputFormatters: [
      //       LengthLimitingTextInputFormatter(50),
      //     ],
      //     onEditingComplete: () => {});
      //   break;
    }
    return appbar;
}