import 'package:xiongmao_reader/app/components/public.dart';
import 'package:flutter/material.dart';



class IndexSwiper extends StatefulWidget {
  final List imageUrls;
  IndexSwiper({this.imageUrls});
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
            children: _buildSwiper()
            ),
          ),
        ),
    );
  }
  List<Widget> _buildSwiper(){
    List<Widget> list = [];
    this.widget.imageUrls.forEach((item){
      var image = InkWell(
        //如果是网络图片 推荐使用CachedNetworkImage
        child: Image.asset(item["url"], fit: BoxFit.fill, ),
        onTap: (){
          Fluttertoast.showToast(msg:item["url"]);
        },
      );
      list.add(image);
    });
    return list;
  }
}