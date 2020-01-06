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
      height: ScreenUtil().setHeight(250),
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
      height: ScreenUtil().setHeight(160),
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
      height: ScreenUtil().setHeight(80),
      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: < Widget > [
          Text(title, textDirection: TextDirection.ltr, ),
          Expanded(child: Text('更多', textDirection: TextDirection.rtl, ), flex: 2, ),
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
    return SingleChildScrollView(
      child: Column(
        children: < Widget > [
          _firstRecommond(),
          _otherRecommond(),
        ],
      )
    );
  }
  Widget _firstRecommond() {
    return Container(
      child: Row(
        children: < Widget > [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Image.asset('asset/books/1.jpg', width: ScreenUtil().setWidth(165)),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(550),
                child: Text('三寸人间',
                  textAlign: TextAlign.left, //文本对齐方式  居中
                  textDirection: TextDirection.ltr, //
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: ScreenUtil().setWidth(550),
                child: Text('举头三尺无神明，掌心三寸是人间。这是耳根继《仙逆》《求魔》《我欲封天》《一念永恒》后，创作的第五部长篇小说《三寸人间》。',
                  textAlign: TextAlign.left, //文本对齐方式  居中
                  textDirection: TextDirection.ltr, //
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15)
                  ),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(550),
                child: Row(
                  children: <Widget>[
                    Image.asset("asset/icon/author.png",width: ScreenUtil().setWidth(30),height: ScreenUtil().setHeight(30)),
                    Text("耳根",
                      textAlign: TextAlign.left, //文本对齐方式  居中
                      textDirection: TextDirection.ltr, 
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(15)
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  Widget _otherRecommond() {
    return Row(
      children: < Widget > [
        Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: < Widget > [
              InkWell(
                onTap: () {},
                child: Image.asset('asset/books/1.jpg', width: ScreenUtil().setWidth(165), ),
              ),
              Text('三寸人间'),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: < Widget > [
              InkWell(
                onTap: () {},
                child: Image.asset('asset/books/2.jpg', width: ScreenUtil().setWidth(165)),
              ),
              Text('圣墟'),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: < Widget > [
              InkWell(
                onTap: () {},
                child: Image.asset('asset/books/3.jpg', width: ScreenUtil().setWidth(165)),
              ),
              Text('绝品邪少'),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: < Widget > [
              InkWell(
                onTap: () {},
                child: Image.asset('asset/books/4.jpg', width: ScreenUtil().setWidth(165)),
              ),
              Text('道君')
            ],
          ),
        ),
      ]
    );
  }
}