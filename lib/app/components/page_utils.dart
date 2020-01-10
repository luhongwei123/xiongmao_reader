import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/model/novel_model.dart';

class PageUtils{

  static page(String article,Novel novel){
    List<Map<String,int>> listPages = pageNumber(article);
    List list = [];
    for(int i = 0; i < listPages.length;i++){
      Map info = listPages[i];
      list.add(article.substring(info['start'],info['end']));
    }
    novel.addAttr(list);
  }

  static List<Map<String, int>> pageNumber(String article){
    var contentHeight = ScreenUtil().setHeight(1334 - 60  - 20.0);
    var contentWidth = ScreenUtil().setWidth(750.0-20-20);
    String tempStr = article;
    List<Map<String, int>> pageConfig = [];
    int last = 0;
    while (true) {
      Map<String, int> offset = {};
      offset['start'] = last;
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(text: tempStr, style: TextStyle(fontSize: ScreenUtil().setSp(35)));
      textPainter.layout(maxWidth: contentWidth);
      var end = textPainter.getPositionForOffset(Offset(contentWidth, contentHeight)).offset;

      if (end == 0) {
        break;
      }
      tempStr = tempStr.substring(end, tempStr.length);
      offset['end'] = last + end;
      last = last + end;
      pageConfig.add(offset);
    }
    return pageConfig;
  }
}