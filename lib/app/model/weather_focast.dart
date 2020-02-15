//未来天气
class ForecastWeather{
  String date;// 日期
  String dayOfWeek;// 星期
  String dayWeather;// 白天天气描述
  String nightWeather;// 晚上天气描述
  String dayTemp;//白天温度
  String nightTemp;// 晚上温度
  String dayWindDirection;// 白天风向
  String nightWindDirection;// 晚上风向
  String dayWindPower;// 白天风力
  String nightWindPower;// 晚上风力

  ForecastWeather.fromJson(Map data){
    date = data['date'];
    dayOfWeek = data['dayOfWeek'];
    dayWeather = data['dayWeather'];
    nightWeather = data['nightWeather'];
    dayTemp = data['dayTemp'];
    nightTemp = data['nightTemp'];
    dayWindDirection = data['dayWindDirection'];
    nightWindDirection = data['nightWindDirection'];
    dayWindPower = data['dayWindPower'];
    nightWindPower = data['nightWindPower'];
  }
}