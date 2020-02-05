import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/public.dart';


class HomeScene extends StatefulWidget {
  @override
  _HomeSceneState createState() => _HomeSceneState();
}

class _HomeSceneState extends State < HomeScene > {
  List<Image> _tabImages = [
    Image.asset('asset/icon/tuijian-u.png'),
    Image.asset('asset/icon/book-u.png'),
    Image.asset('asset/icon/video-u.png'),
    Image.asset('asset/icon/me-u.png'),
  ];
  List<Image> _tabSelectedImages = [
    Image.asset('asset/icon/tuijian-s.png'),
    Image.asset('asset/icon/book-s.png'),
    Image.asset('asset/icon/video-s.png'),
    Image.asset('asset/icon/me-s.png'),
  ];

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
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  }
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
            icon: getTabIcon(0),
            title: Text('推荐', style: TextStyle())),
          BottomNavigationBarItem(
            icon: getTabIcon(1),
            title: Text('书城', style: TextStyle())),
          BottomNavigationBarItem(
            icon: getTabIcon(2),
            title: Text('视频', style: TextStyle())),
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

  //appbar
  Widget _buildAppBar(int index) {
    var appbar;
      switch (index) {
        case 0:
          appbar = new AppBar(
            elevation: 0,
            title: new Text("精选推荐",style: new TextStyle(color: Colors.white)),
            iconTheme: new IconThemeData(color: Colors.white),
            // backgroundColor: Colors.amber,
            backgroundColor: AppColor.red,
            brightness: Brightness.light,
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
}

