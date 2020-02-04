import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/app_http_utils.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';
import 'package:xiongmao_reader/app/components/load_view.dart';
import 'package:xiongmao_reader/app/model/article_model.dart';

class NovelTitlesScene extends StatefulWidget {
  final Article article;
  NovelTitlesScene({
    this.article
  });

  @override
  _NovelTitlesSceneState createState() => _NovelTitlesSceneState();
}

class _NovelTitlesSceneState extends State < NovelTitlesScene > with OnLoadReloadListener{
  List list =[];
  LoadStatus _loadStatus = LoadStatus.LOADING;
  String title;
  int page = 1;
  GlobalKey<RefreshFooterState> _footerkey = new GlobalKey<RefreshFooterState>();

  ScrollController controller = new ScrollController();
  @override
  void initState() {
    super.initState();
    //根据小说id 查询
    title = this.widget.article.title;
    getData();
    
  }

  void getData() async {
    var response = await HttpUtils.getCatalogListByLimit(this.widget.article.id, page);
    list.addAll(response['data']['catalog'] as List);
    _loadStatus = LoadStatus.SUCCESS;
    setState(() {  });
  }
  @override
  Widget build(BuildContext context) {
    return _loadStatus == LoadStatus.LOADING ?
            LoadingView() :
            _loadStatus == LoadStatus.FAILURE ?
            FailureView(this) :Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(IconData(0xe314, fontFamily: 'MaterialIcons'), color: AppColor.darkGray, ),
        ),
        centerTitle: true,
        title: Text(title, style: TextStyle(color: AppColor.darkGray), ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: EasyRefresh(
        refreshFooter: ClassicsFooter(
          key: _footerkey,
          bgColor: Colors.white,
          textColor: Colors.black,
          moreInfoColor: Colors.black,
          loadText: '',
          loadedText:'加载成功',
          isFloat:true,
          showMore: true,
          noMoreText: '-----我也是有底线的-----',
          loadingText:'加载中...',
          moreInfo: '最后更新于 %T',
          loadReadyText: '',
          loadHeight:ScreenUtil().setHeight(70),
        ),
        outerController: controller,
        loadMore:() async {
            page++;
            setState(() {
              
            });
           getData();
        },
        child: Container(
        color: Colors.white,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: CupertinoScrollbar(
            child: ListView.separated(
              controller: controller,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    AppNavigator.toNovelReaders(context, this.widget.article,list[index],index);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                    child: Text(list[index]['name']),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemCount: list.length),
          ),
        ),

      ),
      ),
    );
  }

  @override
  void onReload() {
    // TODO: implement onReload
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    } else {
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}