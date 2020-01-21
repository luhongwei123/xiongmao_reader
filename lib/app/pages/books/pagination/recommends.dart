import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';

class WeeksRecommends extends StatelessWidget {

  final Map recommends;

  WeeksRecommends({
    this.recommends
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: < Widget > [
          _firstRecommond(context, this.recommends['firstRecommands']),
          _otherRecommond(context, this.recommends['otherRecommands'] as List),
        ],
      )
    );
  }
  Widget _firstRecommond(BuildContext context, Map map) {
    return InkWell(
      child: Container(
        child: Row(
          children: < Widget > [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: CachedNetworkImage(
                    imageUrl: map['url']+'',
                    // fit: fit == null ? BoxFit.cover : fit,
                    width: ScreenUtil().setWidth(165),
                    // height: height,
                  )
                ),
              ],
            ),
            Column(
              children: < Widget > [
                Container(
                  width: ScreenUtil().setWidth(550),
                  child: Text(map['title'],
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
                  child: Text(map['summary'],
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
                    children: < Widget > [
                      Image.asset("asset/icon/author.png", width: ScreenUtil().setWidth(30), height: ScreenUtil().setHeight(30)),
                      Text(map['author'],
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
      ),
      onTap: () {
        AppNavigator.toNovelDetail(context, map['articleId'].toString());
      }
    );
  }
  Widget _otherRecommond(BuildContext context, List list) {
    List < Widget > returnList = [];
    list.forEach((item) {
      var widget = Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: < Widget > [
            InkWell(
              onTap: () {
                AppNavigator.toNovelDetail(context, item['articleId'].toString());
              },
              child: CachedNetworkImage(
                    imageUrl: item['url'].toString(),
                    // fit: fit == null ? BoxFit.cover : fit,
                    width: ScreenUtil().setWidth(165),
                    // height: height,
                  ),
            ),
            Container(
              width: ScreenUtil().setWidth(165),
              child: Text(item['title'], style: TextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
            ),

          ],
        ),
      );
      returnList.add(widget);
    });
    return Row(
      children: returnList
    );
  }
}