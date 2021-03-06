import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xiongmao_reader/app/components/app_http_utils.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';
import 'package:xiongmao_reader/app/components/behaver.dart';
import 'package:xiongmao_reader/app/components/http_request.dart';
import 'package:xiongmao_reader/app/components/load_view.dart';
import 'package:xiongmao_reader/app/pages/books/pagination/floor_tools.dart';
 
class FantasyScene extends StatefulWidget{
  final ScrollController sc;
  final String bookType;
  final String title;
  FantasyScene({this.sc,this.bookType,this.title});
  @override
  _FantasySceneState createState() => _FantasySceneState();
}
 
class _FantasySceneState extends State<FantasyScene> with AutomaticKeepAliveClientMixin , OnLoadReloadListener{
  Map < String, dynamic > resp = {};
  Map < String, Object > hot = {};

  LoadStatus _loadStatus = LoadStatus.LOADING;
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  ScrollController controller ;
  int limit = 10;
  int page = 1;
  List bookList; 
  @override
  bool get wantKeepAlive => true; 
  
  @override
  void initState() {
    super.initState();
    controller = this.widget.sc;
    controller.addListener(_onScroll);
    _initBookList();
  }
  _onScroll(){
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        setState(() {
          page++;
        });
        _initBookList();
      }
  }
  Future _initBookList()async{ 
    await HttpUtils.getList(this.widget.bookType,limit,page).then((response){
      if(bookList != null){
        bookList.addAll(response['data']['book'] as List);
      }else{
          bookList = response['data']['book'] as List;
      }
      _loadStatus = LoadStatus.SUCCESS;
      setState(() { });
    }).catchError((e){
      _loadStatus = LoadStatus.FAILURE;
      setState(() {});
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
            itemCount: 2,
          ),
          loadMore: ()async{
            setState(() {
              page++;
            });
            _initBookList();
          },
        ),
      );
      // EasyRefresh(
      //   refreshFooter: ClassicsFooter(
      //     key: _footerkey,
      //     bgColor: Colors.white,
      //     textColor: Colors.black,
      //     moreInfoColor: Colors.black,
      //     loadText: '',
      //     loadedText:'加载成功',
      //     isFloat:true,
      //     showMore: true,
      //     noMoreText: '-----我也是有底线的-----',
      //     loadingText:'加载中...',
      //     moreInfo: '最后更新于 %T',
      //     loadReadyText: '',
          
      //     loadHeight:ScreenUtil().setHeight(70),
      //   ),
      //   outerController: this.widget.sc,
      //   loadMore:() async {
      //     print("当前数据：############${bookList.length}");
      //       page++;
      //       setState(() {
              
      //       });
      //       _initBookList();
      //   },
      //   child: CustomScrollView(
      //     slivers: [
      //       new SliverList(
      //         delegate: new SliverChildBuilderDelegate(
      //           (BuildContext context, int index) {
      //             //创建列表项
      //             return _getCompnents(index);
      //           },
      //         ),
      //       )
      //     ],
      //   ),
      // );
  }

  Widget _getCompnents(int index) {
    var widget;
    switch (index) {
      case 0:
        widget = FloorTitle(title: this.widget.title);
        break;
      case 1:
        widget = Column(
          children: _buildItem(),
        );
        break;
      // case 2:
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
        // print("=========================${item.toString()}");
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