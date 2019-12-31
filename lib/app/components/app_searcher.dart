import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextSearcher extends StatelessWidget implements PreferredSizeWidget {
  @override Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: ScreenUtil().setWidth(300),
        height: ScreenUtil().setHeight(50),
        padding: EdgeInsets.all(0),
        child: TextField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          maxLines: 1,
          style: TextStyle(
            fontSize: ScreenUtil().setHeight(300)
          ),
          decoration: InputDecoration(
            hintText: '请输入内容',
            hintStyle: TextStyle(
              color: Colors.amber,
              fontSize: ScreenUtil().setSp(20),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.amber
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
            filled: true,
            fillColor: Colors.grey[10],
            border: InputBorder.none
          ),
          onChanged: (str) {

          },
        )
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 20);
}