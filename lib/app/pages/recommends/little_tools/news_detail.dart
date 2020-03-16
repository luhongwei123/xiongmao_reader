import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/app_http_utils.dart';
import 'package:xiongmao_reader/app/components/public.dart';


class NewsDetailScene extends StatefulWidget {
  final int index;
  NewsDetailScene(this.index);
  @override
  _NewsDetailSceneState createState() => _NewsDetailSceneState();
}

class _NewsDetailSceneState extends State<NewsDetailScene> with OnLoadReloadListener,AutomaticKeepAliveClientMixin{
  LoadStatus _loadStatus = LoadStatus.LOADING;
  int page =1;
  @override
  void initState() {
    super.initState();
    init();
  }
  init () async{
    await HttpUtils.getMsgList(this.widget.index,page).then((response) {
      List list = response['data'] as List;
      print(list);
      setState(() {
        _loadStatus = LoadStatus.SUCCESS;
      });
    }).catchError((e) {
      setState(() {
        _loadStatus = LoadStatus.FAILURE;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('测试${this.widget.index}'),
    );
  }

  @override
  void onReload() {
  }

  @override
  bool get wantKeepAlive => true;
}