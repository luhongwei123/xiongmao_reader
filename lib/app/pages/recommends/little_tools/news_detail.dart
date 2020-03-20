import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_http_utils.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';
import 'package:xiongmao_reader/app/components/behaver.dart';
import 'package:xiongmao_reader/app/components/load_view.dart';
import 'package:xiongmao_reader/app/components/public.dart';
import 'package:xiongmao_reader/app/pages/recommends/little_tools/video_widget.dart';


class NewsDetailScene extends StatefulWidget {
  final int index;
  NewsDetailScene(this.index);
  @override
  _NewsDetailSceneState createState() => _NewsDetailSceneState();
}

class _NewsDetailSceneState extends State < NewsDetailScene > with OnLoadReloadListener {

  LoadStatus _loadStatus = LoadStatus.LOADING;

  Future _initializeVideoPlayerFuture;

  ScrollController scrollController = new ScrollController();

  PageController pageController = new PageController();

  GlobalKey < RefreshHeaderState > _headerKey = new GlobalKey < RefreshHeaderState > ();

  GlobalKey < RefreshFooterState > _footerKey = new GlobalKey < RefreshFooterState > ();

  int page = 1;
  List list = [];
  @override
  void initState() {
    super.initState();
    init(this.widget.index);

  }

  init(int indexs) async {
    await HttpUtils.getMsgList(indexs, page).then((response) {
      setState(() {
        list = response['data'] as List;
        _loadStatus = LoadStatus.SUCCESS;
      });
    }).catchError((e) {
      setState(() {
        _loadStatus = LoadStatus.FAILURE;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return _loadStatus == LoadStatus.LOADING ?
      LoadingView() :
      _loadStatus == LoadStatus.FAILURE ?
      FailureView(this) :
      ScrollConfiguration(
        behavior: MyBehavior(),
        child: buildChild(context),
      );
  }
  Widget buildChild(BuildContext context) {
    return Scaffold(
      body: this.widget.index != 526 ? buildItem() : buildLittleVideo(),
    );
  }

  Widget buildItem() {
    return EasyRefresh(
      refreshFooter: ClassicsFooter(
        key: _footerKey,
        bgColor: Colors.white,
        textColor: Colors.black,
        moreInfoColor: Colors.black,
        showMore: true,
        loadText: '上拉加载更多',
        loadedText: "加载成功",
        loadingText: '干嘛辣么急躁...',
        noMoreText: '加载成功',
        moreInfo: '最近加载于 %T',
        loadReadyText: '快给老子放手TT',
      ),
      refreshHeader: ClassicsHeader(
        key: _headerKey,
        bgColor: Colors.white,
        textColor: Colors.black,
        moreInfoColor: Colors.black,
        showMore: true,
        refreshText: '上拉加载更多',
        refreshedText: "加载成功",
        refreshingText: '干嘛辣么急躁...',
        moreInfo: '最近加载于 %T',
        refreshReadyText: '快给老子放手TT',
      ),
      onRefresh: () async {
        init(this.widget.index);
      },
      child: ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) {
          var item = list[index];
          List imageList = item['imgList'] as List;
          var widget = InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              if (this.widget.index == 522) {
                if (item['videoList'] == null) {
                  Fluttertoast.showToast(msg: "无法播放该视频！");
                  return;
                }
                List videoList = item['videoList'] as List;
                AppNavigator.toVideo(context, videoList[0].toString(), item['title']);
              } else {
                AppNavigator.toNewsDetails(context, item);
              }
            },
            child: Column(
              children: < Widget > [
                Container(
                  child: Row(
                    children: < Widget > [
                      Column(
                        children: < Widget > [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                            width: ScreenUtil().setWidth(460),
                            child: Text(item['title'],
                              textAlign: TextAlign.left, //文本对齐方式  居中
                              textDirection: TextDirection.ltr, //
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(30)
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                            width: ScreenUtil().setWidth(460),
                            child: Row(
                              children: < Widget > [
                                Text("来源：${item['source']}",
                                  textAlign: TextAlign.left, //文本对齐方式  居中
                                  textDirection: TextDirection.ltr,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(15)
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                            width: ScreenUtil().setWidth(460),
                            child: Text("更新时间：${item['postTime']}",
                              textAlign: TextAlign.left, //文本对齐方式  居中
                              textDirection: TextDirection.ltr,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(15)
                              ),
                            ),
                          ),
                        ],
                      ),
                      imageList != null && imageList.length > 0 ?
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: CachedNetworkImage(
                          imageUrl: imageList[0],
                          width: ScreenUtil().setWidth(250),
                          height: ScreenUtil().setHeight(180),
                        ),
                      ) : Container(),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          );
          return widget;
        },
        itemCount: list.length,
      ), loadMore: () async {
        init(this.widget.index);
        scrollController.jumpTo(0);
      },
    );
  }

  Widget buildLittleVideo() {
    return Stack(
      children: < Widget > [
        PageView(
          children: buildVideoItem(),
          scrollDirection: Axis.vertical,
          controller: pageController,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            child: Icon(Icons.refresh, color: Colors.white, ),
            onPressed: () {
              init(this.widget.index);
              if (pageController.page == 0) {
                pageController.jumpToPage(1);
              } else {
                pageController.jumpToPage(0);
              }
            },
          ),
        ),
      ],
    );
  }
  List < Widget > buildVideoItem() {
    List < Widget > vList = [];
    if (list != null && list.length > 0) {
      for (int index = 0; index < list.length; index++) {
        var item = list[index];
        if (item['videoList'] == null) {
          vList.add(new Container());
        } else {
          List videoUrl = item['videoList'] as List;
          Widget widget = VideoWidget(
            videoUrl[0].toString(),
            positionTag: index,
            title: item['title'],
          );
          vList.add(widget);
        }
      }
    }
    return vList;
  }
  @override
  void onReload() {
    setState(() {
      _loadStatus = LoadStatus.LOADING;
    });
    init(this.widget.index);
  }
}