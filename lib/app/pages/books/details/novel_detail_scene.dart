import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';

class NovelDetailScene extends StatefulWidget {
  @override
  _NovelDetailSceneState createState() => _NovelDetailSceneState();
}

class _NovelDetailSceneState extends State < NovelDetailScene > {

  ScrollController _scrollController = ScrollController();
  String title = '';
  bool isUnfold = false;

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
        body: SizedBox(
          height: ScreenUtil().setHeight(400),
          child: _buildCard(),
        ),
      ),
      bottomNavigationBar: _buildNavigator(),
    );
  }

  Widget _buildNavigator() {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(color: Colors.white),
      height: ScreenUtil().setHeight(80) + MediaQuery.of(context).padding.bottom,
      child: Row(children: < Widget > [
        Expanded(
          child: Center(
            child: Text(
              '加书架',
              style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              AppNavigator.toNovelReaders(context,'0000');
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  '开始阅读',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              '下载',
              style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
            ),
          ),
        ),
      ]),
    );
  }
  Widget _buildCard() {
    return Container(
      color: Colors.white,
      child: Column(
        children: < Widget > [
          Row(
            children: < Widget > [
              Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                child: Text('简介',
                  textAlign: TextAlign.left, //文本对齐方式  居中
                  textDirection: TextDirection.ltr, //
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isUnfold = !isUnfold;
              });
            },
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: < Widget > [
                  Text(
                    '举头三尺无神明，掌心三寸是人间。这是耳根继《仙逆》《求魔》《我欲封天》《一念永恒》后，创作的第五部长篇小说《三寸人间》。举头三尺无神明，掌心三寸是人间。这是耳根继《仙逆》《求魔》《我欲封天》《一念永恒》后，创作的第五部长篇小说《三寸人间》。举头三尺无神明，掌心三寸是人间。这是耳根继《仙逆》《求魔》《我欲封天》《一念永恒》后，创作的第五部长篇小说《三寸人间》。',
                    maxLines: isUnfold ? null : 4,
                    style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              AppNavigator.toNovelTitles(context);
            },
            focusColor:Colors.white,
            splashColor:Colors.white,
            child: Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setWidth(10), 0, 0),
              height: ScreenUtil().setHeight(80),
              child: Row(
                children: < Widget > [
                  Expanded(
                    child: Text('目录',
                      textAlign: TextAlign.left, //文本对齐方式  居中
                      textDirection: TextDirection.ltr, //
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(20),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Text('最新章节',
                      textAlign: TextAlign.left, //文本对齐方式  居中
                      textDirection: TextDirection.ltr, //
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(20),
                      ),
                  ),
                  Icon(IconData(0xe315,fontFamily: 'MaterialIcons'),
                  ),
                ],
              ),
            )
          ),
        ],
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
          child: Icon(Icons.keyboard_arrow_left,color: AppColor.darkGray,),
        ),
        title: Text(title,style: TextStyle(
          color: AppColor.darkGray
        ),),
        centerTitle: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Row(
            children: < Widget > [
              Container(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(100), 0, 0, ScreenUtil().setWidth(20)),
                alignment: Alignment.bottomLeft,
                child: Image.asset('asset/books/1.jpg', width: ScreenUtil().setWidth(250), height: ScreenUtil().setHeight(180), ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setWidth(200), ScreenUtil().setWidth(10), ScreenUtil().setWidth(20)),
                alignment: Alignment.bottomRight,
                child: Column(
                  children: < Widget > [
                    Text('三寸人间',
                      textAlign: TextAlign.left, //文本对齐方式  居中
                      textDirection: TextDirection.ltr, //
                      style: TextStyle(
                        color: AppColor.darkGray,
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