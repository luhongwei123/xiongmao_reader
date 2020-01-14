import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';

class WeeksRecommends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: < Widget > [
          _firstRecommond(context),
          _otherRecommond(context),
        ],
      )
    );
  }
  Widget _firstRecommond(BuildContext context) {
    return InkWell(
      child: Container(
        child: Row(
          children: < Widget > [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset('asset/books/1.jpg', width: ScreenUtil().setWidth(165)),
                ),
              ],
            ),
            Column(
              children: < Widget > [
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
                    children: < Widget > [
                      Image.asset("asset/icon/author.png", width: ScreenUtil().setWidth(30), height: ScreenUtil().setHeight(30)),
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
      ),
      onTap: () {
        AppNavigator.toNovelDetail(context);
      }
    );
  }
  Widget _otherRecommond(BuildContext context) {
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