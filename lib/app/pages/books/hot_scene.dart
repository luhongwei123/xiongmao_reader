import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/pages/books/pagination/floor_tools.dart';
import 'package:xiongmao_reader/app/pages/books/pagination/index_swiper.dart';
import 'package:xiongmao_reader/app/pages/books/pagination/navigator_scene.dart';
import 'package:xiongmao_reader/app/pages/books/pagination/recommends.dart';

class HotBookScene extends StatefulWidget {
  @override
  _HotBookScene createState() => _HotBookScene();
}

class _HotBookScene extends State < HotBookScene > with AutomaticKeepAliveClientMixin {
  Map resp = {};
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    Map hot = {};
    hot['imageUrls'] = [
      {"url":"asset/sea.png","text":"sea.png"},
      {"url":"asset/star.jpg","text":"star.jpg"},
      {"url":"asset/road.jpg","text":"road.jpg"},
      {"url":"asset/star.jpg","text":"star.jpg"}
    ];
    hot['navigaors'] = [
      {"url":"asset/icon/kinds.png","title":"分类"},
      {"url":"asset/icon/ranking.png","title":"排行"},
      {"url":"asset/icon/books.png","title":"书单"},
      {"url":"asset/icon/articles.png","title":"网文"},
      {"url":"asset/icon/shares.png","title":"书友分享"}
    ];
    hot['title'] = ["一周热门书籍推荐","畅销精选"]; 
    resp["hot"] = hot;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              //创建列表项
              return _getCompnents(index);
            },
          ),
        )
      ], );
  }

  Widget _getCompnents(int index) {
    var widget;
    switch (index) {
      case 0:
        widget = IndexSwiper(imageUrls: resp['hot']['imageUrls'],);
        break;
      case 1:
        widget = NavigatorScene(navigators: resp['hot']['navigaors'],);
        break;
      case 2:
        widget = FloorTitle(title: resp['hot']['title'][0]);
        break;
      case 3:
        widget = WeeksRecommends();
        break;
      case 4:
        widget = FloorTitle(title: resp['hot']['title'][1]);
        break;
      case 5:
        // widget = Navigator();
        break;
    }
    return widget;
  }
}