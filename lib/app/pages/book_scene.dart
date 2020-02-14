import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class BookScene extends StatefulWidget {
  @override
  _BookSceneState createState() => _BookSceneState();
}

class _BookSceneState extends State<BookScene>
    with SingleTickerProviderStateMixin {
  TabController controller;
  ScrollController sc;
  var tabs = <Tab>[];

  @override
  void initState() {
    super.initState();
    tabs = <Tab>[
      Tab(
        text: "精选",
      ),
      Tab(
        text: "玄幻",
      ),
      Tab(
        text: "都市",
      ),
      Tab(
        text: "科幻",
      ),
      Tab(
        text: "修真",
      ),
      Tab(
        text: "游戏",
      ),
      Tab(
        text: "历史",
      ),
      // Tab(
      //   text: "其他",
      // )
    ];
    controller =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);
    sc = new ScrollController();
  }
  @override
  void dispose() {
    controller.dispose();
    sc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuilder(),
      backgroundColor: Colors.white,
      body: NestedScrollView(
        controller: sc,
        headerSliverBuilder: _sliverBuilder,
        body: TabBarView(
          controller: controller,
          children: [
            HotBookScene(sc: sc), //精选
            FantasyScene(sc: sc,bookType: "玄幻小说",title: "热门玄幻精选推荐",), //玄幻
            FantasyScene(sc: sc,bookType: "都市小说",title: "都市传奇"), //都市
            FantasyScene(sc: sc,bookType: "科幻小说",title: "硬核科幻大作"), //科幻
            FantasyScene(sc: sc,bookType: "修真小说",title: "极品修真等你开启"),//修真
            FantasyScene(sc: sc,bookType: "游戏小说",title: "热门游戏同人大作"),//游戏
            FantasyScene(sc: sc,bookType: "历史小说",title: "带你走进不一样的历史长河"),//历史
            // FantasyScene(sc: sc,bookType: "其他小说",title: "其他精心整理推荐"),//其他
        ]),
      ),
    );
  }

  Widget _appBarBuilder() {
    return PreferredSize(
      child: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 0),
          child: TabBar(
            controller: controller, //可以和TabBarView使用同一个TabController
            tabs: tabs,
            isScrollable: false,
            indicatorColor: Colors.white,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 0.0, color: Colors.white),
              insets: EdgeInsets.zero,
            ),
            indicatorWeight: 0.001,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.only(top: 0),
            labelPadding: EdgeInsets.only(left: 0),
            labelColor: AppColor.red,
            labelStyle: TextStyle(
              backgroundColor: Colors.white,
              fontSize: ScreenUtil().setSp(40),
            ),
            unselectedLabelColor: Colors.black38,
            unselectedLabelStyle: TextStyle(
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
        ),
      ),
      preferredSize: Size.fromHeight(20),
    );
  }
  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        // primary: false,
        expandedHeight: ScreenUtil().setHeight(50),
        floating: true, //不随着滑动隐藏标题
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        pinned: true, //不固定在顶部
        title: Row(
          children: <Widget>[
            new TextSearcher(),
            Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20)),
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'asset/icon/kind.png',
                      height: ScreenUtil().setHeight(40),
                      width: ScreenUtil().setWidth(40),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          _spGetNovelIdValue().then((value) {
                            if (value != null && value != "") {
                              int bookId = int.parse(value.split("|")[0]);
                              _bookInfo(bookId, context);
                            } else {
                              Fluttertoast.showToast(msg: "您最近没有看书哦！");
                            }
                          });
                        },
                        child: Icon(
                          CupertinoIcons.time,
                          color: AppColor.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    ];
  }

  _bookInfo(int bookId, BuildContext context) async {
    if (bookId != null) {
      var response = await HttpUtils.getRecentBook(bookId);
      List list =
          response['data'] == null ? null : response['data']['book'] as List;
      Map item = list == null ? null : list[0];
      if (item == null) {
        Fluttertoast.showToast(msg: "您最近没有看书哦！");
      } else {
        AppNavigator.toNovelDetail(context, item);
      }
    } else {
      Fluttertoast.showToast(msg: "您最近没有看书哦！");
    }
  }

  Future<String> _spGetNovelIdValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('articleId');
    return value;
  }
}
