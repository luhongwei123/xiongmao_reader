import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:xiongmao_reader/app/components/constants.dart';
import 'package:xiongmao_reader/app/components/event_util.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  final String previewImgUrl; //预览图片的地址
  final bool showProgressBar; //是否显示进度条
  final bool showProgressText; //是否显示进度文本
  final int positionTag;
  final String title;

  VideoWidget(this.url,
      {Key key,
      this.previewImgUrl: '',
      this.showProgressBar = true,
      this.showProgressText = true,
      this.positionTag,this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VideoWidgetState();
  }
}

class VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  bool _hideActionButton = true;
  bool videoPrepared = false; //视频是否初始化
  String title;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize()
      ..setLooping(true).then((_) {
          _controller.play();
          videoPrepared = true;
        setState(() {});
      });
      title = widget.title;
      setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    eventBus.off(EventVideoPlayPosition + widget.positionTag.toString());
    _controller.dispose(); //释放播放器资源
  }

  Widget getPreviewImg() {
    return Offstage(
        offstage: videoPrepared,
        child: Image.asset(
          widget.previewImgUrl,
          fit: BoxFit.cover,
          width: ScreenUtil().setWidth(750),
          height:  ScreenUtil().setHeight(1334),
        ));
  }

  getPauseView() {
    return Offstage(
      offstage: _hideActionButton,
      child: Stack(
        children: <Widget>[
          Align(
            child: Container(
                child: Image.asset('asset/ic_playing.png'),
                height: 50,
                width: 50),
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }

  // 分享，转发等功能按钮
  getRightActionView() {
    return Positioned(
        bottom: 0,
        right: 0,
        child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 15, 120),
            child: Column(
              children: <Widget>[
                Container(
                    child: Column(children: <Widget>[
                  Image.asset('asset/video_icon_praise.png',
                      width: 36, height: 36),
                  Text(
                    "1.6w",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  )
                ])),
                SizedBox(height: 8),
                GestureDetector(
                    child: Container(
                        child: Column(children: <Widget>[
                      Image.asset('asset/video_msg_icon.png',
                          width: 36, height: 36),
                      Text(
                        "1.3w",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ])),
                    onTap: () {
                      // Share.share(this.widget.url);
                    }),
                SizedBox(height: 8),
                GestureDetector(
                    child: Container(
                        child: Column(children: <Widget>[
                      Image.asset('asset/video_share_icon.png',
                          width: 36, height: 36),
                      Text(
                        "2.1w",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ])),
                    onTap: () {
                      // Share.share("全最强开源flutter");
                    }),
              ],
            )));
  }

  getLeftActionView() {
    return Positioned(
      child: Container(
          width: ScreenUtil().setWidth(750),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "社会人",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "@社会人",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(height: 8),
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(height: 8),
                      ]),
                ),
                Container(width: ScreenUtil().setWidth(1334), height: 1, color: Colors.white),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "点赞是鼓励，评论才是真爱...",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                    height: 50),
              ])),
      bottom: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GestureDetector(
        child: Stack(
          children: <Widget>[
            VideoPlayer(_controller),
            getPauseView(),
          ],
        ),
        onTap: () {
          if (_controller.value.isPlaying) {
            _controller.pause();
            _hideActionButton = false;
          } else {
            _controller.play();
            videoPrepared = true;
            _hideActionButton = true;
          }
          setState(() {});
        },
      ),
      getPreviewImg(), ///预览图
      getRightActionView(), /// 右侧转发，评论按钮
      getLeftActionView(), /// 左侧文案
    ]);
  }
}
