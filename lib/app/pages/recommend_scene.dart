import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class RecommendScene extends StatefulWidget {
  @override
  _RecommendSceneState createState() => _RecommendSceneState();
}

class _RecommendSceneState extends State<RecommendScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_buildAppBar(0),
      body: Text(''),
    );
  }

   //appbar
  Widget _buildAppBar(int index) {
    var appbar;
      switch (index) {
        case 0:
          appbar = new AppBar(
            elevation: 0,
            title: new Text("精选推荐",style: new TextStyle(color: Colors.white)),
            iconTheme: new IconThemeData(color: Colors.white),
            backgroundColor: AppColor.red,
            brightness: Brightness.dark,
            actions: [
              IconButton(
                padding:EdgeInsets.all(0),
                icon: Icon(CupertinoIcons.search),
                iconSize: 24,
                onPressed: () => {},
                splashColor: Colors.transparent,
                highlightColor:Colors.transparent
              ),
              IconButton(
                padding:EdgeInsets.all(4),
                icon: Icon(CupertinoIcons.time),
                iconSize: 24,
                onPressed: () => {},
                splashColor: Colors.transparent,
                highlightColor:Colors.transparent
              ),
              IconButton(
                padding:EdgeInsets.all(0),
                icon: Icon(CupertinoIcons.ellipsis),
                iconSize: 24,
                onPressed: () => {},
                splashColor: Colors.transparent,
                highlightColor:Colors.transparent
              ),
            ],
          );
          break;
      }
      return appbar;
  }
}