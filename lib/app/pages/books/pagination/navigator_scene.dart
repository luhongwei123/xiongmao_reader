import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class NavigatorScene extends StatelessWidget {

  final List navigators;
  NavigatorScene({this.navigators});

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
        children: _buildNavigator(),
      ),
    );
  }
  List<Widget> _buildNavigator(){
    List<Widget> list = [];
    navigators.forEach((item){
      var widget = InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Fluttertoast.showToast(msg:item['title']);
            },
            child: Column(
              children: < Widget > [
                Image.asset(item['url'], width: ScreenUtil().setWidth(80)),
                Text(item['title']),
              ],
            ),
          );
        list.add(widget);
    });
    return list;
  }
}