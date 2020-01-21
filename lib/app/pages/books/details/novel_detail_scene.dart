import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';
import 'package:xiongmao_reader/app/model/article_model.dart';

class NovelDetailScene extends StatefulWidget {

  final Map article;

  NovelDetailScene({this.article});
  @override
  _NovelDetailSceneState createState() => _NovelDetailSceneState();
}

class _NovelDetailSceneState extends State < NovelDetailScene > {

  ScrollController _scrollController = ScrollController();
  String title = '';
  bool isUnfold = false;
  Article article;

  @override
  void initState() {
    super.initState();
    //查询小说详情
    
    article = Article.fromJson(this.widget.article);

    _scrollController.addListener(onScroll);
  }
  //滚动事件
  onScroll(){
    setState(() {
      if (_scrollController.offset > 100) {
        title = article.title;
      } else if (_scrollController.offset <= 40) {
        title = '';
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: _sliverBuilder,
        body: SizedBox(
          height: ScreenUtil().setHeight(400),
          child: _buildItem(),
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
              AppNavigator.toNovelReaders(context,article,null);
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
  Widget _buildItem() {
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
                    article.summary,
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
              AppNavigator.toNovelTitles(context,article);
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
                //待修改
                child: CachedNetworkImage(
                    imageUrl: article.imageUrl,
                    width: ScreenUtil().setWidth(250),
                    height: ScreenUtil().setHeight(180)
                  )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setWidth(200), ScreenUtil().setWidth(10), ScreenUtil().setWidth(20)),
                alignment: Alignment.bottomRight,
                child: Column(
                  children: < Widget > [
                    Container(
                      width: ScreenUtil().setWidth(350),
                      child: Text(article.title,
                        textAlign: TextAlign.left, //文本对齐方式  居中
                        textDirection: TextDirection.ltr, //
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColor.darkGray,
                          fontSize: ScreenUtil().setSp(40)
                        ),
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(350),
                      child: Text(
                        article.author,
                        textAlign: TextAlign.left, //文本对齐方式  居中
                        textDirection: TextDirection.ltr, //
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(25)
                        ),
                      ),
                    ),
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