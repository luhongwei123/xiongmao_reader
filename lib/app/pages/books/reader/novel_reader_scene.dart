import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/http_request.dart';
import 'package:xiongmao_reader/app/components/load_view.dart';
import 'package:xiongmao_reader/app/model/article_model.dart';
import 'package:xiongmao_reader/app/model/novel_model.dart';
class NovelReaderScene extends StatefulWidget {
  final String novelId;
  final Article article;
  NovelReaderScene({
    this.novelId,
    this.article
  });
  @override
  _NovelReaderSceneState createState() => _NovelReaderSceneState();
}

class _NovelReaderSceneState extends State < NovelReaderScene > with OnLoadReloadListener {

  bool _isNighttime = false; // 夜间模式
  LoadStatus _loadStatus = LoadStatus.LOADING;
  ScrollController _controller;
  String _title = "";
  double _textSizeValue = 18;
  String _content = "";
  double _spaceValue = 1.8;
  bool isMenuVisiable = false;
  double _offset = 0;

  Novel novel;
  static final double _sImagePadding = ScreenUtil().setWidth(40);
  int _duration = 200;

  //test
  Timer _timer;
  int _count = 3; // 倒计时秒数
  
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  void initState() {
    super.initState();
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: _isNighttime ? Color(0xFF333333) : Colors.transparent,
      statusBarBrightness: _isNighttime ? Brightness.dark : Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    _controller = new ScrollController(
        initialScrollOffset: 0, keepScrollOffset: false);
      _controller.addListener(() {
        _offset = _controller.offset;
      });
      
    _spGetTextSizeValue().then((value) {
      // setState(() {
        _textSizeValue = value;
      // });
    });
    _spGetSpaceValue().then((value) {
      // setState(() {
        _spaceValue = value;
      // });
    });
    
    this.widget.novelId == null ? getData('0000') : getData(this.widget.novelId );
  }

