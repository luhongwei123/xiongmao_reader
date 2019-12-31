import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              // print('调用了第${index+1}次');
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
        widget = Navigator();
        break;
      case 2:
        // widget = IndexSwiper();
        break;
      case 3:
        // widget = Navigator();
        break;
      case 4:
        // widget = IndexSwiper();
        break;
      case 5:
        // widget = Navigator();
        break;
    }
    return widget;
  }
}

//首页轮播组件
class IndexSwiper extends StatefulWidget {
  @override
  _IndexSwiperState createState() => _IndexSwiperState();
}

class _IndexSwiperState extends State < IndexSwiper > {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(300),
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: AspectRatio(
          aspectRatio: 16.0 / 9.0,
          child: Swiper(
            indicatorAlignment: AlignmentDirectional.bottomEnd,
            speed: 400,
            indicator: CircleSwiperIndicator(),
            children: < Widget > [
              Image.asset("asset/sea.png", fit: BoxFit.fill, ),
              Image.asset("asset/star.jpg", fit: BoxFit.fill),
              Image.asset("asset/road.jpg", fit: BoxFit.fill, ),
              Image.asset("asset/star.jpg", fit: BoxFit.fill, ),
            ],
          ),
        ),
      ),
    );
  }
}

class Navigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(300),
      padding: EdgeInsets.all(10),
      child: GridView.count(
        crossAxisCount: 5,
        physics: new NeverScrollableScrollPhysics(), //增加
        shrinkWrap: true, //增加
        padding: EdgeInsets.all(3),
        children: < Widget > [
          InkWell(
            onTap: () {},
            child: Column(
              children: < Widget > [
                Image.asset('asset/icon/kinds.png', width: ScreenUtil().setWidth(80)),
                Text('分类'),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Column(
              children: < Widget > [
                Image.asset('asset/icon/ranking.png', width: ScreenUtil().setWidth(80)),
                Text('排行'),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Column(
              children: < Widget > [
                Image.asset('asset/icon/books.png', width: ScreenUtil().setWidth(80)),
                Text('书单'),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Column(
              children: < Widget > [
                Image.asset('asset/icon/articles.png', width: ScreenUtil().setWidth(80)),
                Text('网文'),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Column(
              children: < Widget > [
                Image.asset('asset/icon/shares.png', width: ScreenUtil().setWidth(80)),
                Text('书友分享'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
