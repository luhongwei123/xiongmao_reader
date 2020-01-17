class Novel {
  String id;
  String novelId;
  String title;
  String nextArticleId;
  String preArticleId;
  String contentAttr;
  
  int get pageCount{
    return contentAttr.length;
  }
  String getContent(int index){
    return contentAttr[index].toString();
  }
  Novel.fromJson(Map data){
    id = data['id'];
    novelId = data['novel_id'];
    title = data['title'];
    nextArticleId = data['next_id'];
    preArticleId = data['prev_id'];
    contentAttr = data['content'];
  }
}