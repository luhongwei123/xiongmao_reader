import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/model/version_model.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import 'package:xiongmao_reader/app/components/public.dart';

class ProcessorScene extends StatefulWidget {
  @override
  _ProcessorSceneState createState() => _ProcessorSceneState();
}

class _ProcessorSceneState extends State<ProcessorScene> {
  OtaEvent currentEvent;
  VersionModel serviceVersion;

  @override
  void initState() {
    super.initState();
    _checkVersion();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentEvent != null && serviceVersion != null ? AppBar(
        title: const Text('更新应用'),
      ) : null,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset(
                'asset/logo.png', height: 40, width: 100,),
              Container(
                height: 100,
                //如果currentEvent不为空则展示加载条
                child: currentEvent != null ? Column(
                  children: <Widget>[
                    double.tryParse(currentEvent.value) is double
                      ? LinearProgressIndicator(
                      semanticsLabel: currentEvent.value,
                      value: double.tryParse(currentEvent.value) / 100,
                      semanticsValue: currentEvent.value,
                    )
                      : Container(),
                    Container(
                      child: Text(
                        '${currentEvent.status == OtaStatus.DOWNLOADING
                          ? '下载中'
                          : (currentEvent.status == OtaStatus.INSTALLING
                          ? '安装中...'
                          : '')} ${(currentEvent.status == OtaStatus.DOWNLOADING
                          ? ':'
                          : '')} ${currentEvent.value}${currentEvent.status ==
                          OtaStatus.DOWNLOADING ? '%' : ''} \n'),
                      margin: EdgeInsets.only(bottom: 50),
                    )
                  ],
                ) : Container()
              )
            ],
          ),
        ),
      )
    );
  }
  _getCurrentVersion()async{
    PackageInfo packageInfo=await PackageInfo.fromPlatform();
    var currentVersion=packageInfo.version;
    return currentVersion;
  }

  ///版本校验
  _checkVersion()async {
  /// 获得服务器版本
  //这写上获取json的url，json格式按照定义的versionModel
    String url='https://luhongwei123.gitee.io/version/version1.json';
    Response<String> response  = await Dio().get(url);
    if(response==null){
      //获取版本失败 网络或者其他原因 退出App
      //ToastUtil.showToast('获取版本失败');
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
    print(response);
    serviceVersion=VersionModel.fromJson(json.decode(response.toString()));
    var currentVersion = await _getCurrentVersion();
    print(currentVersion);
    if(currentVersion==serviceVersion.version){
      //验证通过
      // _goNextPage();
    }else{
      //版本不符弹出对话框
      _showUpdateDialog();
    }
  }

  
_showUpdateDialog(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_){
        List<Widget> contentList=[];
        var style=TextStyle(fontSize: 15,);
        contentList.addAll(serviceVersion.updateContent.map((item){
          return Text(item,style: style,);
        }).toList());
        contentList.insert(0, Container(height: 0.4,color: Colors.black,margin: EdgeInsets.only(top: 5,bottom: 5),));
        return CupertinoAlertDialog(
          title:Text('版本更新',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: contentList
            ),
          ),
          actions: <Widget>[
            // FlatButton(
            //   child: Text('取消'),
            //   textColor: Colors.grey,
            //   // onPressed: serviceVersion.mandatory?null:(){
            //   //   _goNextPage();
            //   // },
            // ),
            FlatButton(
              child: Text('更新'),
              textColor: Colors.blue,
              onPressed: ()async{
                if(Platform.isAndroid){
                  //安卓应用内下载
                  Navigator.pop(context);
                  tryOtaUpdate();
                }
                // }else{
                //   //ios 跳转商店
                //   if(await canLaunch(serviceVersion.iosAddress)){
                //     await launch(serviceVersion.iosAddress);
                //   }else{
                //     throw 'Could not launch ';
                //   }
                // }
              },
            )
          ],
        );
      }
    );
  }
  Future<void> tryOtaUpdate() async {
    try {
       OtaUpdate()
        .execute(serviceVersion.androidAddress, destinationFilename: 'task_app.apk')
        .listen(
          (OtaEvent event) {
          setState(() => currentEvent = event);
        },
      );
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }
}