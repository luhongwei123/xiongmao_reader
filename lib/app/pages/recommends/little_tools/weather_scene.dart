import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class WeatherScene extends StatefulWidget {
  @override
  _WeatherSceneState createState() => _WeatherSceneState();
}

class _WeatherSceneState extends State < WeatherScene > with OnLoadReloadListener{
  LoadStatus _loadStatus = LoadStatus.LOADING;
  @override
  void initState() {
    super.initState();
    AMapLocationClient.setApiKey("8c25000207844e854f51e67a8322ecca");
    requestPermission();
  }

  Future requestPermission() async {
    // 申请权限
    Map < PermissionGroup, PermissionStatus > permissions =
      await PermissionHandler()
      .requestPermissions([PermissionGroup.location]);
    // 申请结果
    PermissionStatus permission = await PermissionHandler()
      .checkPermissionStatus(PermissionGroup.location);

    if (permission == PermissionStatus.granted) {
      await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy:
        CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
      AMapLocation location = await AMapLocationClient.getLocation(true);
    } else {
      setState(() {
        _loadStatus = LoadStatus.FAILURE;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  _loadStatus == LoadStatus.LOADING ?
            LoadingView() :
            _loadStatus == LoadStatus.FAILURE ?
            FailureView(this) :Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(children: < Widget > [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.blue, Colors.blue.withOpacity(0.4)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: < Widget > [
              SizedBox(height: ScreenUtil().setHeight(100)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "北京",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(60),
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                ),
              ),
              // SizedBox(height: ScreenUtil().setHeight(100)),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: < Widget > [
                    Text(
                      '12°',
                      style: TextStyle(fontSize: 80.0, color: Colors.white),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: < Widget > [
                        SizedBox(height: 10.0),
                        Text(
                          '小雨',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(50)),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: < Widget > [
                    Row(
                      children: < Widget > [
                        Column(
                          children: < Widget > [
                            Image.asset(
                              'asset/recommends/weather/wind_direction.png',
                              width: ScreenUtil().setWidth(60),
                            ),
                            Text(
                              '风力',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(20)),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(20)),
                          child: Text('东南风2-3级',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(20))))
                      ],
                    ),
                    Row(
                      children: < Widget > [
                        Column(
                          children: < Widget > [
                            Image.asset(
                              'asset/recommends/weather/humidity.png',
                              width: ScreenUtil().setWidth(60),
                            ),
                            Text(
                              '湿度',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(20)),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(20)),
                          child: Text('80%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(20))))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: ScreenUtil().setHeight(800),
          bottom: ScreenUtil().setHeight(0),
          left: 0,
          right: 0,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: <Widget>[
                    Text('周一', style: TextStyle(color: AppColor.weather)),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Text('小雨', style: TextStyle(color: AppColor.weather)),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Text('2 ℃ ~ 16 ℃', style: TextStyle(color: AppColor.weather)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('周二', style: TextStyle(color: AppColor.weather)),
                     SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Text('小雨', style: TextStyle(color: AppColor.weather)),
                     SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Text('2 ℃ ~ 16 ℃', style: TextStyle(color: AppColor.weather)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('周三', style: TextStyle(color: AppColor.weather)),
                     SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Text('小雨', style: TextStyle(color: AppColor.weather)),
                     SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Text('2 ℃ ~ 16 ℃', style: TextStyle(color: AppColor.weather)),
                  ],
                ),
              ]
            ),
          ),
        ),
        RefreshIndicator(
          onRefresh: () async {

          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Center(child: SizedBox(height: 500.0)),
          ),
        ),
      ]),
    );
  }

  @override
  void onReload() {
    setState(() {
      _loadStatus = LoadStatus.LOADING;
    });
  }
}
