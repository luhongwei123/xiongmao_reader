import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



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