  Future < double > _spGetSpaceValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getDouble('spaceValue');
    return value ?? 1.3;
  }

  Future < double > _spGetTextSizeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getDouble('textSizeValue');
    return value ?? 18;
  }

  void getData(articleId) async {
    var response = await Request.get(action: 'article$articleId');
    if ("err" == response) {
      return null;
    }
    //test data待删除
     _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {
        if (_count <= 0) {
          _loadStatus = LoadStatus.SUCCESS;
        } else {
          _count = _count - 1;
        }
      });
    });
    setState(() {
      
      novel = Novel.fromJson(response);
      // _loadStatus = LoadStatus.SUCCESS;
      ///部分小说文字排版有问题，需要特殊处理
      _content = novel.contentAttr
        .replaceAll("\t", "\n")
        .replaceAll("\n\n\n\n", "\n\n");
      _title = novel.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isNighttime ? Colors.black : Colors.white,
      body: Stack(
        children: < Widget > [
          GestureDetector(
            onTapUp: (TapUpDetails details) {
              setState(() {
                isMenuVisiable = !isMenuVisiable;
              });
            },
            child: _loadStatus == LoadStatus.LOADING ?
            LoadingView() :
            _loadStatus == LoadStatus.FAILURE ?
            FailureView(this) : Stack(
              children: < Widget > [
                SingleChildScrollView(
                  controller: _controller,
                  padding: EdgeInsets.fromLTRB(16, 30 + MediaQuery.of(context).padding.top, 9, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: < Widget > [
                      Text(
                        _title,
                        style: TextStyle(
                          fontSize: _textSizeValue + 2,
                          color: Color(0xFF9F8C54),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      Text(
                        _content,
                        style: TextStyle(
                          color: _isNighttime ? AppColor.contentColor : AppColor.black,
                          fontSize: _textSizeValue,
                          height: _spaceValue,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(100),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: _isNighttime ? Colors.black : Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: < Widget > [
                        MaterialButton(
                          minWidth: 125,
                          textColor: AppColor.textPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(125)),
                            side: BorderSide(
                              color: AppColor.textPrimaryColor,
                              width: 1),
                          ),
                          onPressed: () {
                            if (novel.preArticleId == null || novel.preArticleId == '' || novel.preArticleId == "0") {
                              Fluttertoast.showToast(msg: "没有上一章了", fontSize: 14.0);
                            } else {
                              setState(() {
                                _loadStatus = LoadStatus.LOADING;
                              });
                              getData(novel.preArticleId);
                              _controller.jumpTo(0.0);
                              // _controller.animateTo(
                              //   this.widget._initOffset,
                              //   duration:Duration(milliseconds:200),
                              //   curve: Curves.easeInOut
                              // );
                            }
                          },
                          child: Text("上一章"),
                        ),
                        MaterialButton(
                          minWidth: 125,
                          textColor: AppColor.textPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(125)),
                            side: BorderSide(
                              color: AppColor.textPrimaryColor,
                              width: 1),
                          ),
                          onPressed: () {
                            if (novel.nextArticleId == null || novel.nextArticleId == '' || novel.nextArticleId == "0") {
                              Fluttertoast.showToast(msg: "没有下一章了", fontSize: 14.0);
                              return;
                            } else {
                              setState(() {
                                _loadStatus = LoadStatus.LOADING;
                              });
                              getData(novel.nextArticleId);
                              _controller.jumpTo(0.0);
                              // _controller.animateTo(
                              //     this.widget._initOffset,
                              //     duration:Duration(milliseconds:200),
                              //     curve: Curves.easeOut
                              // );
                            }
                          },
                          child: Text("下一章"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // buildMenu(),
          isMenuVisiable ? buildTopView(context) : Container(),
          isMenuVisiable ? buildBottomView() : Container(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).padding.top,
              color: _isNighttime ? Color(0xFF333333) : Color(0xFFF5F5F5),
            ),
          )
        ],
      ),
    );
  }

  @override
  void onReload() {

  }

  hideMenu() {
    setState(() {
      this.isMenuVisiable = false;
    });
  }
  buildTopView(BuildContext context) {
    return Positioned(
      top: MediaQueryData.fromWindow(window).padding.top,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(color: _isNighttime ? Color(0xFF333333) : Color(0xFFF5F5F5)),
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Row(
          children: < Widget > [
            Container(
              width: 44,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('asset/readers/pub_back_gray.png', color: _isNighttime ? Colors.white : Colors.black, ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: 44,
              child: Image.asset('asset/readers/read_icon_voice.png', color: _isNighttime ? Colors.white : Colors.black),
            ),
            Container(
              width: 44,
              child: Image.asset('asset/readers/read_icon_more.png', color: _isNighttime ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  buildBottomView() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: < Widget > [
          Container(
            width: _sImagePadding * 2,
            height: _sImagePadding * 2,
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0, 0, 0),
            child: AnimatedPadding(
              duration: Duration(milliseconds: _duration),
              padding: EdgeInsets.all(0),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    _isNighttime = !_isNighttime;
                  });
                },
                child: Image.asset(
                  _isNighttime ?
                  "asset/readers/icon_content_daytime.png" :
                  "asset/readers/icon_content_nighttime.png",
                  height: 36,
                  width: 36,
                ),
              ),
            ),
          ),
          Container(
            color: _isNighttime ? Color(0xFF333333) : Color(0xFFF5F5F5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: < Widget > [
                Container(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                  child: Text(
                    "字号",
                    style: TextStyle(
                      color: AppColor.contentColor,
                      fontSize: ScreenUtil().setSp(28)),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
                Image.asset(
                  "asset/readers/icon_content_font_small.png",
                  color: _isNighttime ? AppColor.white : AppColor.darkGray,
                  width: ScreenUtil().setWidth(60),
                  height: ScreenUtil().setHeight(40),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      valueIndicatorColor: AppColor.textPrimaryColor,
                      inactiveTrackColor: AppColor.white,
                      activeTrackColor: AppColor.textPrimaryColor,
                      activeTickMarkColor: Colors.transparent,
                      inactiveTickMarkColor: Colors.transparent,
                      trackHeight: 2.5,
                      thumbShape:
                      RoundSliderThumbShape(enabledThumbRadius: 8),
                    ),
                    child: Slider(
                      value: _textSizeValue,
                      label: "字号：$_textSizeValue",
                      divisions: 30,
                      min: 15,
                      max: 45,
                      onChanged: (double value) {
                        setState(() {
                          _textSizeValue = value;
                        });
                      },
                      onChangeEnd: (value) {
                        _spSetTextSizeValue(value);
                      },
                    ),
                  ),
                ),
                Image.asset(
                  "asset/readers/icon_content_font_big.png",
                  color: _isNighttime ? AppColor.white : AppColor.darkGray,
                  width: ScreenUtil().setWidth(60),
                  height: ScreenUtil().setHeight(40),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
              ],
            ),
          ),
          Container(
            color: _isNighttime ? Color(0xFF333333) : Color(0xFFF5F5F5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: < Widget > [
                Container(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                  child: Text(
                    "间距",
                    style: TextStyle(
                      color: AppColor.contentColor,
                      fontSize: ScreenUtil().setSp(28)),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
                Image.asset(
                  "asset/readers/icon_content_space_big.png",
                  color: _isNighttime ? AppColor.white : AppColor.darkGray,
                  width: ScreenUtil().setWidth(60),
                  height: ScreenUtil().setHeight(40),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      valueIndicatorColor: AppColor.textPrimaryColor,
                      inactiveTrackColor: AppColor.white,
                      activeTrackColor: AppColor.textPrimaryColor,
                      activeTickMarkColor: Colors.transparent,
                      inactiveTickMarkColor: Colors.transparent,
                      trackHeight: 2.5,
                      thumbShape:
                      RoundSliderThumbShape(enabledThumbRadius: 8),
                    ),
                    child: Slider(
                      value: _spaceValue,
                      label: "字间距：$_spaceValue",
                      min: 1.0,
                      divisions: 20,
                      max: 3.0,
                      onChanged: (double value) {
                        setState(() {
                          _spaceValue = value;
                        });
                      },
                      onChangeEnd: (value) {
                        _spSetSpaceValue(value);
                      },
                    ),
                  ),
                ),
                Image.asset(
                  "asset/readers/icon_content_space_small.png",
                  color: _isNighttime ? AppColor.white : AppColor.darkGray,
                  width: ScreenUtil().setWidth(60),
                  height: ScreenUtil().setHeight(40),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(color: _isNighttime ? Color(0xFF333333) : Color(0xFFF5F5F5)),
            padding: EdgeInsets.only(bottom: ScreenUtil.bottomBarHeight),
            child: Column(
              children: < Widget > [
                buildBottomMenus(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _spSetTextSizeValue(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('textSizeValue', value);
  }
  _spSetSpaceValue(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('spaceValue', value);
  }
  buildBottomMenus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: < Widget > [
        buildBottomItem('目录', 'asset/readers/read_icon_catalog.png'),
        buildBottomItem('亮度', 'asset/readers/read_icon_brightness.png'),
        // buildBottomItem('字体', 'asset/readers/read_icon_font.png'),
        buildBottomItem('设置', 'asset/readers/read_icon_setting.png'),
      ],
    );
  }

  buildBottomItem(String title, String icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: < Widget > [
          Image.asset(icon, color: _isNighttime ? Colors.white : Colors.black),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 12, color: _isNighttime ? Colors.white : Colors.black)),
        ],
      ),
    );
  }
}
