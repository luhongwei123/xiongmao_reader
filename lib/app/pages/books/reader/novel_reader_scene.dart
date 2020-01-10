import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/http_request.dart';
import 'package:xiongmao_reader/app/components/page_utils.dart';
import 'package:xiongmao_reader/app/model/novel_model.dart';
import 'package:xiongmao_reader/app/pages/books/reader/reader_menu_scene.dart';

import 'battery_scene.dart';

class NovelReaderScene extends StatefulWidget {
  final String artId;
  NovelReaderScene({this.artId});
  @override
  _NovelReaderSceneState createState() => _NovelReaderSceneState();
}

class _NovelReaderSceneState extends State < NovelReaderScene > {
  PageController pageController; 
  Novel preNovels;
  Novel currentNovels;
  Novel nextNovels;
  int pageIndex= 0;

  bool isMenuVisiable = false;

  String title='';
  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0, //默认显示第几个页面（默认0）
      keepPage: true, //设置为true  initialPage才生效（默认true）
      viewportFraction: 1.0 //默认1，每个页面占可视窗的比例
    );
    SystemChrome.setEnabledSystemUIOverlays([]);
    pageController.addListener(onScroll);

    setup(this.widget.artId);
  }
  setup(String articleId) async{
    currentNovels = await fetchArticle(articleId);
    title = currentNovels.title;
    if (currentNovels.preArticleId != null) {
      preNovels = await fetchArticle(currentNovels.preArticleId);
    } else {
      preNovels = null;
    }
    if (currentNovels.nextArticleId != null) {
      nextNovels = await fetchArticle(currentNovels.nextArticleId);
    } else {
      nextNovels = null;
    }
    setState(() {});
  }

  Future<Novel> fetchArticle(String articleId) async {
    var response = await Request.get(action: 'article$articleId');
    if("err" == response){
      return null;
    }
    String article = response['content'];
    Novel novel = Novel.fromJson(response);
    // title = novel.title;
    PageUtils.page(article, novel);
    return novel;
  }

  fetchPreArticle(String articleId) async {
   if (preNovels != null || articleId == null) {
      return;
    }
    preNovels = await fetchArticle(articleId);
    pageController.jumpToPage(preNovels.pageCount + pageIndex);
    setState(() {});
  }

  fetchNextArticle(String articleId) async {
    if (nextNovels != null ||  articleId == null) {
      return;
    }
    nextNovels = await fetchArticle(articleId);
    setState(() {});
  }

  onScroll() {
    var page = pageController.offset / ScreenUtil().setWidth(750.0-20-20);
    var nextArtilePage = currentNovels.pageCount + (preNovels != null ? preNovels.pageCount : 0);
    if (page >= nextArtilePage) {
      print("到达下章了，下章ID:${currentNovels.nextArticleId}");
      preNovels = currentNovels;
      currentNovels = nextNovels;
      nextNovels = null;
      title = currentNovels.title;
      pageController.jumpToPage(preNovels.pageCount);
      fetchNextArticle(currentNovels.nextArticleId);
      setState(() {});
    }
    if (preNovels != null && page <= preNovels.pageCount) {
      nextNovels = currentNovels;
      currentNovels = preNovels;
      preNovels = null;
      title = currentNovels.title;
      pageController.jumpToPage(pageIndex-1);
      fetchPreArticle(currentNovels.preArticleId);
      setState(() {});
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Stack(
          children: < Widget > [
            Positioned(left: 0, top: 0, right: 0, bottom: 0, child: Image.asset('asset/readers/read_bg.png', fit: BoxFit.cover)),
            buildPageView(),
            // buildMenu(),
          ],
        ),
      )
    );
  }
  Widget buildPageView(){
    int itemCount = currentNovels?.pageCount??0;
    if(preNovels != null){
        itemCount += preNovels?.pageCount??0 ;
    }
    if(nextNovels != null){
      itemCount += nextNovels?.pageCount??0;
    }
    return PageView.builder(
          pageSnapping: true, //默认true，即拖动不到一半弹回原页面;flase即，拖到哪里停在哪
          scrollDirection: Axis.horizontal, //垂直切换还是水平切换（默认水平，Android原生ViewPage要费很大劲才能实现）
          reverse: false, //倒置，设置true页面顺序从后往前，默认false
          onPageChanged: (currentIndex) {
               setState(() {
                 pageIndex = currentIndex;
               });
          }, //onPageChanged 监听页面改变，输出当前页面序号
          controller: pageController,
          itemCount: itemCount, //数量
          itemBuilder: _pageItemAnimal, //展示具体的Widget
        );
  }

  previousPage() {
    pageController.previousPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  nextPage() {
    pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }
  hideMenu() {
      SystemChrome.setEnabledSystemUIOverlays([]);
      setState(() {
        this.isMenuVisiable = false;
      });
  }
  //定义一个 Stack  返回展示
  Widget _pageItemAnimal(BuildContext context, int index) {
    var page = index - (preNovels != null ? preNovels.pageCount : 0);
    var article;
    if (page >= this.currentNovels.pageCount) {
      // 到达下一章了
      article = nextNovels;
      page = 0;
    } else if (page < 0) {
      // 到达上一章了
      article = preNovels;
      page = preNovels.pageCount - 1;
    } else {
      article = this.currentNovels;
    }
    String content = article.getContent(page);
    if (content.startsWith('\n')) {
      content = content.substring(1);
    }
    return GestureDetector(
      onTapUp: (TapUpDetails details){
        Offset position = details.globalPosition;
        double xRate = position.dx / ScreenUtil().setWidth(750.0-20-20);
        if (xRate > 0.33 && xRate < 0.66) {
          // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
           SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
              statusBarColor: Color(0xFFF5F5F5),
              statusBarBrightness:Brightness.light
          );
          SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
          
          SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          setState(() {
            isMenuVisiable = true;
          });
        } else if (xRate >= 0.66) {
          nextPage();
        } else {
          previousPage();
        }
      },
      child: Stack(
        children: < Widget > [
          Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setHeight(10), ScreenUtil().setHeight(30), 0, 0),
            child: Text(title, style: TextStyle(fontSize: ScreenUtil().setSp(20)), ),
          ),
          Container(
            color: Colors.transparent,
            margin: EdgeInsets.fromLTRB(ScreenUtil().setHeight(20), ScreenUtil().setHeight(80), ScreenUtil().setHeight(20), ScreenUtil().setHeight(20)),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: content,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(31),
                      letterSpacing: 1.5,
                      height:1.5,
                      textBaseline: TextBaseline.ideographic
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0, ScreenUtil().setWidth(10), ScreenUtil().setWidth(10)),
            alignment: Alignment.bottomLeft,
            child: Row(
              children: <Widget>[
                BatteryView(),
                Expanded(
                  child:Text('第${page + 1}/${currentNovels.pageCount}页', 
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18), 
                      color: Color(0xff8B7961),
                    ),
                    textDirection: TextDirection.rtl,
                  ) 
                ),
              ],
            ),
          ),
          buildMenu(),
        ],
      ),
    );
  }

  buildMenu() {
    if (!isMenuVisiable) {
      return Container();
    }
    
    return ReaderMenuScene(
      onTap: hideMenu,
    );
  }
}

