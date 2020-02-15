//当前天气
class CurrentWeather{
  String address;// 城市具体信息，比如 “广东省 深圳市”
  String cityCode;// 城市code
  String temp;// 温度值
  String weather;//天气描述
  String windDirection;// 风向描述
  String windPower;// 风力描述
  String humidity;// 湿度值
  String reportTime;// 此次天气发布时间

  CurrentWeather.fromJson(Map data){
    address = data['address'];
    cityCode = data['cityCode'];
    temp = data['temp'];
    weather = data['weather'];
    windDirection = data['windDirection'];
    windPower = data['windPower'];
    humidity = data['humidity'];
    reportTime = data['reportTime'];
  }
}