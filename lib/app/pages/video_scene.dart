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
  final flutterWebviewPlugin = new WebviewPlugin();
  // 光标跳转的输入框对象
  FocusNode secondTextFieldNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
      appBar: _buildAppBar(0),
      body: _loadStatus == LoadStatus.LOADING ?
      LoadingView() :
      _loadStatus == LoadStatus.FAILURE ?
      FailureView(this) : _buildBody(),
    ),
    onWillPop: () async{
        // 点击返回键的操作
       if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
          lastPopTime = DateTime.now();
          Fluttertoast.showToast(msg: '再按一次退出');
        }else{
          lastPopTime = DateTime.now();
          // 退出app
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
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
        );
        break;
    }
    return appbar;
  }

  Widget _buildBody() {
    return Container(
      child: Row(
      children: <Widget>[
        Expanded(
          child: new TextField(
            controller: passController,
            keyboardType: TextInputType.text,
            cursorColor: Colors.white,
            focusNode: secondTextFieldNode,
            textInputAction: TextInputAction.done,
            obscureText: true,
            style: new TextStyle(color: AppColor.textBlack3),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
                hintText: '请输入密码',
                hintStyle: new TextStyle(color: AppColor.textBlack3)),
            autofocus: false,
          ),
        ),
        RaisedButton(
          onPressed: () {
            // login();\
            secondTextFieldNode.unfocus();
            if(passController.text =='Aa567654112'){
                flutterWebviewPlugin.launch("https://福利之家.com/?addfb", (data) {},rect: new Rect.fromLTWH(
                      0.0,
                      0.0,
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height));
            }else{
              Fluttertoast.showToast(msg: "暂时没有开发呢呦！");
            }
          },
          color: new Color(0xffFE9A18),
          child: new Text(
            "登录",
            style: new TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ],
    ));
  }

  @override
  void onReload() {
    // TODO: implement onReload
  }
}
