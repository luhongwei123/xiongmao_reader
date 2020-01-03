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
        widget = FloorTitle(title: '一周热门书籍推荐');
        break;
      case 3:
        widget = WeeksRecommends();
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
      // height: ScreenUtil().setHeight(400),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
class FloorTitle extends StatelessWidget {

  final String title;
  FloorTitle({
    this.title
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(40),
      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: < Widget > [
          Text(title,textDirection:TextDirection.ltr,),
          Expanded(child:Text('更多', textDirection:TextDirection.rtl, ),flex: 2,),
          InkWell(
            onTap: () {},
            child: Icon(
              IconData(
                //code
                0xe315,
                //字体
                fontFamily: 'MaterialIcons'),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))
      )
    );
  }
}

class WeeksRecommends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset('asset/books/1.jpg')
            ],
          ),
          GridView.count(
            crossAxisSpacing: 3.0,
            crossAxisCount: 4,
            // physics: new NeverScrollableScrollPhysics(), //增加
            shrinkWrap: true, //增加
            padding: EdgeInsets.all(0),
            children: < Widget > [
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){},
                      child:Image.asset('asset/books/1.jpg'),
                    ),
                    Text('三寸人间')
                  ],
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){},
                      child: Image.asset('asset/books/2.jpg',
                        // height: ScreenUtil().setHeight(158)
                      ),
                    ),
                    Text('圣墟')
                  ],
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){},
                      child: Image.asset('asset/books/3.jpg',
                        // height: ScreenUtil().setHeight(158)
                      ),
                    ),
                    Text('绝品邪少')
                  ],
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){},
                      child: Image.asset('asset/books/4.jpg',
                        // height: ScreenUtil().setHeight(158)
                      ),
                    ),
                    Text('道君')
                  ],
                )
            ]
          )
        ],
      )
    );
  }
}