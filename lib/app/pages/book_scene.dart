import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_searcher.dart';
import 'package:xiongmao_reader/app/pages/books/boy_scene.dart';
import 'package:xiongmao_reader/app/pages/books/girl_scene.dart';
import 'package:xiongmao_reader/app/pages/books/hot_scene.dart';
import 'package:xiongmao_reader/app/pages/books/new_book_scene.dart';

class BookScene extends StatefulWidget {
  @override
  _BookSceneState createState() => _BookSceneState();
}

class _BookSceneState extends State < BookScene > with SingleTickerProviderStateMixin {
  TabController controller;
  ScrollController sc;
  var tabs = < Tab > [];

  @override
  void initState() {
    super.initState();
    tabs = < Tab > [
      Tab(
        text: "精选",
      ),
      Tab(
        text: "新书",
      ),
      Tab(
        text: "男生频道",
      ),
      Tab(
        text: "女生频道",
      )
    ];
    controller = TabController(initialIndex: 0, length: tabs.length, vsync: this);
    sc = new ScrollController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          title: TabBar(
            controller: controller, //可以和TabBarView使用同一个TabController
            tabs: tabs,
            isScrollable: true,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 0.0, color: Colors.white),
              insets: EdgeInsets.zero,
            ),
            indicatorWeight: 0.001,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.zero,
            // labelPadding: EdgeInsets.only(left: 20),
            labelColor: Colors.amber,
            labelStyle: TextStyle(
              fontSize: ScreenUtil().setSp(28),
            ),
            unselectedLabelColor: Colors.black38,
            unselectedLabelStyle: TextStyle(
              fontSize: ScreenUtil().setSp(18),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(20),
      ),
      body: NestedScrollView(
        headerSliverBuilder: _sliverBuilder,
        body: TabBarView(
          controller: controller,
          children: [
            HotBookScene(), //精选
            NewBookScene(), //新书
            BoyScene(), //男生频道
            GirlScene(), //女生频道
          ]
        ),
      ),
    );
  }

  List < Widget > _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget > [
      SliverAppBar(
        // primary: false,
        expandedHeight: ScreenUtil().setHeight(30),
        floating: false, //不随着滑动隐藏标题
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        pinned: false, //不固定在顶部
        title: new TextSearcher(),
      )
    ];
  }
}