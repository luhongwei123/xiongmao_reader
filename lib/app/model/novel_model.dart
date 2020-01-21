class Novel {
  int id;
  int novelId;
  int num;
  String title;
  int nextArticleId;
  int preArticleId;
  String contentAttr;
  
  int get pageCount{
    return contentAttr.length;
  }
  String getContent(int index){
    return contentAttr[index].toString();
  }
  Novel.fromJson(Map data){
    id = data['catalog']['id'];
    novelId = data['catalog']['bookId'];
    num = data['catalog']['num'];
    title = data['catalog']['name'];
    nextArticleId = data['nextCatalog']['id'];
    preArticleId = data['lastCatalog']['id'];
    contentAttr = data['container'];
  }
}