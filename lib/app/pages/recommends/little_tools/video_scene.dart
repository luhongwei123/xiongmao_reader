import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screen/screen.dart';
class VideoPlayerScene extends StatefulWidget {
  final String url;
  final String title;
  VideoPlayerScene(this.url,this.title);
  @override
  _VideoPlayerSceneState createState() => _VideoPlayerSceneState();
}

class _VideoPlayerSceneState extends State < VideoPlayerScene > {
  String videoUrl;
  String videoTitle;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    Screen.keepOn(true);
    setState(() {
      videoUrl = widget.url;
      videoTitle = widget.title;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: videoUrl != "" ?
        AwsomeVideoPlayer(
          videoUrl,
          /// 视频播放配置
          playOptions: VideoPlayOptions(
            seekSeconds: 30,
            aspectRatio: 16 / 9,
            loop: true,
            autoplay: true,
            allowScrubbing: true,
            startPosition: Duration(seconds: 0)),
          /// 自定义视频样式
          videoStyle: VideoStyle(
            /// 自定义顶部控制栏
            videoTopBarStyle: VideoTopBarStyle(
              show: true, //是否显示
              height: 30,
              padding:
              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              barBackgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
              popIcon: Icon(
                Icons.arrow_back,
                size: 16,
                color: Colors.white,
              ),
              contents: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      videoTitle,
                      style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(20)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ], //自定义顶部控制栏中间显示区域
              actions: [
                GestureDetector(
                  onTap: () {
                    ///1. 可配合自定义拓展元素使用，例如广告
                    // setState(() {
                    //   showAdvertCover = true;
                    // });
                    ///
                  },
                  child: Icon(
                    Icons.more_horiz,
                    size: 16,
                    color: Colors.white,
                  ),
                )
              ], //自定义顶部控制栏右侧显示区域
              /// 设置cusotmBar之后，以上属性均无效(除了`show`之外)
              // customBar: Text("123123132")
            ),

            videoControlBarStyle: VideoControlBarStyle(
              /// 自定义颜色
              //barBackgroundColor: Colors.blue,
              /// 自定义进度条样式
              progressStyle: VideoProgressStyle(
                // padding: EdgeInsets.all(0),
                playedColor: Colors.red,
                bufferedColor: Colors.yellow,
                backgroundColor: Colors.green,
                dragBarColor: Colors.white, //进度条为`progress`时有效，如果时`basic-progress`则无效
                height: 4,
                progressRadius: 2, //进度条为`progress`时有效，如果时`basic-progress`则无效
                dragHeight: 5 //进度条为`progress`时有效，如果时`basic-progress`则无效
              ),
              /// 更改进度栏的播放按钮
              playIcon: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 16
              ),
              /// 更改进度栏的暂停按钮
              pauseIcon: Icon(
                Icons.pause,
                color: Colors.red,
                size: 16,
              ),
              /// 更改进度栏的快退按钮
              rewindIcon: Icon(
                Icons.replay_30,
                size: 16,
                color: Colors.white,
              ),
              /// 更改进度栏的快进按钮
              forwardIcon: Icon(
                Icons.forward_30,
                size: 16,
                color: Colors.white,
              ),
              /// 更改进度栏的全屏按钮
              fullscreenIcon: Icon(
                Icons.fullscreen,
                size: 16,
                color: Colors.white,
              ),
              /// 更改进度栏的退出全屏按钮
              fullscreenExitIcon: Icon(
                Icons.fullscreen_exit,
                size: 16,
                color: Colors.red,
              ),
              /// 决定控制栏的元素以及排序，示例见上方图3
              itemList: [
                "rewind",
                "play",
                "forward",
                "position-time", //当前播放时间
                "progress", //线形进度条
                //"basic-progress",//矩形进度条
                "duration-time", //视频总时长
                // "time", //格式：当前时间/视频总时长
                "fullscreen"
              ],
            ),
          ),
          /// 顶部控制栏点击返回按钮
          onpop: (value) {
            Navigator.pop(context);
          },
        ) :
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
            child: CircularProgressIndicator(strokeWidth: 2.0),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
