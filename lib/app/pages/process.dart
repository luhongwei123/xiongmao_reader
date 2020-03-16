// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'dart:io';

// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:install_plugin/install_plugin.dart';
// import 'package:package_info/package_info.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:xiongmao_reader/app/components/constants.dart';
// import 'package:xiongmao_reader/app/components/progress_dialog.dart';
// import 'package:xiongmao_reader/app/components/requests.dart';

// import '../components/app_color.dart';

// class ProcessorScene extends StatefulWidget {
//   @override
//   _ProcessorSceneState createState() => _ProcessorSceneState();
// }

// class _ProcessorSceneState extends State<ProcessorScene> {
//    String buildNumber = ""; //版本号
//   String packageName = ""; //包名
//   String _externalDocumentsDirectory; //返回存储目录
//   String _appPath; //更新安装包的路径

//   bool _loading = false;
//   int countTemp = 0; //下载进度
//   String _loadingMsg = "";

//   String apkUrl = "https://luhongwei123.gitee.io/version/app-release.apk"; //apk下载地址
//   String plistUrl; //plist下载地址（企业版）
//   String appstoreUrl; //打开appstore下载地址（非企业版）

//   @override
//   void initState() {
//     super.initState();
//     Constants.requestExternalStorageDirectory().then((path) {
//       _externalDocumentsDirectory = path;
//       _appPath = _externalDocumentsDirectory + "/app-release.apk";
//       print('app路径为:$_appPath');
//     });
    
//     PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
//       buildNumber = packageInfo.buildNumber;
//       packageName = packageInfo.packageName;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ProgressDialog(
//       loading: _loading,
//       msg: _loadingMsg,
//       child: Scaffold(
//         body: new Center(
//           child: new Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               new Text(
//                 '我的',
//                 textAlign: TextAlign.center,
//                 style: new TextStyle(
//                     color: Colors.red[500],
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.bold),
//               ),
//               RaisedButton(
//                 child: Text("检查更新"),
//                 onPressed: () {
//                   //检查更新
//                   _checkUpdate();
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

  
// }