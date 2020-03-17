import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xiongmao_reader/app/components/app_http_utils.dart';
import 'package:xiongmao_reader/app/components/public.dart';


class NewsDetailScene extends StatefulWidget {
  final int index;
  NewsDetailScene(this.index);
  @override
  _NewsDetailSceneState createState() => _NewsDetailSceneState();
}

class _NewsDetailSceneState extends State<NewsDetailScene> with OnLoadReloadListener,AutomaticKeepAliveClientMixin{
  LoadStatus _loadStatus = LoadStatus.LOADING;

  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  int page =1;
  List list = [];
  @override
  void initState() {
    super.initState();
    init(this.widget.index);
  }
  init (int indexs) async{
    await HttpUtils.getMsgList(indexs,page).then((response) {
      list = response['data'] as List;
      setState(() {
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
              var widget = Container(
                child: Text(list[index]['title']),
              );
              return widget;
            },
            itemCount: list.length,
          ),
          loadMore: ()async{
            setState(() {
              page++;
            });
            // _initBookList();
          },
        ),
      );
  }

  @override
  void onReload() {
  }

  @override
  bool get wantKeepAlive => true;
}