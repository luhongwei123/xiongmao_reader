import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/app_navigator.dart';
import 'package:xiongmao_reader/app/components/me_cell.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xiongmao_reader/app/components/constants.dart';
import 'package:xiongmao_reader/app/components/progress_dialog.dart';
import 'package:xiongmao_reader/app/components/requests.dart';

import '../components/app_color.dart';
class MineScene extends StatefulWidget {
  @override
  _MineSceneState createState() => _MineSceneState();
}

class _MineSceneState extends State < MineScene > {

  String buildNumber = ""; //版本号
  String packageName = ""; //包名
  String _externalDocumentsDirectory; //返回存储目录
  String _appPath; //更新安装包的路径

  int totalTemp;
  bool _loading = false;
  int countTemp = 0; //下载进度
  String _loadingMsg = "";

  String apkUrl = "https://luhongwei123.gitee.io/version/app-release.apk"; //apk下载地址
  String plistUrl; //plist下载地址（企业版）
  String appstoreUrl;
  @override
  void initState() {
    super.initState();
    // initXUpdate();
    Constants.requestExternalStorageDirectory().then((path) {
      _externalDocumentsDirectory = path;
      _appPath = _externalDocumentsDirectory + "/app-release.apk";
      print('app路径为:$_appPath');
    });

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      buildNumber = packageInfo.buildNumber;
      packageName = packageInfo.packageName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
      loading: _loading,
      msg: _loadingMsg,
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(color: AppColor.white),
          preferredSize: Size(ScreenUtil().setWidth(20), 0),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: < Widget > [
              _Header(),
              SizedBox(height: 10),
              buildCells(context),
            ],
          ),
        ),
      )
    );
  }

  Widget _Header() {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        color: AppColor.white,
        padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
        child: Row(
          children: < Widget > [
            CircleAvatar(
              radius: 40,
              backgroundImage: CachedNetworkImageProvider('http://b-ssl.duitang.com/uploads/item/201710/20/20171020164428_KXUMZ.thumb.700_0.jpeg'),
            ),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: < Widget > [
                  Text(
                    '社会人',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  // buildItems(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCells(BuildContext context) {
    return Container(
      child: Column(
        children: < Widget > [
          MeCell(
            title: '检查更新',
            iconName: 'asset/me/update.png',
            onPressed: () {
              _checkUpdate();
            },
          ),
          MeCell(
            title: '关于',
            iconName: 'asset/me/about.png',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
  _getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var currentVersion = packageInfo.version;
    return currentVersion;
  }

  ///检查更新
  Future < Null > _checkUpdate() async {
    String url = 'https://luhongwei123.gitee.io/version/version.json';
    Response < String > response = await Dio().get(url);
    if (response == null) {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
    print(response);
    var currentVersion = await _getCurrentVersion();
    Map map = json.decode(response.toString());

    List strs = map['ModifyContent'] as List;
    if (currentVersion != map['VersionName']) {
      setState(() {
        totalTemp = map['ApkSize'];
      });
      showDialog(
        // 设置点击 dialog 外部不取消 dialog，默认能够取消
        barrierDismissible: false,
        context: context,
        builder: (context) {
          List<Widget> contentList=[];

          var style=TextStyle(fontSize: 15,);
          contentList.addAll(strs.map((item){
            return Text(item.toString(),style: style,);
          }).toList());
          return WillPopScope(
            child: CupertinoAlertDialog(
              title: Text('提示'),
              // 标题文字样式
              content: Column(
                children: [
                  Text("有新版本，是否更新？"),
                  Column(
                    children:contentList
                  ),
                ]
              ),
              // dialog 的操作按钮，actions 的个数尽量控制不要过多，否则会溢出 `Overflow`
              actions: < Widget > [
                // 点击取消按钮
                FlatButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  child: Text(
                    '取消',
                    style: TextStyle(color: AppColor.ff828282),
                  )),
                FlatButton(
                  onPressed: (() {
                    Navigator.pop(context);
                      
                    if (Platform.isIOS) {
                      _launchURL(plistUrl);
                    } else {
                      //android直接下载安装包
                      executeDownload(apkUrl);
                    }
                  }),
                  child: Text('更新')),

                // 点击打开按钮
              ],
            ),
          );
        },
      );
    } else {
      Fluttertoast.showToast(msg: "当前为最新版本！");
    }

  }

  /// 打开网页
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// 下载文件
  Future < Null > executeDownload(String url) async {
    Fluttertoast.showToast(msg: "开始下载");

    setState(() {
      _loading = true;
    });

    Request.downloadFile(
      url: url,
      path: _appPath,
      onProgress: (count, total) {
        String percent = (count / totalTemp * 100).toStringAsFixed(1) + "%";
        //显示下载进度
        setState(() {
          _loadingMsg = percent;
        });
      },
      onError: (code, message) {
        Fluttertoast.showToast(msg: "下载失败");
        setState(() {
          _loading = false;
        });
      }).then((succeed) {
      Navigator.pop(context);
      setState(() {
        _loading = false;
      });
      if (succeed) {
        _installApk(_appPath);
      }
    });
  }

  // 调用android代码安装apk
  void _installApk(String path) {
    InstallPlugin.installApk(path, "com.example.xiongmao_reader");
  }
}
