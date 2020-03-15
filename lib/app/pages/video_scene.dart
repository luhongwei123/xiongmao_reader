import 'package:flutter/material.dart';
import 'package:webview_plugin/webview_plugin.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class VideoScene extends StatefulWidget {
  @override
  _VideoSceneState createState() => _VideoSceneState();
}

class _VideoSceneState extends State<VideoScene> with OnLoadReloadListener{
  String message = "--";
  String _title = '视频大全';
  LoadStatus _loadStatus = LoadStatus.SUCCESS;
  DateTime lastPopTime;
  //密码的控制器
  TextEditingController passController = TextEditingController();
  // final flutterWebviewPlugin = new WebviewPlugin();
  // 光标跳转的输入框对象
  FocusNode secondTextFieldNode = FocusNode();
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return 
    WillPopScope(
      child: 
      
      Scaffold(
      appBar: _buildAppBar(0),
      body: _loadStatus == LoadStatus.LOADING ?
      LoadingView() :
      _loadStatus == LoadStatus.FAILURE ?
      FailureView(this) : _buildBody(),
    ),
    onWillPop: () async{
        // 点击返回键的操作
        Navigator.of(context).pop();
        return false;
      }
    );
  }

  //appbar
  Widget _buildAppBar(int index) {
    var appbar;
    switch (index) {
      case 0:
        appbar = new AppBar(
          elevation: 0,
          title: new Text(_title, style: new TextStyle(color: AppColor.red)),
          iconTheme: new IconThemeData(color: Colors.white),
          backgroundColor: AppColor.paper,
          brightness: Brightness.light,
          leading: Container(
            child:InkWell(
              child:Icon(Icons.arrow_back_ios)
            ),
          ),
        );
        break;
    }
    return appbar;
  }

  Widget _buildBody() {
    return Container(
      child:   WebviewPlugin(url: "https://99a34.com",left: 0,right: 0,));
  }

  @override
  void onReload() {
    // TODO: implement onReload
  }
}
