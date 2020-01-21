import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_http_utils.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';
import 'package:xiongmao_reader/app/components/http_request.dart';
import 'package:xiongmao_reader/app/components/load_view.dart';
import 'package:xiongmao_reader/app/pages/books/pagination/floor_tools.dart';
import 'package:xiongmao_reader/app/pages/books/pagination/index_swiper.dart';
import 'package:xiongmao_reader/app/pages/books/pagination/navigator_scene.dart';
import 'package:xiongmao_reader/app/pages/books/pagination/recommends.dart';

class HotBookScene extends StatefulWidget {
  final ScrollController sc;
  HotBookScene({this.sc});
  @override
  _HotBookScene createState() => _HotBookScene();
}

class _HotBookScene extends State < HotBookScene > with AutomaticKeepAliveClientMixin, OnLoadReloadListener {
  Map < String, dynamic > resp = {};
  Map < String, Object > hot = {};

  LoadStatus _loadStatus = LoadStatus.LOADING;
  GlobalKey<RefreshFooterState> _footerkey = new GlobalKey<RefreshFooterState>();

  int limit = 10;
  int page = 1;
  List bookList; 

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    hot['imageUrls'] = [{
        "url": "asset/sea.png",
        "text": "sea.png"
      },
      {
        "url": "asset/star.jpg",
        "text": "star.jpg"
      },
      {
        "url": "asset/road.jpg",
        "text": "road.jpg"
      },
      {
        "url": "asset/star.jpg",
        "text": "star.jpg"
      }
    ];
    hot['navigaors'] = [{
        "url": "asset/icon/kinds.png",
        "title": "分类"
      },
      {
        "url": "asset/icon/ranking.png",
        "title": "排行"
      },
      {
        "url": "asset/icon/books.png",
        "title": "书单"
      },
      {
        "url": "asset/icon/articles.png",
        "title": "网文"
      },
      {
        "url": "asset/icon/shares.png",
        "title": "书友分享"
      }
    ];
    hot['title'] = ["一周热门书籍推荐", "畅销精选"];

    _init().then((data) {
      hot['recommands'] = data;
      resp['hot'] = hot;
      _loadStatus = LoadStatus.SUCCESS;
    });
    _initBookList();
  }
  Future _init() async {
    var response = await HttpUtils.getHot();
    List list = response['data']['book'] as List;
    Map recommands = {};
    recommands['firstRecommands'] = {
      "url": Request.baseImageUrl+'${list[0]['id']}',
      "title": list[0]['name'],
      "summary": list[0]['description'],
      "author": list[0]['author'],
      "articleId": list[0]['id'],
    };
    recommands['otherRecommands'] = [{
        "url": Request.baseImageUrl+'${list[1]['id']}',
        "title": list[1]['name'],
        "articleId": list[1]['id']
      },
      {
        "url": Request.baseImageUrl+'${list[2]['id']}',
        "title": list[2]['name'],
        "articleId": list[2]['id']
      },
      {
        "url": Request.baseImageUrl+'${list[3]['id']}',
        "title": list[3]['name'],
        "articleId": list[3]['id']
      },
      {
        "url": Request.baseImageUrl+'${list[4]['id']}',
        "title": list[4]['name'],
        "articleId": list[4]['id']
      },
    ];
    return recommands;
  }

  Future _initBookList()async{ 
    var response = await HttpUtils.getList(null,limit,page);
    if(bookList != null){
        bookList.addAll(response['data']['book'] as List);
    }else{
        bookList = response['data']['book'] as List;
    }
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _loadStatus == LoadStatus.LOADING ?
      LoadingView() :
      _loadStatus == LoadStatus.FAILURE ?
      FailureView(this) : EasyRefresh(
        refreshFooter: ClassicsFooter(
          key: _footerkey,
          bgColor: Colors.white,
          textColor: Colors.black,
          moreInfoColor: Colors.white,
          loadText: '加载中...',
          loadedText:'加载成功...',
          showMore: true,
          noMoreText: '加载成功',
          loadingText:'加载中...',
          moreInfo: '加载中...',
          loadReadyText: '上拉加载更多',
        ),
        outerController: this.widget.sc,
        loadMore:() async {
            page++;
            setState(() {
              
            });
            _initBookList();
        },
        child: CustomScrollView(
          slivers: [
            new SliverList(
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建列表项
                  return _getCompnents(index);
                },
              ),
            )
          ],
        ),
      );
  }

  Widget _getCompnents(int index) {
    var widget;
    switch (index) {
      case 0:
        widget = IndexSwiper(imageUrls: resp['hot']['imageUrls'], );
        break;
      case 1:
        widget = NavigatorScene(navigators: resp['hot']['navigaors'], );
        break;
      case 2:
        widget = FloorTitle(title: resp['hot']['title'][0]);
        break;
      case 3:
        widget = WeeksRecommends(recommends: resp['hot']['recommands']);
        break;
      case 4:
        widget = FloorTitle(title: resp['hot']['title'][1]);
        break;
      case 5:
        widget = Column(
          children: _buildItem(),
        );
        break;
    }
    return widget;
  }

  List<Widget> _buildItem(){
    List<Widget> list = [];
    bookList.forEach((item){
      var widget = InkWell(
      child: Container(
        child: Row(
          children: < Widget > [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: CachedNetworkImage(
                    imageUrl: Request.baseImageUrl+"${item['id']}",
                    // fit: fit == null ? BoxFit.cover : fit,
                    width: ScreenUtil().setWidth(165),
                    // height: height,
                  )
                ),
              ],
            ),
            Column(
              children: < Widget > [
                Container(
                  width: ScreenUtil().setWidth(550),
                  child: Text(item['name'],
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
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: ScreenUtil().setWidth(550),
                  child: Text(item['description'],
                    textAlign: TextAlign.left, //文本对齐方式  居中
                    textDirection: TextDirection.ltr, //
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15)
                    ),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(550),
                  child: Row(
                    children: < Widget > [
                      Image.asset("asset/icon/author.png", width: ScreenUtil().setWidth(30), height: ScreenUtil().setHeight(30)),
                      Text(item['author'],
                        textAlign: TextAlign.left, //文本对齐方式  居中
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15)
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        print("=========================${item.toString()}");
        AppNavigator.toNovelDetail(context, item);
      }
    );
    list.add(widget);
    });
    return list;
  }
  @override
  void onReload() {}
}