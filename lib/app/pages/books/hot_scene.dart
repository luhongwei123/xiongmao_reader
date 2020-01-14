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

  @override
  bool get wantKeepAlive => true;

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
        widget = IndexSwiper();
        break;
      case 1:
        widget = NavigatorScene();
        break;
      case 2:
        widget = FloorTitle(title: '一周热门书籍推荐');
        break;
      case 3:
        widget = WeeksRecommends();
        break;
      case 4:
        widget = FloorTitle(title: '畅销精选');
        break;
      case 5:
        // widget = Navigator();
        break;
    }
    return widget;
  }
}