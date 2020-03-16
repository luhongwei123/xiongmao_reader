import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/public.dart';
import 'package:xiongmao_reader/app/pages/recommends/little_tools/news_detail.dart';

class TodayNews extends StatefulWidget {
  @override
  _TodayNewsState createState() => _TodayNewsState();
}

class _TodayNewsState extends State < TodayNews > with OnLoadReloadListener, SingleTickerProviderStateMixin {

  FocusNode focusNode = new FocusNode();
  TextEditingController controller = TextEditingController();
  LoadStatus _loadStatus = LoadStatus.LOADING;
  var tabs = < Tab > [];

  List types = [];
  TabController _controller;


  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await HttpUtils.getMsgTypes().then((response) {
      List list = response['data'] as List;
      types = list;
      for (var i = 0; i < list.length; i++) {
        tabs.add(Tab(text: list[i]['typeName']));
      }
      setState(() {
        _controller = TabController(initialIndex: 0, length: tabs.length, vsync: this);
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
    return Scaffold(
      appBar: _appBarBuilder(),
      body: Column(
        children: < Widget > [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 0, bottom: 0),
            child: tabs.length > 0 ?
            TabBar(
              controller: _controller, //可以和TabBarView使用同一个TabController
              tabs: tabs,
              isScrollable: true,
              indicatorColor: Colors.white,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Colors.white),
                insets: EdgeInsets.zero,
              ),
              indicatorWeight: 1,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.only(top: 0, bottom: 0),
              labelPadding: EdgeInsets.only(left: 5, right: 5, bottom: 0),
              labelColor: AppColor.red,
              labelStyle: TextStyle(
                backgroundColor: Colors.white,
                fontSize: ScreenUtil().setSp(40),
              ),
              unselectedLabelColor: Colors.black38,
              unselectedLabelStyle: TextStyle(
                fontSize: ScreenUtil().setSp(28),
              ),
            ) : Container(),
          ),
          Expanded(
            child: tabs.length > 0 ?TabBarView(
              controller: _controller,
              children: buildNews(),
            ):Container(),
          )
        ],
      ),
    );
  }

  Widget _appBarBuilder() {
    return PreferredSize(
      child: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        title: Column(
          children: < Widget > [
            TextField(),

          ],
        ),
      ),
      preferredSize: Size.fromHeight(40),
    );
  }

  List<Widget> buildNews(){
    List<Widget> list = [];
    for(int i = 0;i<types.length;i++){
      var widget = NewsDetailScene(types[i]['typeId']);
      list.add(widget);
    }
    return list;
  }
  @override
  void onReload() {}
}