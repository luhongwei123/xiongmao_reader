import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class BooksSearchScene extends StatefulWidget {
  @override
  _BooksSearchSceneState createState() => _BooksSearchSceneState();
}

class _BooksSearchSceneState extends State < BooksSearchScene > with AutomaticKeepAliveClientMixin, OnLoadReloadListener {
  FocusNode focusNode = new FocusNode();
  TextEditingController controller = TextEditingController();
  int limit = 10;
  int page = 1;
  List bookList;
  LoadStatus _loadStatus = LoadStatus.SUCCESS;

  @override
  void initState() {
    super.initState();
    // _initBookList();
  }
  Future _initBookList(bookName) async {
    await HttpUtils.getListbyName(bookName).then((response) {
      if (bookList != null) {
        bookList.addAll(response['data']['book'] as List);
      } else {
        bookList = response['data']['book'] as List;
      }
      _loadStatus = LoadStatus.SUCCESS;
      setState(() {});
    }).catchError((e) {
      _loadStatus = LoadStatus.FAILURE;
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_arrow_left,color: AppColor.darkGray,),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Row(
          children: < Widget > [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: ScreenUtil().setWidth(480),
                height: ScreenUtil().setHeight(70),
                padding: EdgeInsets.all(0),
                child: TextField(
                  controller: controller,
                  // keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  focusNode: focusNode,
                  maxLines: 1,
                  // enabled: false,
                  style: TextStyle(fontSize: ScreenUtil().setSp(40)),
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: TextStyle(
                      color: AppColor.darkGray,
                      fontSize: ScreenUtil().setSp(25),
                    ),
                    prefixIcon: Icon(Icons.search, color: AppColor.red),
                    contentPadding: EdgeInsets.fromLTRB(
                      0, 0, 0, ScreenUtil().setWidth(28)),
                    filled: true,
                    fillColor: Colors.grey[10],
                    border: InputBorder.none),
                  onChanged: (str) {},
                )
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              child: InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  focusNode.unfocus();
                  _initBookList(controller.text);
                  // Fluttertoast.showToast(msg: controller.text);
                },
                child: Text('搜索', style: TextStyle(
                  color: Colors.black
                ), ),
              ),
            ),
          ],
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _loadStatus == LoadStatus.LOADING ?
      LoadingView() :
      _loadStatus == LoadStatus.FAILURE ?
      FailureView(this) : Container(
      child: (bookList != null && bookList.length > 0) ? ListView(
        children: _buildItem(),
      ) : Container(),
    );
  }

  List < Widget > _buildItem() {
    List < Widget > list = [];
    if (bookList != null && bookList.length > 0) {
      bookList.forEach((item) {
        var widget = InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            child: Row(
              children: < Widget > [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: CachedNetworkImage(
                        imageUrl: Request.baseImageUrl + "${item['id']}",
                        // fit: fit == null ? BoxFit.cover : fit,
                        width: ScreenUtil().setWidth(165),
                        // height: height,
                      )
                    ),
                  ],
                ),
                Column(
                  children: < Widget > [
                    Container(
                      width: ScreenUtil().setWidth(550),
                      child: Text(item['name'],
                        textAlign: TextAlign.left, //文本对齐方式  居中
                        textDirection: TextDirection.ltr, //
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(30),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: ScreenUtil().setWidth(550),
                      child: Text(item['description'],
                        textAlign: TextAlign.left, //文本对齐方式  居中
                        textDirection: TextDirection.ltr, //
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15)
                        ),
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(550),
                      child: Row(
                        children: < Widget > [
                          Image.asset("asset/icon/author.png", width: ScreenUtil().setWidth(30), height: ScreenUtil().setHeight(30)),
                          Text(item['author'],
                            textAlign: TextAlign.left, //文本对齐方式  居中
                            textDirection: TextDirection.ltr,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(15)
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            AppNavigator.toNovelDetail(context, item);
          },
        );
        list.add(widget);
      });
    }
    return list;
  }

  @override
  void onReload() {}

  @override
  bool get wantKeepAlive => true;
}
