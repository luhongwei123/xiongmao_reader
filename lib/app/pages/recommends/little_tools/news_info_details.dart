import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/app_http_utils.dart';
import 'package:xiongmao_reader/app/components/load_view.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class NewsInfoDetails extends StatefulWidget {
  final Map item;
  NewsInfoDetails(this.item);
  @override
  _NewsInfoDetailsState createState() => _NewsInfoDetailsState();
}

class _NewsInfoDetailsState extends State < NewsInfoDetails >
  with OnLoadReloadListener {
    LoadStatus _loadStatus = LoadStatus.LOADING;
    Map news = {};
    @override
    void initState() {
      super.initState();
      init(this.widget.item['newsId'].toString());
    }

    init(String indexs) async {
      await HttpUtils.getMessageDetails(indexs).then((response) {
        news = response['data'];
        if(news == null){
            setState(() {
            _loadStatus = LoadStatus.FAILURE;
          });
        }else{
          setState(() {
            _loadStatus = LoadStatus.SUCCESS;
          });
        }
       
      }).catchError((e) {
        setState(() {
          _loadStatus = LoadStatus.FAILURE;
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      return _loadStatus == LoadStatus.LOADING ?
        LoadingView() :
        _loadStatus == LoadStatus.FAILURE ?
        FailureView(this) :  ScrollConfiguration(
        behavior: MyBehavior(),
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.light,
            leading: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.keyboard_arrow_left, color: AppColor.darkGray, ),
            ),
            backgroundColor: Colors.white,
            title: Center(
              child: Text('今日头条',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(48),
                  color: AppColor.darkGray
                )
              ),
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: < Widget > [
                Center(
                  child: Text(news['title'], style: TextStyle(
                    color: AppColor.darkGray,
                    fontSize: ScreenUtil().setSp(40),
                    // height: 14,
                    ), 
                  ),
                ),
                SizedBox(height:20),
                Container(
                  padding: EdgeInsets.only(left:ScreenUtil().setWidth(20)),
                  child:Row(
                    children: <Widget>[
                      Text('来源：'),
                      Text(news['source']),
                    ],
                  ),
                ),
                SizedBox(height:20),
                Container(
                  padding: EdgeInsets.only(left:ScreenUtil().setWidth(20)),
                  child: Row(
                    children: <Widget>[
                      Text('推送时间：'),
                      Text(news['ptime']),
                    ],
                  ),  
                ),
                SizedBox(height:20),
                // CachedNetworkImage(imageUrl: news['cover']),
                // SizedBox(height:20),
                Html(data: _getData(), defaultTextStyle: TextStyle(
                  color: AppColor.darkGray,
                  fontSize: ScreenUtil().setSp(30),
                  height: 2,
                )),
              ],
            ),
          ),
        )
      );
    }
    String _getData(){
      List list = news['images'] as List;
      String content = news['content'];
      if(list != null && list.length > 0){
        for(int i= 0 ;i < list.length;i++){
         content = content.replaceAll(list[i]['position'].toString(), "<img src='"+list[i]['imgSrc'].toString()+"'/>");
        }
      }
      return content;
    }
    @override
    void onReload() {
      setState(() {
        _loadStatus = LoadStatus.LOADING;
      });
      init(this.widget.item['newsId'].toString());
    }
  }
