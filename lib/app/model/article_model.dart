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
    id = "0000";
    imageUrl = "asset/books/1.jpg";
    title = "三寸人间";
    author = "耳根";
    summary = "举头三尺无神明，掌心三寸是人间。这是耳根继《仙逆》《求魔》《我欲封天》《一念永恒》后，创作的第五部长篇小说《三寸人间》。举头三尺无神明，掌心三寸是人间。这是耳根继《仙逆》《求魔》《我欲封天》《一念永恒》后，创作的第五部长篇小说《三寸人间》。举头三尺无神明，掌心三寸是人间。这是耳根继《仙逆》《求魔》《我欲封天》《一念永恒》后，创作的第五部长篇小说《三寸人间》。";
  }
}