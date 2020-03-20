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
  CurrentWeather currentWeather;
  List <ForecastWeather> weatherList;
  String cityName;
  @override
  void initState() {
    super.initState();
    AMapLocationClient.setApiKey("8c25000207844e854f51e67a8322ecca");
    requestPermission();
  }

  Future requestPermission() async {
    // 申请权限
    Map < PermissionGroup, PermissionStatus > permissions = await PermissionHandler().requestPermissions([PermissionGroup.location]);
    // 申请结果
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
    if (permission == PermissionStatus.granted) {
      await AMapLocationClient.startup(new AMapLocationOption(desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
      await AMapLocationClient.getLocation(true).then((response) {
        if (response.city != null && response.city != "") {
          setState(() {
            cityName = response.city;
          });
          _getCurrentWeather(response.city);
        }
      });
    } else {
      setState(() {
        _loadStatus = LoadStatus.FAILURE;
      });
    }
  }
  _getCurrentWeather(String city) async{
    await HttpUtils.getCurrentWeather(city).then((response){
      currentWeather = CurrentWeather.fromJson(response['data']);
      _getForecastWeather(city);
    }).catchError((e){
      setState(() {
        _loadStatus = LoadStatus.FAILURE;
      });
    });
  }
  _getForecastWeather(String city) async{
    await HttpUtils.getForecastWeather(city).then((response){
      List list = response['data']["forecasts"] as List;
      List<ForecastWeather> temp = [];
      list.forEach((item){
        temp.add(ForecastWeather.fromJson(item));
      });
      weatherList = temp;
      _loadStatus = LoadStatus.SUCCESS;
      setState(() {});
    }).catchError((e){
      setState(() {
        _loadStatus = LoadStatus.FAILURE;
      });
    });
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
                  currentWeather.address,
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
                      currentWeather.temp,
                      style: TextStyle(fontSize: ScreenUtil().setSp(90), color: Colors.white),
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: < Widget > [
                        Text(
                          currentWeather.weather,
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
                          child: Text(
                            currentWeather.windDirection +"风"+currentWeather.windPower,
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
                          child: Text(
                            currentWeather.humidity,
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
              children: _buildItem(),
            ),
          ),
        ),
        RefreshIndicator(
          onRefresh: () async {
            _getCurrentWeather(cityName);
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Center(child: SizedBox(height: 500.0)),
          ),
        ),
        Positioned(
            top: 27.0,
            right: 0.0,
            child: IconButton(
              icon: Image.asset('asset/recommends/weather/setting.png'),
              onPressed: () {
                 _clickEventFunc().then((result){
                   setState(() {
                     cityName = result.areaName;
                   });
                  _getCurrentWeather(cityName);
                });
                // showModalBottomSheet(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return Column(R
                //       mainAxisSize: MainAxisSize.min,
                //       children: <Widget>[
                //         ListTile(
                //           title: Text('选择其他城市'),
                //           onTap: () {
                           
                //           },
                //         ),
                //         // Divider(height: 0.0),
                //       ],
                //     );
                //   },
                // );
              },
            ),
          )
      ]),
    );
  }
  Future<Result> _clickEventFunc() async{
    Result tempResult = await CityPickers.showCityPicker(
      context: context,
      theme: Theme.of(context).copyWith(primaryColor: Color(0xfffe1314)), // 设置主题
      // locationCode: resultArr != null ? resultArr.areaId ?? resultArr.cityId ?? resultArr.provinceId : null, // 初始化地址信息
      cancelWidget: Text(
        '取消',
        style: TextStyle(fontSize: ScreenUtil().setSp(26),color: Color(0xff999999)),
      ),
      confirmWidget: Text(
        '确定',
        style: TextStyle(fontSize: ScreenUtil().setSp(26),color: Color(0xfffe1314)),
      ),
      height: 220.0
    );
    if(tempResult != null){
      return tempResult;
    }
    return tempResult;
  }
  List<Widget> _buildItem(){
    List<Widget> list = [];
    // if(weatherList != null && weatherList.length > 0){
      weatherList.removeAt(0);
      weatherList.forEach((item){
        var widget = Column(
          children: <Widget>[
            Text(item.date, style: TextStyle(color: AppColor.weather)),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Text('日间 '+item.dayWeather, style: TextStyle(color: AppColor.weather)),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Text('夜间 '+item.nightWeather, style: TextStyle(color: AppColor.weather)),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Text(item.nightTemp +' ~ '+item.dayTemp, style: TextStyle(color: AppColor.weather)),
          ],
        );
        list.add(widget);
      });
    // }
    return list;
  }

  @override
  void onReload() {
    setState(() {
      _loadStatus = LoadStatus.LOADING;
    });
    _getCurrentWeather(cityName);
  }
}
