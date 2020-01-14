import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigatorScene extends StatelessWidget {
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