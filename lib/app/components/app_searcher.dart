import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

class TextSearcher extends StatelessWidget implements PreferredSizeWidget {
  @override Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: ScreenUtil().setWidth(500),
        height: ScreenUtil().setHeight(70),
        padding: EdgeInsets.all(0),
        child: TextField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          maxLines: 1,
          enabled: false,
          style: TextStyle(
            fontSize: ScreenUtil().setHeight(300)
          ),
          decoration: InputDecoration(
            hintText: '重生之后。。。',
            hintStyle: TextStyle(
              color: AppColor.darkGray,
              fontSize: ScreenUtil().setSp(25),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: AppColor.red
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().setWidth(28)),
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