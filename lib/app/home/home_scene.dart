import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/public.dart';
import 'package:xiongmao_reader/app/pages/message_scene.dart';


class HomeScene extends StatefulWidget {
  @override
  _HomeSceneState createState() => _HomeSceneState();
}

class _HomeSceneState extends State < HomeScene > {
  List<Image> _tabImages = [
    Image.asset('asset/icon/msg.png'),
    Image.asset('asset/icon/book-u.png'),
    Image.asset('asset/icon/app.png'),
    // Image.asset('asset/icon/video-u.png'),
    Image.asset('asset/icon/me-u.png'),
  ];
  List<Image> _tabSelectedImages = [
    Image.asset('asset/icon/msg-s.png'),
    Image.asset('asset/icon/book-s.png'),
    Image.asset('asset/icon/app-s.png'),
    // Image.asset('asset/icon/video-s.png'),
    Image.asset('asset/icon/me-s.png'),
  ];

  List < Widget > _widgetList = [
    //消息
    MessageScene(),
    //书城
    BookScene(),
    //推荐页面
    RecommendScene(),
    //视频
    // VideoScene(),
    //我的
    MineScene()
  ];
  int _index = 2;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _index,
        onTap: (index) {
          // if(index == 3){
          //   AppNavigator.toVideo(context);
          // }else{
            setState(() {
              _index = index;
            });
          // }
        },
        items: [
          BottomNavigationBarItem(
            icon: getTabIcon(0),
            title: Text('消息', style: TextStyle())),
          BottomNavigationBarItem(
            icon: getTabIcon(1),
            title: Text('书城', style: TextStyle())),
          BottomNavigationBarItem(
            icon: getTabIcon(2),
            title: Text('应用', style: TextStyle())),
          // BottomNavigationBarItem(
          //   icon: getTabIcon(3),
          //   title: Text('视频', style: TextStyle())),
          BottomNavigationBarItem(
            icon: getTabIcon(3),
            title: Text(
              '我的',
              style: TextStyle(),
            ))
        ],
      ),
      body: _widgetList[_index],
    );
  }
  Image getTabIcon(int index) {
    if (index == _index) {
      return _tabSelectedImages[index];
    } else {
      return _tabImages[index];
    }
  }
}

