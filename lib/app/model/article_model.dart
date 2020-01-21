import '../components/http_request.dart';

class Article{
  String id;//id
  String imageUrl;//图片地址
  String title;//标题
  String summary;//简介
  String author;//作者
  String kinds;//类型
  bool isComplete;//是否完结
  bool isVIP;//是否是vip书籍--暂时不考虑
  String lastUptime;//最后更新时间 

  //test data
  Article.fromJson(Map data){
    id = "${data['id']}";
    imageUrl = Request.baseImageUrl +"${data['id']}";
    title = data['name'];
    author = data['author'];
    summary = data['description'] == null ? data['summary'] : data['description'];
  }
}