
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:xiongmao_reader/app/components/event_util.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class VideoPlayerScene extends StatefulWidget {
  final VideoPlayerController _controller;

  VideoPlayerScene(this._controller);
  @override
  _VideoPlayerSceneState createState() => _VideoPlayerSceneState();
}

class _VideoPlayerSceneState extends State < VideoPlayerScene > {
  VideoPlayerController _controller;

  //.network('http://flv2.bn.netease.com/dcbf06c7f0ca3f350a57bf0d15078f335a801549cadcb26296bd8f385c2702f079a5d59ed25b42a2409a8e16b35624a3911c0bf96886fb33a19833066b37ff18dbbbda06927df3330aed992a037edb6f8234ff03c3cae4d7388c5a36e0d64b3cf20d7ae060a20e50c33ade2a44017713ce47d44f4f17d459.mp4')
  Future _initializeVideoPlayerFuture;

  ChewieController chewieController;
  
  StreamSubscription<PageEvent> sss;

  @override
  void initState() {
    super.initState();
    _controller = this.widget._controller;
    _controller.setLooping(true);
    _controller.setVolume(100); 
    _initializeVideoPlayerFuture = _controller.initialize();
    chewieController = ChewieController(
      videoPlayerController: _controller
    );
  }
  @override
  Widget build(BuildContext context) {
    return   
    Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setHeight(20), ScreenUtil().setWidth(20), ScreenUtil().setHeight(20)),
      // height: ScreenUtil().setHeight(200*1.5),
      // width: ScreenUtil().setWidth(375*1.5),
      child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // aspectRatio: _controller.value.aspectRatio,
                  child: Chewie(controller:chewieController),
                ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}