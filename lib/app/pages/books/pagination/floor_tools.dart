import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FloorTitle extends StatelessWidget {
  final String title;
  FloorTitle({this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Fluttertoast.showToast(msg: "暂时没有更多哦！");
      },
      child: Container(
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title,
              textDirection: TextDirection.ltr,
            ),
            Expanded(
              child: Text( '更多', textDirection: TextDirection.rtl,),
              flex: 2,
            ),
            Icon(
              IconData(0xe315,fontFamily: 'MaterialIcons'),
            ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xffe5e5e5))
          ),
        ),
      ),
    );
  }
}
