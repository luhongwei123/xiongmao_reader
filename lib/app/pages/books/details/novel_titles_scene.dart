import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';

class NovelTitlesScene extends StatefulWidget {
  @override
  _NovelTitlesSceneState createState() => _NovelTitlesSceneState();
}

class _NovelTitlesSceneState extends State < NovelTitlesScene > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(IconData(0xe314, fontFamily: 'MaterialIcons'), color: AppColor.darkGray,),
        ),
        centerTitle: true,
        title: Text('三寸人间',style: TextStyle(color: AppColor.darkGray),),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: InkWell(
        splashColor: Colors.white,
        onTap: () {
          AppNavigator.toNovelReaders(context,"0000");
        },
        child: Container(
          color: Colors.white,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: CupertinoScrollbar(
              child: ListView.separated(
                shrinkWrap:true,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                    child: Text("${index+1}.第测试${index+1}章"),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: 40),
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior  extends ScrollBehavior{
 @override
 Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    if(Platform.isAndroid||Platform.isFuchsia){
     return child;
  }else{
    return super.buildViewportChrome(context,child,axisDirection);
    }
 }
}