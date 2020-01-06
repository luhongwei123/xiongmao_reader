import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NovelDetailScene extends StatefulWidget {
  @override
  _NovelDetailSceneState createState() => _NovelDetailSceneState();
}

class _NovelDetailSceneState extends State < NovelDetailScene > {

  ScrollController _scrollController = ScrollController();
  String title = '';

  @override
  void initState() {
    super.initState();
    _scrollController..addListener(() {
      setState(() {
        if (_scrollController.offset > 100) {
          title = '三寸人间';
        } else if (_scrollController.offset <= 40) {
          title = '';
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: _sliverBuilder,
        body: Text('body'),
      ),
    );
  }
  List < Widget > _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget > [
      SliverAppBar(
        expandedHeight: ScreenUtil().setHeight(300),
        floating: false, //不随着滑动隐藏标题
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        pinned: true, //不固定在顶部
        primary: true,
        snap: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_arrow_left),
        ),
        title: Text(title),
        centerTitle: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Row(
            children: < Widget > [
              Container(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(100), 0, 0, ScreenUtil().setWidth(20)),
                alignment: Alignment.bottomLeft,
                child: Image.asset('asset/books/1.jpg', width: ScreenUtil().setWidth(130), height: ScreenUtil().setHeight(180), ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setWidth(120), ScreenUtil().setWidth(10), ScreenUtil().setWidth(20)),
                alignment: Alignment.bottomRight,
                child: Column(
                  children: < Widget > [
                    Text('三寸人间',
                      textAlign: TextAlign.left, //文本对齐方式  居中
                      textDirection: TextDirection.ltr, //
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(40)
                      ),
                    ),
                    Text('树根',
                      textAlign: TextAlign.left, //文本对齐方式  居中
                      textDirection: TextDirection.ltr, //
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(25)
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ),
      )
    ];
  }
}