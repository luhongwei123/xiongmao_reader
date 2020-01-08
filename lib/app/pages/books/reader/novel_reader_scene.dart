import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xiongmao_reader/app/components/http_request.dart';
import 'package:xiongmao_reader/app/model/novel_model.dart';

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
  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0, //默认显示第几个页面（默认0）
      keepPage: true, //设置为true  initialPage才生效（默认true）
      viewportFraction: 1.0 //默认1，每个页面占可视窗的比例
    );
    pageController.addListener(onScroll);

    fetchArticle(this.widget.artId);
  }

  fetchArticle(String articleId) async {
    var response = await Request.get(action: 'article$articleId');
    if("err" == response){
      return;
    }
    String article = response['content'];
    int length = article.length;
    int page = 0;
    if(length % 400 == 0){
        page = (length~/400).toInt();
    }else{
        page = (length~/400).toInt() + 1;
    }
    List list = [];
    currentNovels = Novel.fromJson(response);
    for(int i = 0; i < page;i++){
      int s = (i+1)*400;
      if(s >= article.length){
        s = article.length;
      }
      list.add(article.substring(400*i,s));
    } 
    currentNovels.addAttr(list);
    if(response['prev_id'] != null && response['prev_id'] != '0'){
        fetchPreArticle(response['prev_id']);
    }
    if(response['next_id'] != null){
        fetchNextArticle(response['next_id']);
    }
    setState(() {});
  }

  fetchPreArticle(String articleId) async {
    var response = await Request.get(action: 'article$articleId');
    if("err" == response){
      return;
    }
    String article = response['content'];
    int length = article.length;
    int page = 0;
    if(length % 400 == 0){
        page = (length~/400).toInt();
    }else{
        page = (length~/400).toInt() + 1;
    }
    List list = [];
    for(int i = 0; i < page;i++){
      int s = (i+1)*400;
      if(s >= article.length){
        s = article.length;
      }
      preNovels = Novel.fromJson(response);
      list.add(article.substring(400*i,s));
    } 
    preNovels.addAttr(list);
    setState(() {});
  }

  fetchNextArticle(String articleId) async {
    var response = await Request.get(action: 'article$articleId');
    if("err" == response){
      return;
    }
    String article = response['content'];
    int length = article.length;
    int page = 0;
    if(length % 400 == 0){
        page = (length~/400).toInt();
    }else{
        page = (length~/400).toInt() + 1;
    }
    List list = [];
    for(int i = 0; i < page;i++){
      int s = (i+1)*400;
      if(s >= article.length){
        s = article.length;
      }
      nextNovels = Novel.fromJson(response);
      list.add(article.substring(400*i,s));
    } 
    nextNovels.addAttr(list);
     setState(() {});
  }
  onScroll() {
    if (pageIndex >= currentNovels.pageCount) {
      print('到达下个章节了');

      preNovels = currentNovels;
      currentNovels = nextNovels;
      nextNovels = null;
      pageIndex = 0;
      pageController.jumpToPage(preNovels.pageCount);
      fetchNextArticle(currentNovels.nextArticleId);
      setState(() {});
    }
    if (preNovels != null && pageIndex < preNovels.pageCount - 1) {
      print('到达上个章节了');

      nextNovels = currentNovels;
      currentNovels = preNovels;
      preNovels = null;
      pageIndex = currentNovels.pageCount - 1;
      pageController.jumpToPage(currentNovels?.pageCount??1 - 1);
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
    // int itemCount = (preNovels != null ? preNovels?.pageCount??0 : 0) + currentNovels?.pageCount + (nextNovels != null ? nextNovels?.pageCount??0 : 0);
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
      article = nextNovels;
      page = nextNovels.pageCount - 1;
    } else {
      article = this.currentNovels;
    }
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 10, 30),
          child: RichText(
            text:TextSpan(
              text:article.getContent(page),
              style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 20.0),
            )
          ),
        ),
      ],
    );
  }
}

