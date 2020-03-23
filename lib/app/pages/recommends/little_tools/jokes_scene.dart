import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/load_view.dart';
import 'package:xiongmao_reader/app/components/public.dart';


class JokesScene extends StatefulWidget {
  @override
  _JokesSceneState createState() => _JokesSceneState();
}

class _JokesSceneState extends State<JokesScene> with OnLoadReloadListener{

  LoadStatus _loadStatus = LoadStatus.LOADING;

   GlobalKey < RefreshHeaderState > _headerKey = new GlobalKey < RefreshHeaderState > ();

  GlobalKey < RefreshFooterState > _footerKey = new GlobalKey < RefreshFooterState > ();

  List list = [];

  int page = 10;
  @override
  void initState() {
    super.initState();
    init();
  }
  Future init() async{
    await HttpUtils.getJokes(page).then((response){
      List jokes = response['data']["list"] as List;
      list.addAll(jokes);
      setState(() {
        _loadStatus = LoadStatus.SUCCESS;
      });
    }).catchError((e){
      setState(() {
        _loadStatus = LoadStatus.FAILURE;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_arrow_left,color: AppColor.darkGray,),
        ),
        elevation: 0,
        title: Center(
          child: Text('开心一刻',style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(40)
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }
  Widget _buildBody(){
      return _loadStatus == LoadStatus.LOADING ?
        LoadingView() :
        _loadStatus == LoadStatus.FAILURE ?
        FailureView(this) :  ScrollConfiguration(
        behavior: MyBehavior(),
        child: EasyRefresh(
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
          setState(() {
            page+=0;
          });
          init();
        },
        child:ListView.builder(
            itemBuilder: (context,index){
              if(list != null && list.length > 0){
                return Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('更新时间: ', 
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(15),
                              fontWeight: FontWeight.w900, //字体粗细  粗体和正常
                            )
                          ),
                          Text(list[index]['updateTime'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.w900, //字体粗细  粗体和正常
                            )
                          ),
                        ],
                      ),
                      
                      Text('        '+list[index]['content'],textAlign: TextAlign.left,style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: ScreenUtil().setSp(30),
                                fontWeight: FontWeight.w900, //字体粗细  粗体和正常
                            )),
                      Divider()
                    ],
                  ),
                );
              }else{
                return Container();
              }
            },
            itemCount: list.length,
          ),
          loadMore: () async {
            setState(() {
              page+=10;
            });
            init();
          },
        )
      );
  }
  @override
  void onReload() {
    setState(() {
      _loadStatus = LoadStatus.LOADING;
    });
    init();
  }
}