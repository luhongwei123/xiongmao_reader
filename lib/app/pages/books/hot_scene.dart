import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xiongmao_reader/app/components/public.dart';
// import 'package:xiongmao_reader/app/pages/books/pagination/recommends.dart';

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
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  int limit = 10;
  int page = 1;
  List<Widget> widgetList = [];
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
    // _init().then((data) {
    // hot['recommands'] = data;
    resp['hot'] = hot;
    _initBookList();
    
    // });
  }
  // Future _init() async {
  //   var response = await HttpUtils.getHot();
  //   List list = response['data']['book'] as List;
  //   Map recommands = {};
  //   recommands['firstRecommands'] = {
  //     "url": Request.baseImageUrl+'${list[0]['id']}',
  //     "name": list[0]['name'],
  //     "summary": list[0]['description'],
  //     "author": list[0]['author'],
  //     "id": list[0]['id'],
  //   };
  //   recommands['otherRecommands'] = [{
  //       "url": Request.baseImageUrl+'${list[1]['id']}',
  //       "summary": list[1]['description'],
  //       "author": list[1]['author'],
  //       "name": list[1]['name'],
  //       "id": list[1]['id']
  //     },
  //     {
  //       "url": Request.baseImageUrl+'${list[2]['id']}',
  //       "summary": list[2]['description'],
  //       "author": list[2]['author'],
  //       "name": list[2]['name'],
  //       "id": list[2]['id']
  //     },
  //     {
  //       "url": Request.baseImageUrl+'${list[3]['id']}',
  //       "summary": list[3]['description'],
  //       "author": list[3]['author'],
  //       "name": list[3]['name'],
  //       "id": list[3]['id']
  //     },
  //     {
  //       "url": Request.baseImageUrl+'${list[4]['id']}',
  //       "summary": list[4]['description'],
  //       "author": list[4]['author'],
  //       "name": list[4]['name'],
  //       "id": list[4]['id']
  //     },
  //   ];
  //   return recommands;
  // }

  Future _initBookList()async{ 
    await HttpUtils.getList(null,limit,page).then((response) {
      if(bookList != null){
        bookList.addAll(response['data']['book'] as List);
      }else{
        bookList = response['data']['book'] as List;
      }
      _loadStatus = LoadStatus.SUCCESS;
      setState((){});
    }).catchError((e){
      _loadStatus = LoadStatus.FAILURE;  
      setState((){});
    });
    
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _loadStatus == LoadStatus.LOADING ?
      LoadingView() :
      _loadStatus == LoadStatus.FAILURE ?
      FailureView(this) : 
      ScrollConfiguration(
        behavior: MyBehavior(),
        child: EasyRefresh(
          refreshFooter: ClassicsFooter(
            key: _footerKey,
            bgColor:Colors.white,
            textColor: Colors.black,
            moreInfoColor: Colors.black,
            showMore: true,
            loadText:'上拉加载更多',
            loadedText:"加载成功",
            loadingText:'干嘛辣么急躁...',
            noMoreText: '加载成功',
            moreInfo: '最近加载于 %T',
            loadReadyText: '快给老子放手TT',
          ),
          child: ListView.builder(
            padding: EdgeInsets.all(0.0),
            itemBuilder: (context, index) {
              return _getCompnents(index);
            },
            itemCount: 4,
          ),
          loadMore: ()async{
            setState(() {
              page++;
            });
            _initBookList();
          },
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
      // case 2:
      //   widget = FloorTitle(title: resp['hot']['title'][0]);
      //   break;
      // case 3:
      //   widget = WeeksRecommends(recommends: resp['hot']['recommands']);
      //   break;
      case 2:
        widget = FloorTitle(title: resp['hot']['title'][1]);
        break;
      case 3:
        widget = Column(
          children: _buildItem(),
        );
        break;
      // case 4:
      //   widget = MoreInfo();
      //   break;
    }
    return widget;
  }

  List<Widget> _buildItem(){
    List<Widget> list = [];
    bookList.forEach((item){
      var widget = InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
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
        _spGetNovelIdValue().then((value){
          if(value != null && value!="" ){
              if(item['id'] != int.parse(value.split("|")[0])){
                _spSetNovelIdValue("");
              }
          }
          AppNavigator.toNovelDetail(context, item);
        });
      },
    );
    list.add(widget);
    });
    return list;
  }

  Future < String > _spGetNovelIdValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('articleId');
    return value ;
  }
  _spSetNovelIdValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('articleId', value);
  }
  @override
  void onReload() {
    setState(() {
      _loadStatus = LoadStatus.LOADING;
    });
    _initBookList();
  }
}